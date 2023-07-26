# Cheet Sheet

GitHub Actions cheet sheet.

# Table of Contents

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# Table of Contents

- [Get Tag, Branch](#get-tag-branch)
- [Get Workflow Name](#get-workflow-name)
- [Get Workflow Url](#get-workflow-url)
- [GitHub Actions commit icon](#github-actions-commit-icon)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Get Tag, Branch

```yaml
- run: echo "${GITHUB_REF##*/}"
```

This will remove `refs/heads` or `refs/tags` from `refs/heads/xxxxx` and `refs/tags/v1.0.0`.

* `refs/heads/xxxxx` -> `xxxxx`
* `refs/tags/v1.0.0` -> `v1.0.0`

## Get Workflow Name

```
${{ github.workflow }}
```

## Get Workflow Url

```
${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}
```

## GitHub Actions commit icon

Use following git config to commit as GitHub Actions icon.

```shell
git config user.name github-actions[bot]
git config user.email 41898282+github-actions[bot]@users.noreply.github.com
```
