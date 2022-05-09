<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<details>
<summary>Details</summary>

- [Cheat Sheet](#cheat-sheet)
  - [Get Tag, Branch](#get-tag-branch)
  - [Get Workflow Name](#get-workflow-name)
  - [Get Workflow Url](#get-workflow-url)

</details>
<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Cheat Sheet

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
