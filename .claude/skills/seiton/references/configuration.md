# seiton Configuration Reference

Configuration file format, discovery, and all available settings.

## File Discovery

Seiton searches for config in this order (first found wins):

1. `--config <path>` CLI flag
2. `SEITON_CONFIG` environment variable
3. `.github/seiton.yaml`
4. `.github/seiton.yml`
5. `seiton.yaml`
6. `seiton.yml`

No config file is required. All defaults are safe.

## Generate Starter Config

```bash
seiton init
```

Creates `.github/seiton.yaml` with commented defaults.

## Full Schema

```yaml
# .github/seiton.yaml

# ─── Rule settings ───────────────────────────────────────────────────────────
rules:
  <rule-id>:
    enabled: true|false          # Enable or disable a rule
    severity: info|warning|error # Override default severity

    # Rule-specific options (varies by rule):
    # dangerous-triggers:
    #   events: [issue_comment]
    # runner-label:
    #   known-hosted-labels: [ubuntu-24.04-arm]
    # runner-no-latest:
    #   fix-mapping:
    #     ubuntu-latest: "ubuntu-24.04"
    # credentials:
    #   public-registries: [registry.example.com]
    # cache-poisoning:
    #   untrusted-triggers: [issue_comment]
    # self-hosted-runner:
    #   untrusted-triggers: [issue_comment]
    # unredacted-secrets:
    #   output-commands: [tee]
    # expr-undefined-var:
    #   assume-events: [workflow_dispatch]
    # forbidden-uses:
    #   deny: ["deprecated-org/*"]
    #   allow: ["approved-org/*"]
    # unpinned-uses:
    #   ignore-actions:
    #     - owner: "my-org/internal-action"
    #     - owner: "my-org/*"
    #       refs: [main]

# ─── Exclusions ──────────────────────────────────────────────────────────────
exclusions:
  - file: "<glob-pattern>"       # Path glob for workflow files
    jobs:                        # Optional: limit to specific jobs
      - <job-id>
    rules:                       # Rules to suppress
      - <rule-id>

# ─── Fix settings ────────────────────────────────────────────────────────────
fix:
  defaults:
    job-timeout-minutes: 15      # Default for job-timeout-minutes-required fix

  pinning:
    enable-network: false        # Allow network SHA resolution
    min-age-days: 14             # Minimum commit age for SHA pins
    exclude-branches:            # Skip pinning for these refs
      - main
    ignore-actions:              # Skip pinning for matched patterns
      - uses: "slsa-framework/*"
        ref: "*"

  images:
    enable-network: false        # Allow network digest resolution
    exclude-images: [scratch]    # Skip these image names
    exclude-tags: [latest]       # Skip these tags
    ignore-images:               # Skip glob-matched images
      - "mcr.microsoft.com/**"

# ─── Network settings ────────────────────────────────────────────────────────
network:
  on-error: skip                 # skip | fail
  timeout-seconds: 30           # Per-request timeout
  max-concurrency: 4            # Max parallel API requests
  github:
    ghes-api-url: ""            # GHES REST API URL (empty = github.com)
    ghes-fallback: false        # Fall back to github.com on GHES failure

# ─── Output settings ─────────────────────────────────────────────────────────
output:
  sort-order: location           # location | rule
```

## Common Patterns

### Disable a noisy rule

```yaml
rules:
  runner-no-latest:
    enabled: false
```

### Enable online audit rules

```yaml
rules:
  known-vulnerable-actions:
    enabled: true
  impostor-commit:
    enabled: true
```

Requires `GITHUB_TOKEN` or `SEITON_GITHUB_TOKEN`.

### Suppress a rule for specific files

```yaml
exclusions:
  - file: ".github/workflows/legacy-*.yml"
    rules:
      - unpinned-uses
      - runner-no-latest
```

### Suppress within a specific job

```yaml
exclusions:
  - file: ".github/workflows/deploy.yml"
    jobs:
      - publish
    rules:
      - credentials
```

### Pin runner versions with fix mapping

```yaml
rules:
  runner-no-latest:
    fix-mapping:
      ubuntu-latest: "ubuntu-24.04"
      windows-latest: "windows-2025"
      macos-latest: "macos-15"
```

### Trust internal actions from pinning

```yaml
rules:
  unpinned-uses:
    ignore-actions:
      - owner: "my-org/*"
        refs: [main, master]
```

## Validation

```bash
# Check config file for errors
seiton validate-config

# Show which config file is loaded
seiton check --verbose
# Prints: verbose: config: /path/to/.github/seiton.yaml
```

## Error Messages

| Condition | Message |
|-----------|---------|
| Unknown top-level key | `unknown top-level key '<key>'` |
| Unknown rule ID | `unknown rule-id '<id>'. Did you mean '<suggestion>'?` |
| Invalid severity | `severity must be one of info, warning, error` |
| Invalid rule option | `unknown rule option '<key>'` |
| YAML syntax error | `invalid lint config YAML: <details>` |
