---
name: seiton
description: Lint and fix GitHub Actions workflow files and action metadata files using seiton CLI.
---

# seiton

Seiton is a linter and auto-fixer for GitHub Actions workflow files (`.github/workflows/*.yml`) and action metadata files (`action.yml`).

## Quick Start

```bash
# Lint all workflows in the current repository
seiton

# Preview fixes without applying
seiton --fix --dry-run

# Apply auto-fixes
seiton --fix

# Pin actions and images via network
seiton --fix --enable-pin-network --enable-image-network
```

## Commands

| Command | Description |
|---------|-------------|
| `seiton` | Lint workflows (default) |
| `seiton check` | Explicit lint (same as default) |
| `seiton --fix` | Apply auto-fixes in place |
| `seiton --fix --dry-run` | Preview fixes as unified diff |
| `seiton --fix --check` | Exit non-zero if fixable issues exist |
| `seiton init` | Generate starter config at `.github/seiton.yaml` |
| `seiton install` | Install agent skill files and CI workflow templates |
| `seiton rules` | List all lint rules and their status |
| `seiton validate-config` | Validate the config file |
| `seiton version` | Show version info |

## Key Flags

| Flag | Description |
|------|-------------|
| `--config PATH` | Explicit config file path |
| `--format text, json, sarif` | Output format |
| `--min-severity error, warning, info` | Filter by severity |
| `--ignore PATTERN` | Suppress diagnostics matching pattern |
| `--oneline` | One diagnostic per line |
| `--verbose` | Show progress and timing info |
| `--include-actions` | Include `.github/actions/` in discovery |
| `--enable-pin-network` | Resolve action SHAs via network (fix mode) |
| `--enable-image-network` | Resolve image digests via network (fix mode) |

## Output Format

Default rich text output shows:

```
error[rule-id]: message
  --> file.yml:12:5
     |
  12 |     source line
     |     ^^^^^^^^^^^
     |
   = help: suggestion
```

## Exit Codes

| Code | Meaning |
|------|---------|
| `0` | No issues found |
| `1` | Lint issues found |
| `2` | Invalid CLI options |
| `3` | Fatal error (config error, I/O failure) |

## Recommended Workflow

1. Run `seiton` to identify issues
2. Run `seiton --fix --dry-run` to preview available fixes
3. Run `seiton --fix` to apply fixes
4. For pinning: `seiton --fix --enable-pin-network --enable-image-network`

## Configuration

Config is auto-discovered from `.github/seiton.yaml` (or `.github/seiton.yml`, `seiton.yaml`, `seiton.yml`).

Generate a starter config:

```bash
seiton init
```

## Troubleshooting

- **Config errors**: Run `seiton validate-config` to check configuration
- **Unknown option**: seiton suggests the closest valid option with a `Did you mean` hint
- **Too many warnings**: Use `--min-severity error` to focus on errors only
- **CI integration**: Use `--format sarif` for GitHub Code Scanning upload

## References

- `references/rules.md` — All rule IDs, severities, fix support, and categories
- `references/fix-mode.md` — Auto-fix commands, flags, and configuration
- `references/configuration.md` — Full seiton.yaml schema and common patterns
