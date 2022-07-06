![dotnet-build](https://github.com/guitarrapc/githubaction-lab/workflows/dotnet-build/badge.svg?branch=main)

# githubactions-lab

GitHub Actions laboratory.

# Table of Contents

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<details>
<summary>Details</summary>

- [Not yet support](#not-yet-support)
- [Difference from other CI](#difference-from-other-ci)
  - [Migration](#migration)
  - [Job and workflow](#job-and-workflow)
  - [Skip ci on commit message](#skip-ci-on-commit-message)
  - [Path filter](#path-filter)
  - [JobId and other meta values](#jobid-and-other-meta-values)
  - [Cancel redundant builds](#cancel-redundant-builds)
  - [Set environment variables for next step](#set-environment-variables-for-next-step)
  - [Adding system path](#adding-system-path)
  - [Set secrets for reposiory](#set-secrets-for-reposiory)
  - [Approval](#approval)
- [Fundamentals](#fundamentals)
  - [Multiline](#multiline)
  - [Manual Trigger and input](#manual-trigger-and-input)
  - [Workflow dispatch with mixed input type](#workflow-dispatch-with-mixed-input-type)
  - [Permissions](#permissions)
  - [Retry failed workflow](#retry-failed-workflow)
  - [Secrets](#secrets)
  - [Meta github context](#meta-github-context)
  - [View webhook github context](#view-webhook-github-context)
  - [Matrix and secret dereference](#matrix-and-secret-dereference)
  - [Matrix and environment variables](#matrix-and-environment-variables)
  - [Set environment variables in script](#set-environment-variables-in-script)
  - [Reuse yaml actions - composite](#reuse-yaml-actions---composite)
  - [Reuse Node actions - node12](#reuse-node-actions---node12)
  - [Execute run when previous job is success](#execute-run-when-previous-job-is-success)
  - [Execute run when previous step status is specific](#execute-run-when-previous-step-status-is-specific)
  - [Timeout](#timeout)
  - [Concurrent build control](#concurrent-build-control)
  - [Suppress redundant build](#suppress-redundant-build)
  - [Use if and context](#use-if-and-context)
- [BAD PATTERN](#bad-pattern)
  - [Env refer env](#env-refer-env)
- [Branch and tag handling](#branch-and-tag-handling)
  - [Run when branch push only but skip on tag push](#run-when-branch-push-only-but-skip-on-tag-push)
  - [Skip when branch push but run on tag push only](#skip-when-branch-push-but-run-on-tag-push-only)
  - [Build only specific tag pattern](#build-only-specific-tag-pattern)
  - [Get pushed tag name](#get-pushed-tag-name)
  - [Create release](#create-release)
  - [Schedule job on non-default branch](#schedule-job-on-non-default-branch)
- [Commit handling](#commit-handling)
  - [Trigger via commit message](#trigger-via-commit-message)
  - [Commit file handling](#commit-file-handling)
- [Issue and Pull Request handling](#issue-and-pull-request-handling)
  - [Skip ci on pull request title](#skip-ci-on-pull-request-title)
  - [Skip pr from fork repo](#skip-pr-from-fork-repo)
  - [Detect labels on pull request](#detect-labels-on-pull-request)
  - [Skip job when Draft PR](#skip-job-when-draft-pr)
- [ADVANCED](#advanced)
  - [Dispatch other repo from workflow](#dispatch-other-repo-from-workflow)
  - [Lint GitHub Actions workflow itself](#lint-github-actions-workflow-itself)
  - [Get PR info from Merge Commit](#get-pr-info-from-merge-commit)

</details>
<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Not yet support

- [ ] YAML anchor support
  - [Support for YAML anchors \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/Support-for-YAML-anchors/td-p/30336)
  - Workaround: There are CompositeActions and Reusable workflow to reuse same set of actions.
- [ ] GitHub Actions Grouping
  - Group GitHub Actions
  - No workaround.
- [ ] Test Insight view
  - Like CircleCI or Azure Pipeline provides.
- [ ] SSH Debug
  - Like CircleCI provies.

# Difference from other CI

## Migration

> * GitHub Actions -> CircleCI: [Migrating from Github Actions \- CircleCI](https://circleci.com/docs/2.0/migrating-from-github/)
> * CircleCI -> GitHub Actions: [Migrating from CircleCI to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-circleci-to-github-actions)
> * Azure pipeline -> GitHub Actions: [Migrating from Azure Pipelines to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-azure-pipelines-to-github-actions)
> * Jenkins -> GitHub Actions: [Migrating from Jenkins to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-jenkins-to-github-actions)

## Job and workflow

All CI has yaml definitions.

* ✔️: GitHub Actions define jobs inside workflow. Can trigger both Push and PR.

```yaml
name: workflow name
on:
  push:
    branches: [main]

jobs:
  Job_Name:
    runs-on: ubuntu-latest
    steps:
      - run: echo foo
```

* ✔️: CircleCI define jobs and conbinate them in workflow. Can not trigger both Push and PR.

```yaml
version: 2.1

jobs:
  Job_Name:
    docker:
      - image: circleci/<language>:<version TAG>
    steps:
      - run: echo foo
workflows:
  commit:
    jobs:
      - Job_Name
```

* ✔️: Azure Pipeline define jobs and conbinate them in stage. Can trigger both Push and PR.

```yaml
trigger:
- main

stages:
- stage: StageName
  jobs:
  - job: Job_Name

jobs:
- job: Job_Name
  pool:
    vmImage: 'ubuntu-latest'
  steps:
  - bash: echo "foo"
```

* ✔️: Jenkins has Declaretive Pipeline. Trigger needs to be defined outside pipeline.

```groovy
pipeline {
  agent any
  triggers {
    pollSCM('')
  }
  stages {
    stage('Stage_Name') {
      steps {
        sh 'echo foo'
      }
    }
  }
}
```

## Reusable job and workflow

Write script is better than directly write on the step, so that we can reuse same execution from other workflows or jobs.

* ✔️: GitHub Actions can reuse yaml and via Reusable workflow or Composite Actions.
* ✔️: CircleCI can reuse job and also anchor is useul.
* ✔️: Azure Pipeline has template to refer stage, job and step from other yaml.
* ✔️: Jenkins has pipeline and could refer other pipeline. However a lot case would be define job step in script and reuse script. Reusing pipeline in Jenkins easily make it complex than other CI.

## Skip CI on commit message

GitHub Actions support when HEAD commit contains key word like other ci.

* ✔️: GitHub Actions can skip workflow via `[skip ci]`, `[ci skip]`, `[no ci]`, `[skip actions]` or `[actions skip]`. If PR last commit message contains `[skip ci]`, then merge commit also skip.
* ✔️: CircleCI can skip job via `[skip ci]` or `[ci skip]`. If PR last commit message contains `[skip ci]`, then merge commit also skip.
* ✔️: Azure Pipeline can skip job via `***NO_CI***`, `[skip ci]` or `[ci skip]`, or [others](https://github.com/Microsoft/azure-pipelines-agent/issues/858#issuecomment-475768046).
* ❌: Jenkins not support skip ci on default, but there are plugins to support `[skip ci]` or any expression w/pipeline like [SCM Skip \| Jenkins plugin](https://plugins.jenkins.io/scmskip/).

## Path filter

GitHub Actions can use `on.<event>.paths-ignore:` and `on.<event>.paths:` by default.

> [paths - Workflow syntax for GitHub Actions \- GitHub Help](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#onpushpull_requestpaths)

* ✔️: GitHub Actions **CAN** set path-filter.
* ❌: CircleCI can not set path-filter.
* ✔️: Azure Pipeline can set path-filter.
* ❌: Jenkins can not set path-filter. User should prepare by theirself.

## JobId and other meta values

GitHub Actions has Context concept, you can access job specific info via `github`.
for example, `github.run_id` is A unique number for each run within a repository.
Also you can access default environment variables like `GITHUB_RUN_ID`.

* ✔️: GitHub Actions [environment variable](https://help.github.com/en/actions/configuring-and-managing-workflows/using-environment-variables#default-environment-variables) `GITHUB_RUN_ID` or [context](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context) `github.run_id`
* ✔️: CircleCI [environment vairable](https://circleci.com/docs/2.0/env-vars/#built-in-environment-variables) `CIRCLE_BUILD_NUM` and `CIRCLE_WORKFLOW_ID`
* ✔️: Azure Pipeline [environment variable](https://docs.microsoft.com/ja-jp/azure/devops/pipelines/process/run-number?view=azure-devops&tabs=yaml#tokens) `BuildID`.
* ✔️: Jenkins [environment vairable](https://wiki.jenkins.io/display/JENKINS/Building+a+software+project) `BUILD_NUMBER`

## Cancel redundant builds

GitHub Actions not support exact functionality as CircleCI provide, but you can do via concurrency control. Another option is comminity actions like [rokroskar/workflow-run-cleanup-action](https://github.com/marketplace/actions/workflow-run-cleanup-action), [fauguste/auto-cancellation-running-action](https://github.com/marketplace/actions/auto-cancellation-running-action) and [yellowmegaman/gh-build-canceller](https://github.com/marketplace/actions/gh-actions-stale-run-canceller).

* ✔️: GitHub Actions has concurrency control and it can cancel in progress build. Or your can use Comminity Actions.
* ✔️: CircleCI support cancel redundant build.
* ❌: Azure Pipeline not support cancel redundant build.
* ❌: Jenkins not support cancel redundant build, you need cancel it from parallel job.

## Set environment variables for next steps

See GitHub Actions environment variable document.

> https://help.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-environment-variable


* ✔️: GitHub Actions need to use special Environment variable `$GITHUB_ENV` via `echo "{name}={value}" >> "$GITHUB_ENV"` syntax, or `echo "{name}={value}" | tee -a "$GITHUB_ENV"`
  * `::set-env` syntax has been deprecated for [security reason](https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands/).
* ✔️: CircleCI use redirect to `>> BASH_ENV` via `echo "export GIT_SHA1=$CIRCLE_SHA1" >> $BASH_ENV` syntax.
* ✔️: Azure Pipeline use task.setvariable via `echo "##vso[task.setvariable variable=NAME]VALUE"` syntax.
* ✔️: Jenkins use `Env.`.

## Adding system path

* ✔️: GitHub Actions need to use special Environment variable `$GITHUB_PATH` via `echo "{path}" >> "$GITHUB_PATH"` syntax.
  * `::add-path` syntax has been deprecated for [security reason](https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands/).
* ✔️: CircleCI use redirect to `>> BASH_ENV` via `echo "export PATH=$GOPATH/bin:$PATH" >> $BASH_ENV` syntax.
* ✔️: Azure Pipeline use task.setvariable via `echo '##vso[task.setvariable variable=path]$(PATH):/dir/to/whatever'` syntax.
* ✔️: Jenkins use `Env.`.

## Set secrets for reposiory

GitHub ACtions offer Secrets for each repository and Organization.
Secrets will be masked on the log.

* ✔️: GitHub Actions use Secrets and Environment Secrets.
* ✔️: CircleCI offer Environment Variables and Context.
* ✔️: Azure Pipeline has Environment Variables and Paramter.
* ✔️: Jenkins has Credential Provider.

## Approval

* ✔️: GitHub Actions supports Approval on **Environment**. However Environment cannot use in `GitHub Team` pricing.
* ✔️: CircleCI supports Approval.
* ✔️: Azure Pipelin supports Approval.
* ✔️: Jenkins supports Approval.

# Basic - Fundamentables

## Multiline

There are many place to support multiline.

**run**

Use `run: |` to write `run` statement in multiline.

```yaml
# .github/workflows/multiline_run.yaml

name: multiline run
on:
  workflow_dispatch:
  push:
    branches: ["main"]

jobs:
  push:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - run: |
          echo "foo"
          echo "bar"

```

**if**

Use `if: >-` to write `if` statement in multiline.

```yaml
# .github/workflows/multiline_if.yaml

name: multiline if
on:
  workflow_dispatch:
  push:
    branches: ["main"]

jobs:
  push:
    if: >-
      github.event_name == 'push' ||
      github.event.forced == false
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - run: echo "push"

  workflow_dispatch:
    if: >-
      github.event_name == 'workflow_dispatch'
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - run: echo "workflow_dispatch"

```


## Manual Trigger and input

GitHub Actions offer `workflow_dispatch` event to execute workflow manually from WebUI.
Also you can use [action inputs](https://docs.github.com/en/actions/creating-actions/metadata-syntax-for-github-actions#inputs) to specify value trigger on manual trigger.

```yaml
# .github/workflows/manual_trigger.yaml

name: manual trigger
on:
  workflow_dispatch:
    inputs:
      branch:
        description: "branch name to clone"
        required: true
        default: "main"
      logLevel:
        description: "Log level"
        required: true
        default: "warning"
      tags:
        description: "Test scenario tags"
        required: false
jobs:
  printInputs:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    env:
      BRANCH: ${{ github.event.inputs.branch }}
      LOGLEVEL: ${{ github.event.inputs.logLevel }}
      TAGS: ${{ github.event.inputs.tags }}
    steps:
      - run: echo ${{ env.BRANCH }} ${{ env.LOGLEVEL }} ${{ env.TAGS }}
      - uses: actions/checkout@v3
        with:
          ref: ${{ github.event.inputs.branch }}
      - name: dump github context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(github) }}
      - name: dump inputs context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(github.event.inputs) }}
      - run: |
          echo "Log level: ${{ github.event.inputs.logLevel }}"
          echo "Tags: ${{ github.event.inputs.tags }}"
      # INPUT_ not automatcally generated
      - run: |
          echo "${INPUT_TEST_VAR}"
          echo "${TEST_VAR}"
      - run: echo "/path/to/dir" >> "$GITHUB_PATH"
      - run: |
          echo "INPUT_LOGLEVEL=${{ github.event.inputs.logLevel }}" >> "$GITHUB_ENV"
          echo "INPUT_TAGS=${{ github.event.inputs.tags }}" >> "$GITHUB_ENV"
      - run: |
          echo "Log level: ${INPUT_LOGLEVEL}"
          echo "Tags: ${INPUT_TAGS}"
      - run: export

```

Even if you specify action inputs, input value will not store as ENV var `INPUT_{INPUTS_ID}` as usual.

## Workflow dispatch with mixed input type

Workflow dispatch supported input type.

* boolean: `true` or `false` and Web UI offers checkbox.
* choice: enum options and Web UI offers selection box.
* environment: enum GitHub Environments and Web UI offers selection box.

```yaml
# .github/workflows/workflow_dispatch_mixed_inputs.yaml

name: workflow dispatch mixed inputs

on:
  workflow_dispatch:
    inputs:
      name:
        type: choice
        description: "name: Who to greet"
        required: true
        options:
          - monalisa
          - cschleiden
      message:
        description: "mnessage: add message"
        required: true
      use-emoji:
        type: boolean
        required: true
        description: Include 🎉🤣 emojis
      environment:
        type: environment
        required: true
        description: Select environment

jobs:
  greet:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - name: Send greeting
        run: echo "${{ github.event.inputs.message }} ${{ fromJSON('["", "🥳"]')[github.event.inputs.use-emoji == 'true'] }} ${{ github.event.inputs.name }}"

```

## Permissions

GitHub supports specify permissions for each job or workflow.

You can turn all permission off with `permissions: {}`.

Workflow permission can be done with root `permissions:`.

```yaml
# .github/workflows/permissions_workflow.yaml

name: permissions
on:
  pull_request:
    branches: ["main"]

permissions:
  # actions: write
  # checks: write
  contents: write
  # deployments: write
  # discussions: write
  # id-token: write
  # issues: write
  # packages: write
  # pages: write
  # pull-requests: write
  # repository-projects: write
  # security-events: write
  # statuses: write

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - id: file_changes
        uses: trilom/file-changes-action@v1.2.4
        with:
          output: ","
      - run: echo "${{ steps.file_changes.outputs.files }}"
      - run: echo "${{ contains(steps.file_changes.outputs.files, '.github/workflows')}}"
      - run: echo "${{ contains(steps.file_changes.outputs.files, '.github/dummy')}}"
      - run: echo "${{ contains(steps.file_changes.outputs.files, '.github/dummy') || 'true' }}"
      - run: echo "RUN_TEST=${{ contains(steps.file_changes.outputs.files, '.github/workflows') || 'true' }}"  | tee -a "$GITHUB_ENV"
      # test if not exists
      - id: file_changes2
        uses: trilom/file-changes-action@v1.2.4
        with:
          output: ","
        if: ${{ github.event.pull_request.changed_files > 10 }}
      - run: echo "${{ contains(steps.file_changes2.outputs.files, '.github/workflows')}}"
      - run: echo "${{ contains(steps.file_changes2.outputs.files, '.github/dummy')}}"
      - run: echo "${{ contains(steps.file_changes2.outputs.files, '.github/dummy') || 'true' }}"
      - run: echo "RUN_TEST2=${{ contains(steps.file_changes2.outputs.files, '.github/workflows') || 'true' }}"  | tee -a "$GITHUB_ENV"

```

job permission can be done with `job.<job_name>.permissions`.

```yaml
# .github/workflows/permissions_job.yaml

name: permissions job
on:
  pull_request:
    branches: ["main"]

jobs:
  build:
    permissions:
      contents: write
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - id: file_changes
        uses: trilom/file-changes-action@v1.2.4
        with:
          output: ","
      - run: echo "${{ steps.file_changes.outputs.files }}"
      - run: echo "${{ contains(steps.file_changes.outputs.files, '.github/workflows')}}"
      - run: echo "${{ contains(steps.file_changes.outputs.files, '.github/dummy')}}"
      - run: echo "${{ contains(steps.file_changes.outputs.files, '.github/dummy') || 'true' }}"
      - run: echo "RUN_TEST=${{ contains(steps.file_changes.outputs.files, '.github/workflows') || 'true' }}"  | tee -a "$GITHUB_ENV"
      # test if not exists
      - id: file_changes2
        uses: trilom/file-changes-action@v1.2.4
        with:
          output: ","
        if: ${{ github.event.pull_request.changed_files > 10 }}
      - run: echo "${{ contains(steps.file_changes2.outputs.files, '.github/workflows')}}"
      - run: echo "${{ contains(steps.file_changes2.outputs.files, '.github/dummy')}}"
      - run: echo "${{ contains(steps.file_changes2.outputs.files, '.github/dummy') || 'true' }}"
      - run: echo "RUN_TEST2=${{ contains(steps.file_changes2.outputs.files, '.github/workflows') || 'true' }}"  | tee -a "$GITHUB_ENV"

```

The most important is `id-tokens: write`. It enables job to use OIDC other OIDC providers.

## Retry failed workflow

GitHub Actions support Re-run jobs.
You can re-run whole workflow again, but you cannot re-run specified job only.

## Secrets

GitHub Actions supports "Indivisual Repository Secrets" and "Organization Secrets"

* You can set secrets for each repository with `Settings > Secrets`.
* You can set secrets for Organization and filter to selected repository with `Settings > Secrets`.

If same secrets key is exists, `Repository Secrets` > `Organization Secrets`.

When you want spread your secrets with indivisual account, you need set each repository secrets or use [google/secrets\-sync\-action](https://github.com/google/secrets-sync-action).

## Meta github context

Use Context to retrive job id, name and others system info.
Make sure you can not refer github context in script.

> see: [Context and expression syntax for GitHub Actions \- GitHub Help](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context)

```yaml
# .github/workflows/context_github.yaml

name: "context github"
on:
  push:
    branches: ["main"]

jobs:
  context:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - name: job
        run: echo ${{ github.job }}
      - name: ref
        run: echo ${{ github.ref }}
      - name: sha
        run: echo ${{ github.sha }}
      - name: repository
        run: echo ${{ github.repository }}
      - name: repository_owner
        run: echo ${{ github.repository_owner }}
      - name: actor
        run: echo ${{ github.actor }}
      - name: run_id
        run: echo ${{ github.run_id }}
      - name: workflow
        run: echo ${{ github.workflow }}
      - name: event_name
        run: echo ${{ github.event_name }}
      - name: event.ref
        run: echo ${{ github.event.ref }}
      - name: action
        run: echo ${{ github.action }}

```

**JSON output**

Use `toJson(<CONTEXT>)` To show context values in json.

To see push context.

```yaml
# .github/workflows/dump_context_push.yaml

name: dump context push

on:
  push:
    branches: ["main"]

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - name: Dump environment
        run: export
      - name: Dump GitHub context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(github) }}
      - name: Dump job context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(job) }}
      - name: Dump steps context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(steps) }}
      - name: Dump runner context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(runner) }}
      - name: Dump strategy context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(strategy) }}
      - name: Dump matrix context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(matrix) }}

```

To see pull_request context.

```yaml
# .github/workflows/dump_context_pr.yaml

name: dump context pr

on:
  pull_request:
    branches: ["main"]

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - name: Dump environment
        run: export
      - name: Dump GitHub context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(github) }}
      - name: Dump job context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(job) }}
      - name: Dump steps context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(steps) }}
      - name: Dump runner context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(runner) }}
      - name: Dump strategy context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(strategy) }}
      - name: Dump matrix context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(matrix) }}

```

To see local action context.

```yaml
# .github/workflows/dump_context_action.yaml

name: dump context action

on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v3
      - uses: ./.github/actions/dump_context_actions

```

## View webhook github context

dump context with `toJson()` is a easiest way to dump context.

```yaml
# .github/workflows/dump_context_push.yaml

name: dump context push

on:
  push:
    branches: ["main"]

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - name: Dump environment
        run: export
      - name: Dump GitHub context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(github) }}
      - name: Dump job context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(job) }}
      - name: Dump steps context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(steps) }}
      - name: Dump runner context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(runner) }}
      - name: Dump strategy context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(strategy) }}
      - name: Dump matrix context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(matrix) }}

```

pull request dump.

```yaml
# .github/workflows/dump_context_pr.yaml

name: dump context pr

on:
  pull_request:
    branches: ["main"]

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - name: Dump environment
        run: export
      - name: Dump GitHub context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(github) }}
      - name: Dump job context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(job) }}
      - name: Dump steps context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(steps) }}
      - name: Dump runner context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(runner) }}
      - name: Dump strategy context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(strategy) }}
      - name: Dump matrix context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(matrix) }}

```

## Matrix and secret dereference

matrix cannot reference `secret` context, so pass secret key in matrix then dereference secret with `secrets[matrix.SECRET_KEY]`.

let's set secrets in settings.

![image](https://user-images.githubusercontent.com/3856350/79934065-99de6c00-848c-11ea-8995-bfe948e6c0fb.png)

```yaml
# .github/workflows/matrix_secret.yaml

name: matrix secret

on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

env:
  fruit: APPLES

jobs:
  dereference:
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
    timeout-minutes: 3
    steps:
      - run: echo "org:${{ matrix.org }} secret:${{ secrets[matrix.secret] }}"
      - run: echo "org:${{ matrix.org }} secret:${{ secrets[env.secret] }}"
        env:
          secret: ${{ matrix.secret }}
      - run: echo "env:${{ env.fruit }} secret:${{ secrets[env.fruit] }}"

```

## Matrix and environment variables

you can refer matrix in job's `env:` section before steps.
However you cannot use expression, you must evaluate in step.

```yaml
# .github/workflows/matrix_envvar.yaml

name: matrix envvar

on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  build:
    strategy:
      matrix:
        org: [apples, bananas, carrots]
    runs-on: ubuntu-latest
    timeout-minutes: 3
    env:
      ORG: ${{ matrix.org }}
      # you can not use expression. do it on step.
      # output on step is -> ci-`date '+%Y%m%d-%H%M%S'`+${GITHUB_SHA:0:6}
      # GIT_TAG: "ci-`date '+%Y%m%d-%H%M%S'`+${GITHUB_SHA:0:6}"
    steps:
      - run: echo "${ORG}"
      - run: echo "${NEW_ORG}"
        env:
          NEW_ORG: new-${{ env.ORG }}

```

## Environment variables in script

[set environment variables for next step](#set-environment-variables-for-next-step) explains how to set environment variables for next step.
This syntax can be write in the script, let's see `.github/scripts/setenv.sh`.

```bash
# .github/scripts/setenv.sh

#!/bin/bash
while [ $# -gt 0 ]; do
    case $1 in
        --ref) GITHUB_REF=$2; shift 2; ;;
        *) shift ;;
    esac
done

echo GIT_TAG_SCRIPT=${GITHUB_REF##*/} >> "$GITHUB_ENV"

```

Call this script from workflow.

```yaml
# .github/workflows/env_with_script.yaml

name: env with script

on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v3
      - run: echo "GIT_TAG=${GITHUB_REF#refs/heads/}" >> "$GITHUB_ENV"
      - run: echo ${{ env.GIT_TAG }}
      - run: bash -eux .github/scripts/setenv.sh --ref "${GITHUB_REF#refs/heads/}"
      - run: echo ${{ env.GIT_TAG_SCRIPT }}

```

`echo ${{ env.GIT_TAG_SCRIPT }}` will output `chore/context_in_script` as expected.

## Reuse yaml actions - composite

To reuse local job, create local composite action is easiest way to do, this is calls `composite actions`.
Create yaml file inside local action path, then declare `using: "composite"` in local action.yaml.

* step1. Place your yaml to `.github/actions/YOUR_DIR/action.yaml`
* step2. Write your composite actions yaml.

```yaml
# .github/actions/local_composite_actions/action.yaml

name: YOUR ACTION NAME
description: |
  Desctiption of your action
inputs:
  foo:
    description: thi is foo input
    default: FOO
    required: false
runs:
  using: "composite" # this is key point
  steps:
    - name: THIS IS STEP1
      shell: bash # this is key point
      run: echo ${{ inputs.foo }}

```

* step3. Use actions from your workflow.


```yaml
# .github/workflows/reuse_local_actions.yaml

name: reuse local action
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v3
      - name: use local action
        uses: ./.github/actions/local_composite_actions
        with:
          foo: BAR

```

## Reuse Node actions - node12

To reuse local job, create local node action is another way to do, this is calls `node actions`.
Create yaml file inside local action path, then declare `using: "node12"` in local action.yaml.
Next place your node.js source files inside actions directory, you may require `index.js` for entrypoint.

> TIPS: You may find it is useful when you are running on GHE and copy GitHub Actions to your local.

* step1. Place your ation.yaml  to `.github/actions/YOUR_DIR/actions.yaml`
* step2. Write your node actions yaml.

```yaml
# .github/actions/local_node_actions/action.yaml

name: "Hello World"
description: |
  Desctiption of your action
runs:
  using: "node12"
  main: "index.js"

```

* step3. Write your source code to `.github/actions/YOUR_DIR/*.js`.

```js
// .github/actions/local_node_actions/index.js

console.log("Hello, World!");

```

* step4. Use actions from your workflow.

```yaml
# .github/workflows/reuse_local_actions_node.yaml

name: reuse local action node
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v3
      - name: use local action
        uses: ./.github/actions/local_node_actions

```


## Execute run when previous job is success

to accomplish sequential job run inside workflow, use `needs:` for which you want the job to depends on.

this enforce job to be run when only previous job is **success**.

```yaml
# .github/workflows/sequential_run.yaml

name: sequential jobs

on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - run: echo "$COMMIT_MESSAGES"
        env:
          COMMIT_MESSAGES: ${{ toJson(github.event.commits.*.message) }}

  publish:
    needs: build
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - run: echo run when only build success

```

## Execute run when previous step status is specific

> [job-status-check-functions /- Context and expression syntax for GitHub Actions /- GitHub Help](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#job-status-check-functions)

use `if:` you want set step to be run on particular status.

```yaml
# .github/workflows/status_step.yaml

name: status step

on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - run: echo "$COMMIT_MESSAGES"
        env:
          COMMIT_MESSAGES: ${{ toJson(github.event.commits.*.message) }}
      - run: echo "success() run when none of previous steps  have failed or been canceled"
        if: success()
      - run: echo "always() run even cancelled. it runs only when critical failure prevents the task."
        if: always()
      - run: echo "cancelled() run when Workflow cancelled."
        if: cancelled()
      - run: echo "failure() run when any previous step of a job fails."
        if: failure()

```

## Timeout

You can set timeout for both `job` and `steps`.

default timeout is 360min. (6hours)

It is better set much more shorten timeout like 15min or 30min to prevent spending a lot build time.

```yaml
# .github/workflows/timeout.yaml

name: timeout

on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  my-job:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - run: echo "done before timeout"
        timeout-minutes: 1 # each step

```

## Concurrent build control

GitHub Actions built in concurrency control prevent you to run CI at same time.
This help you achieve serial build pipeline control.

You can use build context like `github.head_ref` or others. This means you can control with commit, branch, workflow and any.

```yaml
# .github/workflows/concurrency_control.yaml

name: "concurrency control"
on:
  workflow_dispatch:

# only ${{ github }} context is available

concurrency: concurrency_${{ github.head_ref }}

jobs:
  long_job:
    runs-on: ubuntu-latest
    steps:
      - run: sleep 60s

```

Specify `cancel-in-progress: true` will cancel parallel build.

```yaml
# .github/workflows/concurrency_control_cancel_in_progress.yaml

name: "concurrency control cancel in progress"
on:
  workflow_dispatch:

# only ${{ github }} context is available

concurrency:
  group: concurrency_cancel_in_progress_${{ github.head_ref }}
  cancel-in-progress: true

jobs:
  long_job:
    runs-on: ubuntu-latest
    steps:
      - run: sleep 60s

```

## Redundant build control

Build redundant may trouble when you are runnning Private Repository, bacause there are build time limits. In other words, you don't need mind build comsume time when repo is Public..

> Detail: Created `pull_request` then pushed emmit `push` and `pull_request/synchronize` event. This trigger duplicate build and waste build time.

**Avoid push on pull_request trigger on same repo**

In this example `push` will trigger only when `main`, default branch. This means push will not run when `pull_request` synchronize event was emmited.
Simple enough for almost usage.

```yaml
# .github/workflows/push_and_pr_avoid_redundant.yaml

name: push and pull_request avoid redundant

on:
  # prevent push run on pull_request
  push:
    branches: ["main"]
  pull_request:
    types:
      - synchronize
      - opened
      - reopened

jobs:
  my-job:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - run: echo push and pull_request trigger

```

**redundant build cancel**

Cancel duplicate workflow and mark CI failure.

```yaml
# .github/workflows/cancel_redundantbuild.yaml

name: cancel redundant build
# when pull_request, both push and pull_request (synchronize) will trigger.
# this action sample will prevent duplicate run, but run only 1 of them.
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  cancel:
    runs-on: ubuntu-latest
    steps:
      # no check for main and tag
      - uses: rokroskar/workflow-run-cleanup-action@v0.2.2
        if: "!startsWith(github.ref, 'refs/tags/') && github.ref != 'refs/heads/main'"
        env:
          GITHUB_TOKEN: "${{ secrets.GITHUB_TOKEN }}"

```

## if and context

GitHub Actions allow `if` condition for `step`.
You can refer any context inside `if` condition.
You don't need add `${{}}` to context reference. but I do recomment add it for easier read.

> NOTE: `matrix` cannot refer with `job.if`.

> [Solved: What is the correct if condition syntax for checki/././. /- GitHub Community Forum](https://github.community/t5/GitHub-Actions/What-is-the-correct-if-condition-syntax-for-checking-matrix-os/td-p/31269)

```yaml
# .github/workflows/if_and_context.yaml

name: if and context reference
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  matrix_reference:
    strategy:
      matrix:
        sample: ["hoge", "fuga"]
    env:
      APP: hoge
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      # env context reference
      - run: echo "this is env if for hoge"
        if: ${{ env.APP == matrix.sample }}
      - run: echo "this is env if for fuga"
        if: ${{ env.APP == matrix.sample }}
      # github context reference
      - run: echo "this is github if event push"
        if: ${{ github.event_name == 'push' }}
      # matrix context reference
      - run: echo "this is matrix if for hoge"
        if: ${{ matrix.sample == 'hoge' }}
      - run: echo "this is matrix if for fuga"
        if: ${{ matrix.sample == 'fuga' }}

```

## Reusable workflow

GitHub Actions allow call workflow.
You can call local workflow of the same repository (Private repository), and remote workflow of the Public repository.

Callee wokflow must has `on.workflow_call` and yaml file must located under `.github/workflows/`.

```yaml
# .github/workflows/_reusable_workflow_called.yaml

name: reusable workflow called

on:
  workflow_call:
    inputs:
      username:
        required: true
        description: username to show
        type: string
    secrets:
      APPLES:
        description: secrets for APPLES
        required: true
    outputs:
      firstword:
        description: "The first output string"
        value: ${{ jobs.reusable_workflow_job.outputs.output1 }}
      secondword:
        description: "The second output string"
        value: ${{ jobs.reusable_workflow_job.outputs.output2 }}

jobs:
  reusable_workflow_job:
    runs-on: ubuntu-latest
    outputs:
      output1: ${{ steps.step1.outputs.firstword }}
      output2: ${{ steps.step2.outputs.secondword }}
    steps:
      - name: called username
        run: echo "called username. ${{ inputs.username }}"
      - name: called secret
        run: echo "called secret. ${{ secrets.APPLES }}"
      - name: output step1
        id: step1
        run: echo "::set-output name=firstword::hello"
      - name: output step2
        id: step2
        run: echo "::set-output name=secondword::world"

```

Caller workflow must use `uses: ./.github/workflows/xxxx.yaml` for private repo.

```yaml
# .github/workflows/reusable_workflow_caller.yaml

name: reusable workflow caller

on:
  pull_request:
    branches:
      - main
  workflow_dispatch:
    inputs:
      username:
        required: true
        description: ""
        type: string

# reusable workflow limitation.
# 1. Cannot call reusable workflow from reusable workflow.
# 2. Private repo can call same repo's reusable workflow. You can not call other private repo's workflow.
# 3. Caller Environment Variable never inherit to called reusable workflow.
# 4. Caller cannot use strategy (=matrix).

jobs:
  call-workflow-passing-data:
    uses: ./.github/workflows/_reusable_workflow_called.yaml
    with:
      username: ${{ github.event.inputs.username != '' && github.event.inputs.username || 'mona' }}
    secrets:
      APPLES: ${{ secrets.APPLES }}

  job2:
    runs-on: ubuntu-latest
    needs: call-workflow-passing-data
    steps:
      - run: echo ${{ needs.call-workflow-passing-data.outputs.firstword }} ${{ needs.call-workflow-passing-data.outputs.secondword }}

```

# Basic - Branch and tag handling

## Run when branch push only but skip on tag push

If you want run job only when push to branch, and not for tag push.

```yaml
# .github/workflows/branch_push_only.yaml

name: branch push only

on:
  push:
    branches: ["main"]
    tags:
      - "!*" # not a tag push

jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - run: echo not run on tag

```

## Skip when branch push but run on tag push only

If you want run job only when push to tag, and not for branch push.

```yaml
# .github/workflows/tag_push_only.yaml

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

## Build only specific tag pattern

You can use pattern on `on.push.tags`, but you can't on `step.if`.
This pattern will match following.

* 0.0.1
* 1.0.0+preview
* 0.0.3-20200421-preview+abcd123408534

not for below.

* v0.0.1
* release

```yaml
# .github/workflows/tag_push_only_pattern.yaml

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

## Get pushed tag name

You need extract refs to get tag name.
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

## Create release

You can create release and upload assets through GitHub Actions.
Multiple assets upload is supported by running running `actions/upload-release-asset` for each asset.

```yaml
# .github/workflows/create_release.yaml

name: create release

on:
  push:
    tags:
      - "[0-9]+.[0-9]+.[0-9]+*"

jobs:
  create-release:
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      # set release tag(*.*.*) to env.GIT_TAG
      - run: echo "GIT_TAG=${GITHUB_REF##*/}" >> "$GITHUB_ENV"

      - run: echo "hoge" > "hoge.${GIT_TAG}.txt"
      - run: echo "fuga" > "fuga.${GIT_TAG}.txt"
      - run: ls -l

      # Create Releases
      - uses: actions/create-release@v1
        id: create_release
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ github.ref }}
          release_name: Ver.${{ github.ref }}

      # Upload to Releases(hoge)
      - uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: hoge.${{ env.GIT_TAG }}.txt
          asset_name: hoge.${{ env.GIT_TAG }}.txt
          asset_content_type: application/octet-stream

      # Upload to Releases(fuga)
      - uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }}
          asset_path: fuga.${{ env.GIT_TAG }}.txt
          asset_name: fuga.${{ env.GIT_TAG }}.txt
          asset_content_type: application/octet-stream

```

## Schedule job on non-default branch

Schedule job will offer `Last commit on default branch`.

> ref: [Events that trigger workflows /- GitHub Help](https://help.github.com/en/actions/reference/events-that-trigger-workflows#scheduled-events-schedule)

schedule workflow should merge to default branch to apply workflow change.

Pass branch info when you want run checkout on non-default branch.
Don't forget pretend `refs/heads/` to your branch.

* good: refs/heads/some-branch
* bad: some-branch

```yaml
# .github/workflows/schedule_job.yaml

name: schedule job
on:
  schedule:
    - cron: "0 0 * * *"
jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - name: Dump GitHub context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(github) }}
      - uses: actions/checkout@v3
        with:
          ref: refs/heads/some-branch

```

# Basic - Commit handling

## Trigger via commit message

```yaml
# .github/workflows/trigger_ci.yaml

name: trigger ci commit

on:
  push:
    branches: ["main"]

jobs:
  build:
    if: "contains(toJSON(github.event.commits.*.message), '[build]')"
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - run: echo "$COMMIT_MESSAGES"
        env:
          COMMIT_MESSAGES: ${{ toJson(github.event.commits.*.message) }}

```

## Commit file handling

you can handle commit file handle with github actions [trilom/file/-changes/-action](https://github.com/trilom/file-changes-action).

```yaml
# .github/workflows/pr_path_changed.yaml

name: pr path changed
on: [pull_request]

jobs:
  changes:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - id: file_changes
        uses: trilom/file-changes-action@v1.2.4
        with:
          output: ","
          pushBefore: main
      - run: echo "${{ steps.file_changes.outputs.files }}"
      - if: contains(steps.file_changes.outputs.files, '.github/workflows/')
        run: echo changes contains .github/workflows/

```


# Basic - Issue and Pull Request handling

use [actions/github\-script](https://github.com/actions/github-script).

## Skip ci on pull request title

original `pull_request` event will invoke when activity type is `opened`, `synchronize`, or `reopened`.

> [Events that trigger workflows /- GitHub Help](https://help.github.com/en/actions/reference/events-that-trigger-workflows#pull-request-event-pull_request)

```yaml
# .github/workflows/skip_ci_pr_title.yaml

name: skip ci pr title

on: ["pull_request"]

jobs:
  skip:
    if: "!(contains(github.event.pull_request.title, '[skip ci]') || contains(github.event.pull_request.title, '[ci skip]'))"
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - run: echo "$GITHUB_CONTEXT"
        env:
          GITHUB_CONTEXT: ${{ toJson(github) }}
      - run: echo "$TITLE"
        env:
          TITLE: ${{ toJson(github.event.pull_request.title) }}

  build:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    needs: skip
    steps:
      - run: echo run when not skipped

```

## Skip pr from fork repo

default `pull_request` event trigger from even fork repository, however fork pr could not read `secrets` and may fail PR checks.
To control job to be skip from fork but run on self pr or push, use `if` conditions.

```yaml
# .github/workflows/skip_pr_from_fork.yaml

name: skip pr from fork

on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
    types:
      - opened
      - synchronize

jobs:
  build:
    # push & my repo will trigger
    # pull_request on my repo will trigger
    if: "(github.event == 'push' && github.repository_owner == 'guitarrapc') || startsWith(github.event.pull_request.head.label, 'guitarrapc:')"
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - run: echo build

```

## Detect labels on pull request

`pull_request` event contains tags and you can use it to filter step execution.
`${{ contains(github.event.pull_request.labels.*.name, 'hoge') }}` will return `true` if tag contains `hoge`.

```yaml
# .github/workflows/pr_label_get.yaml

name: pr label get
on:
  pull_request:
    types:
      - labeled
      - opened
      - reopened
      - synchronize

jobs:
  changes:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    env:
      IS_HOGE: "false"
    steps:
      - run: echo "${{ toJson(github.event.pull_request.labels.*.name) }}"
      - run: echo "IS_HOGE=${{ contains(github.event.pull_request.labels.*.name, 'hoge') }}" >> "$GITHUB_ENV"
      - run: echo "${IS_HOGE}"
      - run: echo "run!"
        if: env.IS_HOGE == 'true'

```

## Skip job when Draft PR

You can skip job and steps if Pull Request is Draft.
Unfortunately GitHub Webhook v3 event not provide draft pr type, but `event.pull_request.draft` shows `true` when PR is draft.

```yaml
# .github/workflows/skip_draft_pr.yaml

name: skip draft pr
on:
  pull_request:
  push:
    branches: ["main"]

jobs:
  build:
    if: "!(github.event.pull_request.draft)"
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v3

```

You can control behaviour with PR label.

```yaml
# .github/workflows/skip_draft_but_label_pr.yaml

name: skip draft pr but label
on:
  pull_request:
    types:
      - synchronize
      - opened
      - reopened
      - ready_for_review

jobs:
  build:
    # RUN WHEN
    # 1. PR has label 'draft_but_ci'
    # 2. Not draft, `push` and `non-draft pr`.
    if: ${{ (contains(github.event.pull_request.labels.*.name, 'draft_but_ci')) || !(github.event.pull_request.draft) }}
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v3

```


# Basic - BAD PATTERN

## Env refer env

You cannot use `${{ env. }}` in `env:` section.
Following is invalid with error.

> The workflow is not valid. .github/workflows/env_refer_env.yaml (Line: 12, Col: 16): Unrecognized named-value: 'env'. Located at position 1 within expression: env.global_env

```yaml
name: you can not refer env in env

on: ["push"]

env:
  global_env: global

jobs:
  build:
    runs-on: ubuntu-latest
    env:
      job_env: ${{ env.global_env }}
    steps:
      - run: echo "${{ env.global_env }}"
      - run: echo "${{ env.job_env }}"
```

# Advanced

Advanced tips.

## Dispatch other repo from workflow

You can dispatch this repository to other repository via calling GitHub `workflow_dispatch` event API.
You don't need use `repository_dispatch` event API anymore.


Target repo `testtest`'s workflow `test.yaml`.

```yaml
name: test
on:
  workflow_dispatch:

jobs:
  test:
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - uses: actions/checkout@v3
```

This repo will dispatch event with following worlflow.

```yaml
# .github/workflows/dispatch_changes_actions.yaml

name: dispatch changes actions
on:
  workflow_dispatch:

jobs:
  dispatch:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    strategy:
      matrix:
        repo: [guitarrapc/testtest] #Array of target repos
        include:
          - repo: guitarrapc/testtest
            ref: main
            workflow: test
    steps:
      - name: dispatch ${{ matrix.repo }}
        uses: benc-uk/workflow-dispatch@v1.1
        with:
          repo: ${{ matrix.repo }}
          ref: ${{ matrix.ref }}
          workflow: ${{ matrix.workflow }}
          token: ${{ secrets.SYNCED_GITHUB_TOKEN_REPO }}

```

You can use [Workflow Dispatch Action](https://github.com/marketplace/actions/workflow-dispatch) insead, like this.

```yaml
# .github/workflows/dispatch_changes_actions.yaml

name: dispatch changes actions
on:
  workflow_dispatch:

jobs:
  dispatch:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    strategy:
      matrix:
        repo: [guitarrapc/testtest] #Array of target repos
        include:
          - repo: guitarrapc/testtest
            ref: main
            workflow: test
    steps:
      - name: dispatch ${{ matrix.repo }}
        uses: benc-uk/workflow-dispatch@v1.1
        with:
          repo: ${{ matrix.repo }}
          ref: ${{ matrix.ref }}
          workflow: ${{ matrix.workflow }}
          token: ${{ secrets.SYNCED_GITHUB_TOKEN_REPO }}

```

## Lint GitHub Actions workflow itself

You can lint GitHub Actions yaml via actionlint.

If you don't need automated PR review, run actionlint is enough.

```yaml
# .github/workflows/actionlint.yaml

name: actionlint

on:
  workflow_dispatch:
  pull_request:
    branches: ["main"]
    paths:
      - ".github/workflows/**"

jobs:
  actionlint:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v3
      - name: Install actionlint
        run: bash <(curl https://raw.githubusercontent.com/rhysd/actionlint/main/scripts/download-actionlint.bash)
      - name: Run actionlint
        run: ./actionlint -color -oneline

```

If you need automated PR review, run actionlint with reviewdog.

```yaml
# .github/workflows/actionlint_reviewdog.yaml

name: actionlint (reviewdog)

on:
  workflow_dispatch:
  pull_request:
    branches: ["main"]
    paths:
      - ".github/workflows/**"

jobs:
  actionlint:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v3
      - name: actionlint
        uses: reviewdog/action-actionlint@v1
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          reporter: github-pr-review
          fail_on_error: true # workflow will fail when actionlint detect warning.

```

## Get PR info from Merge Commit

You have two choice.

1. Use git cli. Retrieve 1st and 3rd line of merge commit.
2. Use some action to retrieve PR info from merge commit.

Below use [jwalton/gh-find-current-pr](https://github.com/jwalton/gh-find-current-pr) to retrieve PR info from merge commit.

```yaml
# .github/workflows/pr_from_merge_commit.yaml

name: pr from merge commit
on:
  push:
    branches: ["main"]

jobs:
  get:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v3
      - uses: jwalton/gh-find-current-pr@v1
        id: pr
        with:
          state: closed
      - if: success() && steps.pr.outputs.number
        run: |
          echo "PR #${PR_NUMBER}"
          echo "PR Title: ${PR_TITLE}"
        env:
          PR_NUMBER: ${{ steps.pr.outputs.number }}
          PR_TITLE: ${{ steps.pr.outputs.title }}

```
