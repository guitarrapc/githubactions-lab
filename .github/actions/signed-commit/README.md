# Signed Commit Action

Create signed commits using GitHub API. Commits created via GitHub API are automatically verified.

## Features

- ✅ Automatic commit signing (Verified badge)
- ✅ Supports large files
- ✅ Handles file additions, modifications, and deletions
- ✅ Directory expansion
- ✅ Retry logic for concurrent updates
- ✅ No "Argument list too long" errors

## Usage

```yaml
- uses: ./.github/actions/signed-commit
  with:
    commit-message: "Update files"
    repository: ${{ github.repository }}
    ref: main
    github-token: ${{ github.token }}
    working-directory: .
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `commit-message` | Commit message | Yes | - |
| `repository` | Target repository (owner/repo) | Yes | - |
| `ref` | Branch name to commit to | Yes | - |
| `github-token` | GitHub token with repo permissions | Yes | - |
| `working-directory` | Working directory to scan for changes | No | `.` |

## Outputs

| Output | Description |
|--------|-------------|
| `commit-sha` | SHA of the created commit |
| `tree-sha` | SHA of the created tree |
| `changed-files` | List of changed files (one per line) |

## How It Works

1. Scans for changed files using `git status --porcelain=v1`
2. Creates blobs for each changed file via GitHub API
3. Creates a tree with the new blobs
4. Creates a commit with the tree (automatically signed)
5. Updates the branch reference

## Why Signed Commits?

Commits created via GitHub API are automatically signed by GitHub, showing the "Verified" badge. This provides:

- Authentication that the commit came from a trusted source
- Integrity verification
- Better security for automated workflows

## Installation

```bash
cd .github/actions/signed-commit
npm install
```

## Development

The action is written in pure JavaScript (Node.js 20) using:
- `@actions/core` - GitHub Actions toolkit
- `@actions/exec` - Execute git commands
- `@octokit/rest` - GitHub API client

No build step required - the action runs directly.
