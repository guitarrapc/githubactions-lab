# Cheet Sheet

GitHub Actions cheet sheet.

# Table of Contents

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<details>
<summary>Details</summary>

- [Get Tag, Branch](#get-tag-branch)
- [Get Workflow Name](#get-workflow-name)
- [Get Workflow Url](#get-workflow-url)
- [GitHub Actions commit icon](#github-actions-commit-icon)

</details>
<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Get Tag, Branch

```yaml
- run: echo "${GITHUB_REF##*/}"
```

This will remove `refs/heads` or `refs/tags` from `refs/heads/xxxxx` and `refs/tags/v1.0.0`.

* `refs/heads/xxxxx` -> `xxxxx`
* `refs/tags/v1.0.0` -> `v1.0.0`

Save it to `step context` and refer from other step or save it to env is much eacher.

```yaml
# .github/workflows/tag_push_only_context.yaml

name: tag push context

on:
  push:
    tags:
      - "**" # only tag

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "::set-output name=GIT_TAG::${GITHUB_REF##*/}"
        id: CI_TAG
      - run: echo ${{ steps.CI_TAG.outputs.GIT_TAG }}
      - run: echo "GIT_TAG=${GITHUB_REF##*/}" >> "$GITHUB_ENV"
      - run: echo ${{ env.GIT_TAG }}
```


## Get Workflow Name

```yaml
${{ github.workflow }}
```

## Get Workflow Url

```yaml
${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}
```

## GitHub Actions commit icon

Use following git config to commit as GitHub Actions icon.

```shell
git config user.name github-actions[bot]
git config user.email 41898282+github-actions[bot]@users.noreply.github.com
```
