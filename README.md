githubaction-lab

language | badge
---- | ----
dotnet | ![build](https://github.com/guitarrapc/githubaction-lab/workflows/build/badge.svg?branch=master)

## Not yet support

- [ ] Manual Trigger
- [ ] Approval
  - [GitHub Actions Manual Trigger / Approvals \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/GitHub-Actions-Manual-Trigger-Approvals/m-p/31504)
- [ ] reuse workflow/job/step yaml
  - [Solved: Is it possible to reuse workflow yaml to setup sim\.\.\. \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/Is-it-possible-to-reuse-workflow-yaml-to-setup-similar-workflows/td-p/40634)
  - need use Repository Actions with TypeScript or Docker.
- [ ] YAML anchor support
  - [Support for YAML anchors \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/Support-for-YAML-anchors/td-p/30336)

## Diff with other CI

> CircleCI: [Migrating from Github Actions \- CircleCI](https://circleci.com/docs/2.0/migrating-from-github/)

**job and workflow**

GitHub Actions cannnot reuse yaml and need to write same job for each workflow.
Better define step in script and call it from step, so that we can reuse same execution from other workflows or jobs.

* GitHub Actions define job inside workflow, and GitHub Actions cannot refer yaml from others.
* CircleCI define job and conbinate it in workflow. Reusing job is natual way in circleci.
* Azure Pipeline offer's template to refer stage, job and step from other yaml. This enable user to reuse yaml.
* Jenkins has pipeline and could refer other pipeline. However a lot case would be define job step in script and reuse script, not pipeline.

**skip ci on commit message**

GitHub Actions has no default support for `[skip ci]` or `[ci skip]`. Users require define `jobs.<job_id>.if` or `jobs.<job_id>.steps.run.if`.
You cannot use commit message `[skip ci]` on `pull_request` event as webhook not contains commits message playload.


* GitHub Actions need use `if` for job or step. if you want to handle whole workflow running, create `skip ci` check job and other job refer via `needs`.
* CircleCI can skip job via `[skip ci]` or `[ci skip]`. PR commit also skip.
* Azure Pipeline can skip job via `***NO_CI***`, `[skip ci]` or `[ci skip]`, or [others](https://github.com/Microsoft/azure-pipelines-agent/issues/858#issuecomment-475768046).
* Jenkins has plugin to support `[skip ci]` or any expression w/pipeline via [SCM Skip \| Jenkins plugin](https://plugins.jenkins.io/scmskip/).

**path filter**

GitHub Actions can use `on.<event>.paths-ignore:` and `on.<event>.paths:` by default.

> [paths - Workflow syntax for GitHub Actions \- GitHub Help](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#onpushpull_requestpaths)

* GitHub Actions can set path-filter.
* CircleCI can not set path-filter.
* Azure Pipeline can set path-filter.
* Jenkins ... I think I need filter change from changes?

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
    if: "!contains(github.event.head_commit.message, '[skip ci]') || !contains(github.event.head_commit.message, '[ci skip]')"
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
    if: "!contains(github.event.pull_request.title, '[skip ci]') || !contains(github.event.pull_request.title, '[ci skip]')"
    runs-on: ubuntu-latest
    steps:
      - run: echo $GITHUB_CONTEXT
        env:
          GITHUB_CONTEXT: ${{ toJson(github) }}
      - run: echo $TITLE
        env:
          TITLE: ${{ toJson(github.event.pull_request.title) }}
```
