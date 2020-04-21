githubaction-lab

language | badge
---- | ----
dotnet | ![build](https://github.com/guitarrapc/githubaction-lab/workflows/build/badge.svg?branch=master)

## Not yet support

- [ ] Path Filter
  - [Path filtering for jobs and steps \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/Path-filtering-for-jobs-and-steps/td-p/33617)
- [ ] Manual Trigger
- [ ] Approval
  - [GitHub Actions Manual Trigger / Approvals \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/GitHub-Actions-Manual-Trigger-Approvals/m-p/31504)
- [ ] reuse worldflow yaml
  - [Solved: Is it possible to reuse workflow yaml to setup sim\.\.\. \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/Is-it-possible-to-reuse-workflow-yaml-to-setup-similar-workflows/td-p/40634)
- [ ] YAML anchor support
  - [Support for YAML anchors \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/Support-for-YAML-anchors/td-p/30336)

## Diff with other CI

* CircleCI: [Migrating from Github Actions \- CircleCI](https://circleci.com/docs/2.0/migrating-from-github/)

## fundamentals

### Meta github context

job id, name and others.

> [Context and expression syntax for GitHub Actions \- GitHub Help](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context)

### View Webhook GitHub Context

```yaml
name: view github context

on: ["push"]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo $GITHUB_CONTEXT
        env:
          GITHUB_CONTEXT: ${{ toJson(github) }}
```

### runs only previous job is success

to accomplish sequential job run, use `needs:` for which you want the job to depends on.

this enforce job to be run when only previous job is **success**.

```yaml
name: sequential jobs

on: ["push"]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo $COMMIT_MESSAGES
        env:
          COMMIT_MESSAGES: ${{ toJson(github.event.commits.*.message) }}

  publish:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - run: run when only build success
```

### runs only previous step status is ...

> [job-status-check-functions \- Context and expression syntax for GitHub Actions \- GitHub Help](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#job-status-check-functions)

use `if:` you want set step to be run on particular status.

```yaml
name: status step

on: ["push"]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo $COMMIT_MESSAGES
        env:
          COMMIT_MESSAGES: ${{ toJson(github.event.commits.*.message) }}
      - run: echo run when none of previous steps  have failed or been canceled
        if: success()
      - run: echo run even cancelled. it won't run only when critical failure prevents the task.
        if: always()
      - run: echo run when Workflow cancelled.
        if: cancelled()
      - run: echo run when any previous step of a job fails.
        if: failure()
```

## commit handling

### skip ci

no default handling. use following.

`head_commit` may become null when event is `pull_request` or `push` for tag deletion.

```yaml
name: skip ci commit

on: ["push"]

jobs:
  build:
    if: "!contains(github.event.head_commit.message, '[skip ci]')"
    runs-on: ubuntu-latest
    steps:
      - run: echo $COMMIT_MESSAGE
        env:
          COMMIT_MESSAGE: ${{ toJson(github.event.head_commit.message) }}
```

### trigger via commit message

```yaml
name: trigger ci commit

on: ["push"]

jobs:
  build:
    if: "contains(toJSON(github.event.commits.*.message), '[build]')"
    runs-on: ubuntu-latest
    steps:
      - run: echo $COMMIT_MESSAGES
        env:
          COMMIT_MESSAGES: ${{ toJson(github.event.commits.*.message) }}
```


## Issue and Pull Request handling

use [actions/github\-script](https://github.com/actions/github-script).

### skip ci on pull request title

original `pull_request` event will invoke when activity type is `opened`, `synchronize`, or `reopened`.

> [Events that trigger workflows \- GitHub Help](https://help.github.com/en/actions/reference/events-that-trigger-workflows#pull-request-event-pull_request)

```yaml
name: skip ci pr title

on: ["pull_request"]

jobs:
  build:
    if: "!contains(github.event.pull_request.title, '[skip ci]')"
    runs-on: ubuntu-latest
    steps:
      - run: echo $GITHUB_CONTEXT
        env:
          GITHUB_CONTEXT: ${{ toJson(github) }}
      - run: echo $TITLE
        env:
          TITLE: ${{ toJson(github.event.pull_request.title) }}

```
