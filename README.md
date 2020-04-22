githubaction-lab

language | badge
---- | ----
dotnet | ![build](https://github.com/guitarrapc/githubaction-lab/workflows/build/badge.svg?branch=master)

## Index

* [Not yet support](#not-yet-support)
* [Difference from other CI](#difference-from-other-ci)
  * [migration](#migration)
  * [job and workflow](#job-and-workflow)
  * [skip ci on commit message](#skip-ci-on-commit-message)
  * [path filter](#path-filter)
  * [job id or other meta values](#job-id-or-other-meta-values)
  * [cancel redundant builds](#cancel-redundant-builds)
  * [set environment variables for next step](#set-environment-variables-for-next-step)
* [Fundamentals](#fundamentals)
  * [meta github context](#meta-github-context)
  * [view webhook github context](#view-webhook-gitHub-context)
  * [matrix and secret dereference](#matrix-and-secret-dereference)
  * [matrix and environment variables](#matrix-and-environment-variables)
  * [runs only previous job is success](#runs-only-previous-job-is-success)
  * [runs only when previous step status is specific](#runs-only-when-previous-step-status-is-specific)
  * [timeout for job and step](#timeout-for-job-and-step)
  * [cancel redundant build sample](#cancel-redundant-build-sample)
* [Branch and tag handling](#branch-and-tag-handling)
  * [run when branch push only but skip on tag push](#run-when-branch-push-only-but-skip-on-tag-push)
  * [skip when branch push but run on tag push only](#skip-when-branch-push-but-run-on-tag-push-only)
  * [build only specific tag pattern](#build-only-specific-tag-pattern)
  * [get pushed tag name](#get-pushed-tag-name)
* [Commit handling](#commit-handling)
  * [skip ci](#skip-ci)
  * [trigger via commit message](#trigger-via-commit-message)
* [Issue and Pull Request handling](#issue-and-pull-request-handling)
  * [skip ci on pull request title](#skip-ci-on-pull-request-title)

## Not yet support

- [ ] Manual Trigger
- [ ] Approval
  - [GitHub Actions Manual Trigger / Approvals \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/GitHub-Actions-Manual-Trigger-Approvals/m-p/31504)
- [ ] reuse workflow/job/step yaml
  - [Solved: Is it possible to reuse workflow yaml to setup sim\.\.\. \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/Is-it-possible-to-reuse-workflow-yaml-to-setup-similar-workflows/td-p/40634)
  - need use Repository Actions with TypeScript or Docker.
- [ ] YAML anchor support
  - [Support for YAML anchors \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/Support-for-YAML-anchors/td-p/30336)

## Difference from other CI

### migration

> * GitHub Actions -> CircleCI: [Migrating from Github Actions \- CircleCI](https://circleci.com/docs/2.0/migrating-from-github/)
> * CircleCI -> GitHub Actions: [Migrating from CircleCI to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-circleci-to-github-actions)
> * Azure pipeline -> GitHub Actions: [Migrating from Azure Pipelines to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-azure-pipelines-to-github-actions)
> * Jenkins -> GitHub Actions: [Migrating from Jenkins to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-jenkins-to-github-actions)

### job and workflow

GitHub Actions cannnot reuse yaml and need to write same job for each workflow.
Better define step in script and call it from step, so that we can reuse same execution from other workflows or jobs.

* GitHub Actions define job inside workflow, and GitHub Actions cannot refer yaml from others.
* CircleCI define job and conbinate it in workflow. Reusing job is natual way in circleci.
* Azure Pipeline offer's template to refer stage, job and step from other yaml. This enable user to reuse yaml.
* Jenkins has pipeline and could refer other pipeline. However a lot case would be define job step in script and reuse script, not pipeline.

### skip ci on commit message

GitHub Actions has no default support for `[skip ci]` or `[ci skip]`. Users require define `jobs.<job_id>.if` or `jobs.<job_id>.steps.run.if`.
You cannot use commit message `[skip ci]` on `pull_request` event as webhook not contains commits message playload.


* GitHub Actions need use `if` for job or step. if you want to handle whole workflow running, create `skip ci` check job and other job refer via `needs`.
* CircleCI can skip job via `[skip ci]` or `[ci skip]`. PR commit also skip.
* Azure Pipeline can skip job via `***NO_CI***`, `[skip ci]` or `[ci skip]`, or [others](https://github.com/Microsoft/azure-pipelines-agent/issues/858#issuecomment-475768046).
* Jenkins has plugin to support `[skip ci]` or any expression w/pipeline via [SCM Skip \| Jenkins plugin](https://plugins.jenkins.io/scmskip/).

### path filter

GitHub Actions can use `on.<event>.paths-ignore:` and `on.<event>.paths:` by default.

> [paths - Workflow syntax for GitHub Actions \- GitHub Help](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#onpushpull_requestpaths)

* GitHub Actions can set path-filter.
* CircleCI can not set path-filter.
* Azure Pipeline can set path-filter.
* Jenkins ... I think I need filter change from changes?

### job id or other meta values

GitHub Actions has Context concept, you can access job specific info via `github`. 
for example, `github.run_id` is A unique number for each run within a repository.
Also you can access default environment variables like `GITHUB_RUN_ID`.

* GitHub Actions [environment variable](https://help.github.com/en/actions/configuring-and-managing-workflows/using-environment-variables#default-environment-variables) `GITHUB_RUN_ID` or [context](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context) `github.run_id`
* CircleCI [environment vairable](https://circleci.com/docs/2.0/env-vars/#built-in-environment-variables) `CIRCLE_BUILD_NUM` and `CIRCLE_WORKFLOW_ID`
* Azure Pipeline [environment variable](https://docs.microsoft.com/ja-jp/azure/devops/pipelines/process/run-number?view=azure-devops&tabs=yaml#tokens) `BuildID`.
* Jenkins [environment vairable](https://wiki.jenkins.io/display/JENKINS/Building+a+software+project) `BUILD_NUMBER`

### cancel redundant builds

GitHub Actions not support cancel redundant build as CircleCI do.
> [Solved: Github actions: Cancel redundant builds \(Not solve\.\.\. \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/Github-actions-Cancel-redundant-builds-Not-solved/td-p/29549)

You can accomplish via actions. Workflow run cleanup action is the recommended.

> [Workflow run cleanup action · Actions · GitHub Marketplace](https://github.com/marketplace/actions/workflow-run-cleanup-action)

This one is bit too much.

> [technote\-space/auto\-cancel\-redundant\-job: GitHub Actions to automatically cancel redundant jobs\.](https://github.com/technote-space/auto-cancel-redundant-job)

Theses are minimum specs.

> [auto\-cancellation\-running\-action · Actions · GitHub Marketplace](https://github.com/marketplace/actions/auto-cancellation-running-action)
>
> [GH actions stale run canceller · Actions · GitHub Marketplace](https://github.com/marketplace/actions/gh-actions-stale-run-canceller)

* GitHub Actions need use some of actions
* CircleCI support cancel redundant build
* Azure Pipeline not support cancel redundant build
* Jenkins not support cancel redundant build, you need cancel it from parallel job.

### set environment variables for next step

GitHub Actions need to set environment variables with specific syntax, not `KEY=VALUE` but `::set-env name={name}::{value}`.

> https://help.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-environment-variable

* GitHub Actions use `::set-env` syntax
* CircleCI use redirect to `> BASH_ENV` will automatically load on next step
* Azure Pipeline use task.setvariable. `echo "##vso[task.setvariable variable=NAME]VALUE"`
* Jenkins use `Env.` in groovy declarative pipeline.

## Fundamentals

### meta github context

job id, name and others.

> [Context and expression syntax for GitHub Actions \- GitHub Help](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context)

### view webhook github context

dump context with `toJson()` is a easiest way to dump context.

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

### matrix and secret dereference

matrix cannot reference `secret` context, so pass secret key in matrix then dereference secret with `secrets[matrix.SECRET_KEY]`.

let's set secrets in settings.

![image](https://user-images.githubusercontent.com/3856350/79934065-99de6c00-848c-11ea-8995-bfe948e6c0fb.png)

```yaml
name: matrix secret

on: ["push"]

jobs:
  build:
    strategy:
      matrix:
        org: [apples, bananas, carrots] #Array of org mnemonics to use below
        include:
          # includes a new variable for each org (this is effectively a switch statement)
          - org: apples
            secret: APPLES
          - org: bananas
            secret: BANANAS
          - org: carrots
            secret: CARROTS
    runs-on: ubuntu-latest
    steps:
      - run: echo "org:${{ matrix.org }} secret:${{ secrets[matrix.secret] }}"
```

### matrix and environment variables

you can refer matrix in job's `env:` section before steps.
However you cannot use expression, you must evaluate in step.

```yaml
name: matrix envvar

on: ["push"]

jobs:
  build:
    strategy:
      matrix:
        org: [apples, bananas, carrots]
    runs-on: ubuntu-latest
    env:
      ORG: ${{ matrix.org }}
      # you can not use expression. do it on step.
      # output on step is -> ci-`date '+%Y%m%d-%H%M%S'`+${GITHUB_SHA:0:6}
      # GIT_TAG: "ci-`date '+%Y%m%d-%H%M%S'`+${GITHUB_SHA:0:6}"
    steps:
      - run: echo "${ORG}"
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

### runs only when previous step status is specific

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

### timeout for job and step

default timeout is 360min. You should set much more shorten timeout like 15min or 30min to prevent spending a lot build time.

```yaml
name: timeout

on: ["push"]

jobs:
  my-job:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - run: echo done before timeout
        timeout-minutes: 1 # step個別
```

### cancel redundant build sample

cancelling if `push is not tag` and `push is not branch "master"`.
It means push to branch will be cancelled.

```yaml
name: cancel redundant build
on: push

jobs:
  cancel:
    runs-on: ubuntu-latest
    steps:
      - uses: rokroskar/workflow-run-cleanup-action@v0.2.2
        if: "!startsWith(github.ref, 'refs/tags/') && github.ref != 'refs/heads/master'"
        env:
          GITHUB_TOKEN: "${{ secrets.GITHUB_TOKEN }}"
```

## Branch and tag handling

### run when branch push only but skip on tag push

If you want run job only when push to branch, and not for tag push.

```yaml
name: branch push only

on:
  push:
    branches:
      - "**"
    tags:
      - "!*" # not a tag push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo not run on tag
```

### skip when branch push but run on tag push only

If you want run job only when push to tag, and not for branch push.

```yaml
name: tag push only

on:
  push:
    tags:
      - "**" # only tag

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo not run on branch push
```

### build only specific tag pattern

You can use pattern on `on.push.tags`, but you can't on `step.if`.
This pattern will match following.

* 0.0.1
* 1.0.0+preview
* 0.0.3-20200421-preview+abcd123408534

not for below.

* v0.0.1
* release

```yaml
name: tag push only pattern

on:
  push:
    tags:
      - "[0-9]+.[0-9]+.[0-9]+*" # only tag with pattern match

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo not run on branch push
```

### get pushed tag name

You need extract refs to get tag name.
Save it to `step context` and refer from other step or save it to env is much eacher.

```yaml
name: tag push only

on:
  push:
    tags:
      - "**" # only tag

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo ::set-output name=GIT_TAG::${GITHUB_REF#refs/tags/}
        id: CI_TAG
      - run: echo ${{ steps.CI_TAG.outputs.GIT_TAG }}
      - run: echo ::set-env name=GIT_TAG::${GITHUB_REF#refs/tags/}
      - run: echo ${{ env.GIT_TAG }}
```

## Commit handling

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

