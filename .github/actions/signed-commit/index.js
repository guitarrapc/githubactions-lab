const core = require('@actions/core');
const exec = require('@actions/exec');
const { Octokit } = require('@octokit/rest');
const fs = require('fs');
const path = require('path');

/**
 * Get changed files using git status --porcelain=v1
 */
async function getChangedFiles(workingDirectory) {
  let output = '';
  let error = '';

  const options = {
    cwd: workingDirectory,
    listeners: {
      stdout: (data) => { output += data.toString(); },
      stderr: (data) => { error += data.toString(); }
    },
    silent: true
  };

  await exec.exec('git', ['status', '--porcelain=v1'], options);

  if (!output.trim()) {
    return [];
  }

  const files = [];
  const lines = output.trim().split('\n');

  for (const line of lines) {
    if (!line) continue;

    const status = line.substring(0, 2);
    let filePath = line.substring(3);

    // Handle renamed files
    if (status.includes('R')) {
      const parts = filePath.split(' -> ');
      filePath = parts[parts.length - 1];
    }

    files.push({
      path: filePath,
      status: status.trim(),
      deleted: status.includes('D')
    });
  }

  return files;
}

/**
 * Expand directories to individual files
 */
async function expandFiles(files, workingDirectory) {
  const expanded = [];

  for (const file of files) {
    const fullPath = path.join(workingDirectory, file.path);

    // Check if it's a directory (ends with /)
    if (file.path.endsWith('/')) {
      // Find all files in directory
      const findFiles = (dir) => {
        const entries = fs.readdirSync(dir, { withFileTypes: true });
        for (const entry of entries) {
          const fullEntryPath = path.join(dir, entry.name);
          if (entry.isDirectory()) {
            findFiles(fullEntryPath);
          } else if (entry.isFile()) {
            const relativePath = path.relative(workingDirectory, fullEntryPath);
            expanded.push({
              path: relativePath.replace(/\\/g, '/'), // Normalize path separators
              status: file.status,
              deleted: false
            });
          }
        }
      };

      if (fs.existsSync(fullPath) && fs.statSync(fullPath).isDirectory()) {
        findFiles(fullPath);
      }
    } else {
      expanded.push(file);
    }
  }

  return expanded;
}

/**
 * Create blobs for files
 */
async function createBlobs(octokit, owner, repo, files, workingDirectory) {
  const treeItems = [];

  for (const file of files) {
    core.info(`Processing file: ${file.path} (status: ${file.status})`);

    // Handle deleted files
    if (file.deleted) {
      core.info(`File deleted: ${file.path}`);
      treeItems.push({
        path: file.path,
        mode: '100644',
        type: 'blob',
        sha: null
      });
      continue;
    }

    const fullPath = path.join(workingDirectory, file.path);

    // Skip if not a regular file
    if (!fs.existsSync(fullPath) || !fs.statSync(fullPath).isFile()) {
      core.warning(`Skipping non-file: ${file.path}`);
      continue;
    }

    // Detect file mode
    const stats = fs.statSync(fullPath);
    const mode = (stats.mode & 0o111) ? '100755' : '100644';

    // Read file and create blob
    const content = fs.readFileSync(fullPath, { encoding: 'base64' });

    core.debug(`Creating blob for ${file.path} (${content.length} bytes base64)`);

    const blob = await octokit.rest.git.createBlob({
      owner,
      repo,
      content,
      encoding: 'base64'
    });

    core.info(`Created blob for ${file.path}: ${blob.data.sha} (mode: ${mode})`);

    treeItems.push({
      path: file.path,
      mode,
      type: 'blob',
      sha: blob.data.sha
    });
  }

  return treeItems;
}

/**
 * Main function
 */
