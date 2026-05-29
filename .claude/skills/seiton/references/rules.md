# seiton Rules Reference

All lint rules, their default severity, auto-fix availability, and document scope.

## Rule Table

| Rule ID | Severity | Fix | Scope | Default |
|---------|----------|-----|-------|---------|
| job-structure | error | no | both | on |
| reusable-workflow | error | no | both | on |
| permissions | mixed | no | both | on |
| popular-action-inputs | warning | yes | both | on |
| unpinned-uses | mixed | yes | both | on |
| unpinned-image | warning | yes | both | on |
| dangerous-triggers | warning | no | both | on |
| job-permissions-required | warning | yes | both | on |
| needs-graph | error | no | both | on |
| shell-name | mixed | no | both | on |
| runner-label | mixed | no | both | on |
| id-naming | error | yes | both | on |
| glob-pattern | error | no | both | on |
| dispatch-inputs | error | no | both | on |
| schedule-event | error | no | both | on |
| deny-write-all | error | yes | both | on |
| credentials | mixed | no | both | on |
| template-injection | error | yes | both | on |
| expr-undefined-var | error | no | both | on |
| run-env-context-direct-use | error | yes | both | on |
| runner-no-latest | warning | yes | both | on |
| run-secrets-context-direct-use | error | yes | both | on |
| run-inputs-context-direct-use | error | yes | both | on |
| secrets-whole-context-access | error | no | both | on |
| checkout-persist-credentials | warning | yes | both | on |
| deny-read-all | error | yes | both | on |
| deny-inherit-secrets | error | no | both | on |
| job-timeout-minutes-required | error | yes | both | on |
| github-app-token-inputs | error | no | both | on |
| cache-poisoning | warning | no | both | on |
| self-hosted-runner | warning | no | both | on |
| unredacted-secrets | warning | no | both | on |
| secrets-outside-env | warning | no | both | on |
| workflow-secrets | error | no | both | on |
| job-secrets | error | no | both | on |
| action-shell-is-required | error | no | action | on |
| matrix | warning | no | both | on |
| env-var | warning | no | both | on |
| deprecated-commands | warning | no | both | on |
| if-cond | warning | no | both | on |
| fake-ternary | warning | no | both | on |
| archived-uses | warning | no | both | on |
| insecure-commands | warning | no | both | on |
| overprovisioned-secrets | warning | no | both | on |
| forbidden-uses | warning | no | both | on |
| ref-version-mismatch | warning | no | both | on |
| use-trusted-publishing | warning | no | both | on |
| local-action-inputs | mixed | no | workflow | on |
| workflow-call-input-default | error | no | both | on |
| outdated-action-runner | error | no | both | on |
| if-expr-wrapper | warning | yes | both | on |
| concurrency-limits | warning | no | workflow | opt-in |
| unsound-condition | warning | yes | both | on |
| unpinned-tools | warning | no | both | on |
| unsound-contains | mixed | no | workflow | on |
| bot-conditions | mixed | no | workflow | on |
| artipacked | mixed | no | workflow | on |
| known-vulnerable-actions | error | no | workflow | opt-in |
| impostor-commit | error | no | workflow | opt-in |
| ref-confusion | error | no | workflow | opt-in |
| stale-action-refs | warning | no | workflow | opt-in |

## Severity Levels

- **error**: Must fix. Blocks CI if using `--min-severity error`.
- **warning**: Should fix. Best-practice violation.
- **mixed**: Rule emits both errors and warnings depending on context.

## Opt-in Rules

These rules are disabled by default. Enable in `.github/seiton.yaml`:

```yaml
rules:
  known-vulnerable-actions:
    enabled: true
  impostor-commit:
    enabled: true
  ref-confusion:
    enabled: true
  stale-action-refs:
    enabled: true
  concurrency-limits:
    enabled: true
```

Online rules (`known-vulnerable-actions`, `impostor-commit`, `ref-confusion`, `stale-action-refs`) require `GITHUB_TOKEN` or `SEITON_GITHUB_TOKEN`.

## Rule Categories

### Security

`template-injection`, `credentials`, `secrets-whole-context-access`, `run-secrets-context-direct-use`, `run-env-context-direct-use`, `run-inputs-context-direct-use`, `unredacted-secrets`, `secrets-outside-env`, `insecure-commands`, `cache-poisoning`, `self-hosted-runner`, `dangerous-triggers`, `known-vulnerable-actions`, `impostor-commit`, `ref-confusion`

### Pinning & Supply Chain

`unpinned-uses`, `unpinned-image`, `unpinned-tools`, `checkout-persist-credentials`, `archived-uses`, `forbidden-uses`, `ref-version-mismatch`, `stale-action-refs`, `use-trusted-publishing`

### Permissions

`permissions`, `job-permissions-required`, `deny-write-all`, `deny-read-all`, `deny-inherit-secrets`, `overprovisioned-secrets`, `workflow-secrets`, `job-secrets`

### Correctness

`job-structure`, `reusable-workflow`, `needs-graph`, `dispatch-inputs`, `schedule-event`, `glob-pattern`, `expr-undefined-var`, `popular-action-inputs`, `local-action-inputs`, `github-app-token-inputs`, `workflow-call-input-default`, `matrix`, `if-cond`, `unsound-condition`, `unsound-contains`, `bot-conditions`

### Style & Best Practice

`id-naming`, `shell-name`, `runner-label`, `runner-no-latest`, `env-var`, `deprecated-commands`, `fake-ternary`, `if-expr-wrapper`, `job-timeout-minutes-required`, `outdated-action-runner`, `concurrency-limits`, `artipacked`

## Disabling a Rule

```yaml
rules:
  runner-no-latest:
    enabled: false
```

## Overriding Severity

```yaml
rules:
  checkout-persist-credentials:
    severity: error
```
