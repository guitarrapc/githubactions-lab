# Git Push Action

Composite action for committing and pushing changes. Supports both signed commits (via GitHub API) and traditional git commits.

## Features

- ✅ **Signed Commits** - Creates verified commits using GitHub API (default)
- ✅ **Traditional Commits** - Falls back to regular git commit if needed
- ✅ **Change Detection** - Automatically detects changes using `git status`
- ✅ **Outputs** - Provides changed files and directory stats
- ✅ **Large Files** - No argument list limitations
- ✅ **Retry Logic** - Handles concurrent updates gracefully

## Usage

### Basic Usage (Signed Commits)

```yaml
- uses: ./.github/actions/git-push
  with:
    commit-message: "Update files"
    ref: main
    github-token: ${{ github.token }}
```

### Legacy Mode (No Signature)

```yaml
- uses: ./.github/actions/git-push
  with:
    commit-message: "Update files"
    ref: main
    github-token: ${{ github.token }}
    sign-commits: "false"  # Use traditional git commit
```

### Full Options

```yaml
- uses: ./.github/actions/git-push
  with:
    commit-message: "[automated] Update manifests"
    repository: ${{ github.repository }}
    ref: main
    github-token: ${{ steps.app-token.outputs.token }}
    sign-commits: "true"
    working-directory: .
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `commit-message` | Commit message | Yes | - |
| `repository` | Target repository (owner/repo) | No | `${{ github.repository }}` |
| `ref` | Branch name to commit to | Yes | - |
| `github-token` | GitHub token | Yes | - |
| `sign-commits` | Create signed commits via API | No | `"true"` |
| `working-directory` | Working directory | No | `.` |

## Outputs

| Output | Description |
|--------|-------------|
| `changed` | Whether there are changes (`"0"` or `"1"`) |
| `changed-files` | List of changed files (one per line) |
| `changed-dirs` | Changed directories with stats |

## Architecture

This action is a composite action that orchestrates two approaches:

### 1. Signed Commits (default, `sign-commits: "true"`)

Uses the [signed-commit](../signed-commit/) JavaScript action internally:
- Calls GitHub API to create blobs, trees, and commits
- Commits are automatically verified by GitHub
- No shell script limitations (argument list, escaping, etc.)

```
git-push (composite)
  └─> signed-commit (JavaScript action)
        └─> @octokit/rest
```

### 2. Legacy Mode (`sign-commits: "false"`)

Uses traditional git commands:
- `git commit` + `git push`
- No signature/verification
- Simpler but not verified

## Why Two Modes?

| Feature | Signed Commits | Legacy Mode |
|---------|---------------|-------------|
| Verified badge | ✅ Yes | ❌ No |
| Large files | ✅ Works | ⚠️ May fail |
| Complexity | Medium | Simple |
| API calls | Yes | No |
| Recommended | ✅ | Only if needed |

## Examples

### With GitHub App Token

```yaml
- uses: actions/create-github-app-token@v2
  id: app-token
  with:
    app-id: ${{ secrets.APP_ID }}
    private-key: ${{ secrets.PRIVATE_KEY }}

- uses: ./.github/actions/git-push
  with:
    commit-message: "[automated] Update"
    ref: main
    github-token: ${{ steps.app-token.outputs.token }}
```

### To Different Repository

```yaml
- uses: actions/checkout@v4
  with:
    repository: owner/other-repo
    path: other-repo
    token: ${{ steps.app-token.outputs.token }}

- uses: ./.github/actions/git-push
  with:
    commit-message: "Update manifests"
    repository: owner/other-repo
    ref: main
    github-token: ${{ steps.app-token.outputs.token }}
    working-directory: other-repo
```

### Using Outputs

```yaml
- id: push
  uses: ./.github/actions/git-push
  with:
    commit-message: "Format code"
    ref: main
    github-token: ${{ github.token }}

- name: Create PR if changes
  if: steps.push.outputs.changed == '1'
  run: |
    echo "Changed files:"
    echo "${{ steps.push.outputs.changed-files }}"

    echo "Changed directories:"
    echo "${{ steps.push.outputs.changed-dirs }}"
```

## Development

The action consists of:

1. **git-push/action.yaml** - Composite action (this directory)
   - Detects changes
   - Calls signed-commit or uses git commands

2. **signed-commit/** - JavaScript action
   - See [signed-commit/README.md](../signed-commit/README.md)

## Migration from Bash Script

Previously this action contained a 300+ line bash script with curl/jq. That has been migrated to a JavaScript action for:

- Better maintainability
- No shell script limitations
- Easier testing
- Type safety
- Better error handling

The old bash implementation had issues with:
- "Argument list too long" errors
- JSON escaping problems
- Complex file handling

All resolved in the JavaScript version.