async function run() {
  try {
    // Get inputs
    const commitMessage = core.getInput('commit-message', { required: true });
    const repository = core.getInput('repository', { required: true });
    const ref = core.getInput('ref', { required: true });
    const token = core.getInput('github-token', { required: true });
    const workingDirectory = core.getInput('working-directory') || '.';

    // Parse repository
    const [owner, repo] = repository.split('/');
    if (!owner || !repo) {
      throw new Error(`Invalid repository format: ${repository}. Expected: owner/repo`);
    }

    // Normalize ref
    const refName = ref.replace(/^refs\/heads\//, '').replace(/^heads\//, '');
    core.info(`Normalized ref: ${refName}`);

    // Initialize Octokit
    const octokit = new Octokit({ auth: token });

    // Get current commit SHA
    core.info(`Getting current commit SHA for ref: ${refName}`);
    const refData = await octokit.rest.git.getRef({
      owner,
      repo,
      ref: `heads/${refName}`
    });
    const currentSha = refData.data.object.sha;
    core.info(`Current commit SHA: ${currentSha}`);

    // Get changed files
    core.info('Getting changed files...');
    let changedFiles = await getChangedFiles(workingDirectory);

    if (changedFiles.length === 0) {
      core.info('No changed files detected');
      core.setOutput('commit-sha', '');
      core.setOutput('tree-sha', '');
      core.setOutput('changed-files', '');
      return;
    }

    core.info(`Found ${changedFiles.length} changed entries`);

    // Expand directories to individual files
    changedFiles = await expandFiles(changedFiles, workingDirectory);
    core.info(`Expanded to ${changedFiles.length} files`);

    // Create blobs
    core.info('Creating blobs for changed files...');
    const treeItems = await createBlobs(octokit, owner, repo, changedFiles, workingDirectory);

    if (treeItems.length === 0) {
      core.info('No valid files to commit after filtering');
      core.setOutput('commit-sha', '');
      core.setOutput('tree-sha', '');
      core.setOutput('changed-files', '');
      return;
    }

    // Create tree
    core.info('Creating tree...');
    const tree = await octokit.rest.git.createTree({
      owner,
      repo,
      base_tree: currentSha,
      tree: treeItems
    });
    core.info(`Created tree: ${tree.data.sha}`);

    // Create commit
    core.info('Creating commit...');
    const commit = await octokit.rest.git.createCommit({
      owner,
      repo,
      message: commitMessage,
      tree: tree.data.sha,
      parents: [currentSha]
    });
    core.info(`Created commit: ${commit.data.sha}`);

    // Update reference with retry logic
    const maxRetries = 3;
    let retryCount = 0;
    let success = false;

    while (retryCount < maxRetries && !success) {
      try {
        core.info(`Attempting to update ref (${retryCount + 1}/${maxRetries})...`);

        await octokit.rest.git.updateRef({
          owner,
          repo,
          ref: `heads/${refName}`,
          sha: commit.data.sha,
          force: false
        });

        core.info(`Successfully updated reference to: ${commit.data.sha}`);
        success = true;
      } catch (error) {
        core.warning(`Failed to update reference: ${error.message}`);
        retryCount++;

        if (retryCount < maxRetries) {
          core.info('Fetching latest changes and retrying...');

          // Get new base commit
          const newRefData = await octokit.rest.git.getRef({
            owner,
            repo,
            ref: `heads/${refName}`
          });
          const newBaseSha = newRefData.data.object.sha;

          // Recreate commit with new parent
          const newCommit = await octokit.rest.git.createCommit({
            owner,
            repo,
            message: commitMessage,
            tree: tree.data.sha,
            parents: [newBaseSha]
          });

          core.info(`Created new commit with updated parent: ${newCommit.data.sha}`);
          commit.data.sha = newCommit.data.sha;
        } else {
          throw new Error(`Failed to update reference after ${maxRetries} retries`);
        }
      }
    }

    // Set outputs
    core.setOutput('commit-sha', commit.data.sha);
    core.setOutput('tree-sha', tree.data.sha);
    core.setOutput('changed-files', changedFiles.map(f => f.path).join('\n'));

    core.info('✓ Signed commit created successfully');

  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
