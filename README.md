[![auto doc](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto_doc.yaml/badge.svg)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto_doc.yaml)
[![auto dump context](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto_dump_context.yaml/badge.svg)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto_dump_context.yaml)
[![actionlint (reviewdog)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/actionlint_reviewdog.yaml/badge.svg)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/actionlint_reviewdog.yaml)
[![dotnet build](https://github.com/guitarrapc/githubactions-lab/actions/workflows/dotnet_build.yaml/badge.svg)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/dotnet_build.yaml)
[![dotnet lint](https://github.com/guitarrapc/githubactions-lab/actions/workflows/dotnet_lint.yaml/badge.svg)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/dotnet_lint.yaml)

# githubactions-lab

GitHub Actions research and test laboratory.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# Table of Contents

- [Not yet support](#not-yet-support)
- [Functionality limitation](#functionality-limitation)
- [Difference from other CI](#difference-from-other-ci)
  - [CI Migration](#ci-migration)
  - [Job and workflow](#job-and-workflow)
  - [Job Approval](#job-approval)
  - [Meta values and JobId](#meta-values-and-jobid)
  - [Path filter](#path-filter)
  - [Redundant build cancellation](#redundant-build-cancellation)
  - [Rerun failed workflow](#rerun-failed-workflow)
  - [Reusable job and workflow](#reusable-job-and-workflow)
  - [Set Environment variables](#set-environment-variables)
  - [Set Output](#set-output)
  - [Set PATH Environment variables](#set-path-environment-variables)
  - [Set Secrets for Job](#set-secrets-for-job)
  - [Skip CI and commit message](#skip-ci-and-commit-message)
  - [Git Checkout](#git-checkout)
- [Basic - Fundamentables](#basic---fundamentables)
  - [Dump context metadata](#dump-context-metadata)
  - [Environment variables in script](#environment-variables-in-script)
  - [If and context reference](#if-and-context-reference)
  - [Job needs and dependency](#job-needs-and-dependency)
  - [Job skip handling](#job-skip-handling)
  - [Permissions](#permissions)
  - [Reusable actions written in yaml - composite](#reusable-actions-written-in-yaml---composite)
  - [Reusable actions written in node - node12](#reusable-actions-written-in-node---node12)
  - [Reusable workflow](#reusable-workflow)
  - [Run when previous job is success](#run-when-previous-job-is-success)
  - [Run when previous step status is specific](#run-when-previous-step-status-is-specific)
  - [Run write Multiline code](#run-write-multiline-code)
  - [Strategy matrix and secret dereference](#strategy-matrix-and-secret-dereference)
  - [Strategy matrix and environment variables](#strategy-matrix-and-environment-variables)
  - [Timeout settings](#timeout-settings)
  - [Workflow Concurrency Control](#workflow-concurrency-control)
  - [Workflow dispatch and passing input](#workflow-dispatch-and-passing-input)
  - [Workflow dispatch with mixed input type](#workflow-dispatch-with-mixed-input-type)
  - [Workflow Redundant Control](#workflow-redundant-control)
- [Basic - Commit, Branch and Tag handling](#basic---commit-branch-and-tag-handling)
  - [Create release](#create-release)
  - [Detect file changed](#detect-file-changed)
  - [Schedule job on non-default branch](#schedule-job-on-non-default-branch)
  - [Trigger branch push only but skip on tag push](#trigger-branch-push-only-but-skip-on-tag-push)
  - [Trigger commit message](#trigger-commit-message)
  - [Trigger tag push only but skip on branch push](#trigger-tag-push-only-but-skip-on-branch-push)
  - [Trigger for specific tag pattern](#trigger-for-specific-tag-pattern)
- [Basic - Issue and Pull Request handling](#basic---issue-and-pull-request-handling)
  - [Detect labels on pull request](#detect-labels-on-pull-request)
  - [Skip ci on pull request title](#skip-ci-on-pull-request-title)
  - [Skip pr from fork repo](#skip-pr-from-fork-repo)
  - [Skip job when Draft PR](#skip-job-when-draft-pr)
- [Basic - BAD PATTERN](#basic---bad-pattern)
  - [Env refer env](#env-refer-env)
- [Advanced](#advanced)
  - [Checkout faster with Git sparse-checkout](#checkout-faster-with-git-sparse-checkout)
  - [Dispatch other repo workflow](#dispatch-other-repo-workflow)
  - [Fork user workflow change prevention](#fork-user-workflow-change-prevention)
  - [Lint GitHub Actions workflow itself](#lint-github-actions-workflow-itself)
  - [PR info from Merge Commit](#pr-info-from-merge-commit)
- [Cheat Sheet](#cheat-sheet)
  - [Actions naming](#actions-naming)
  - [Get Branch](#get-branch)
  - [Get Tag](#get-tag)
  - [Get Workflow Name](#get-workflow-name)
  - [Get Workflow Url](#get-workflow-url)
  - [GitHub Actions commit icon](#github-actions-commit-icon)
  - [Type converter with fromJson](#type-converter-with-fromjson)
  - [Detect PullRequest (PR) is Fork or not](#detect-pullrequest-pr-is-fork-or-not)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Not yet support

- [ ] YAML anchor support
  - [Support for YAML anchors \- GitHub Community Forum](https://github.community/t5/GitHub-Actions/Support-for-YAML-anchors/td-p/30336)
  - Workaround: There are CompositeActions and Reusable workflow to reuse same set of actions.
- [ ] GitHub Actions Grouping
  - Group GitHub Actions
  - No workaround.
- [ ] Test Insight view
  - Like [CircleCI](https://circleci.com/docs/insights-tests) and [Azure Pipeline](https://docs.microsoft.com/en-us/azure/devops/pipelines/test/review-continuous-test-results-after-build?view=azure-devops) provides.
  - Workaround is use [$GITHUB_STEP_SUMMARY](https://github.blog/2022-05-09-supercharging-github-actions-with-job-summaries/)
- [ ] SSH Debug
  - Like [CircleCI provides](https://circleci.com/docs/ssh-access-jobs).
  - Workaround: Use [Debugging with ssh Actions](https://github.com/marketplace/actions/debugging-with-ssh)
- [ ] Dynamic Config
  - Like [CircleCI provides](https://circleci.com/docs/dynamic-config).
  - Workaround: Reusable Workflow / Composite Actions with inputs parameter.
- [ ] Workflow level timeout-minutes
  - Currently timeout-minutes can set to jobs and steps, but workflow cannot change from default 360min.
  - No workaround. Please set `timeout-minutes` to every job.

# Functionality limitation

Relax the limit for `GitHub Team Plan` is myu strong expectation.

- [ ] `Environment > Deployment protection rules` is not allowed in GitHub team Plan. You cannot use `Required reviewers` (Approvabl) and `Wait timer`.

# Difference from other CI

## CI Migration

There are several documents for migration.

- CircleCI -> GitHub Actions: [Migrating from CircleCI to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-circleci-to-github-actions)
- Azure pipeline -> GitHub Actions: [Migrating from Azure Pipelines to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-azure-pipelines-to-github-actions)
- GitLab -> GitHub Actions: [Migrating from GitLab CI/CD to GitHub Actions \- GitHub Docs](https://docs.github.com/en/actions/migrating-to-github-actions/migrating-from-gitlab-cicd-to-github-actions)
- Jenkins -> GitHub Actions: [Migrating from Jenkins to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-jenkins-to-github-actions)

Also you may consider migrate from GitHub Actions.

- GitHub Actions -> CircleCI: [Migrating from Github Actions \- CircleCI](https://circleci.com/docs/migrating-from-github)

## Job and workflow

All CI has yaml definitions.

- ✔️: GitHub Actions define jobs inside workflow. Can trigger both Push and PR.

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

- ✔️: CircleCI define jobs and conbinate them in workflow. Can not trigger both Push and PR.

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

- ✔️: Azure Pipeline define jobs and conbinate them in stage. Can trigger both Push and PR.

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
      vmImage: "ubuntu-latest"
    steps:
      - bash: echo "foo"
```

- ⚠️: Jenkins has Declaretive Pipeline. Trigger needs to be defined outside pipeline.

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

## Job Approval

This functionality enables you to stop next job until manually approved.

- ⚠️: GitHub Actions supports Approval on **Environment**. However Environment cannot use in `GitHub Team` pricing.
- ✔️: CircleCI supports Approval.
- ✔️: Azure Pipelin supports Approval.
- ✔️: Jenkins supports Approval.

## Meta values and JobId

GitHub Actions has Context concept, you can access job specific info via `github`.
for example, `github.run_id` is A unique number for each run within a repository.
Also you can access default environment variables like `GITHUB_RUN_ID`.

- ✔️: GitHub Actions [environment variable](https://help.github.com/en/actions/configuring-and-managing-workflows/using-environment-variables#default-environment-variables) `GITHUB_RUN_ID` or [context](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context) `github.run_id`
- ✔️: CircleCI [environment vairable](https://circleci.com/docs/2.0/env-vars/#built-in-environment-variables) `CIRCLE_BUILD_NUM` and `CIRCLE_WORKFLOW_ID`
- ✔️: Azure Pipeline [environment variable](https://docs.microsoft.com/ja-jp/azure/devops/pipelines/process/run-number?view=azure-devops&tabs=yaml#tokens) `BuildID`.
- ✔️: Jenkins [environment vairable](https://wiki.jenkins.io/display/JENKINS/Building+a+software+project) `BUILD_NUMBER`

## Path filter

GitHub Actions can use `on.<event>.paths-ignore:` and `on.<event>.paths:` by default.

> [paths - Workflow syntax for GitHub Actions \- GitHub Help](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#onpushpull_requestpaths)

- ✔️: GitHub Actions **CAN** set path-filter.
- ❌: CircleCI can not set path-filter.
- ✔️: Azure Pipeline can set path-filter.
- ❌: Jenkins can not set path-filter. User should prepare by theirself.

## Redundant build cancellation

GitHub Actions not support exact functionality as CircleCI provide, but you can do via concurrency control. Another option is community actions like [rokroskar/workflow-run-cleanup-action](https://github.com/marketplace/actions/workflow-run-cleanup-action), [fauguste/auto-cancellation-running-action](https://github.com/marketplace/actions/auto-cancellation-running-action) and [yellowmegaman/gh-build-canceller](https://github.com/marketplace/actions/gh-actions-stale-run-canceller).

- ✔️: GitHub Actions has concurrency control and it can cancel in progress build. Or your can use community Actions.
- ✔️: CircleCI support cancel redundant build.
- ❌: Azure Pipeline not support cancel redundant build.
- ❌: Jenkins not support cancel redundant build, you need cancel it from parallel job.

## Rerun failed workflow

- ✔️: GitHub Actions support Re-run jobs. You can re-run for `whole workflow`, `single job` and `failed job`.
- ✔️: CircleCI support Re-run jobs. You can re-run `whole workflow` or `failed job` again.
- ⚠️: Azure Pipeline not support Re-run stage but you can not re-run `failed job` only.
- ✔️: Jenkins Declarative Pipeline support Re-run jobs. You can re-run `Job` or `Stage` again. But you may find it is unstable.

## Reusable job and workflow

Write script is better than directly write on the step, so that we can reuse same execution from other workflows or jobs.

- ✔️: GitHub Actions can reuse yaml via `Reusable workflow`, `Composite Actions` and `Organization workflow`.
- ✔️: CircleCI can reuse job, and also `YAML anchor` is useul.
- ✔️: Azure Pipeline has template to refer stage, job and step from other yaml.
- ⚠️: Jenkins pipeline could refer other pipeline. However a lot case you would prefer define job step in script and reuse it. Reusing pipeline easily make it complex with Jenkins.

## Set Environment variables

Define `Environment varialbes` in each job step, then reuse it later step is common pattern.

- ✔️: GitHub Actions [use redirect to special Environment variable](https://help.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-environment-variable) `$GITHUB_ENV` via `echo "{environment_variable_name}={value}" >> $GITHUB_ENV` (Linux) or `"{environment_variable_name}={value}" >> $env:GITHUB_ENV` (Windows) syntax.
- `::set-env` syntax has been deprecated for [security reason](https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands/).
- ✔️: CircleCI use redirect to special Environment variable `$BASH_ENV` via `echo "export GIT_SHA1=$CIRCLE_SHA1" >> $BASH_ENV` syntax.
- ✔️: Azure Pipeline use task.setvariable via `echo "##vso[task.setvariable variable=NAME]VALUE"` syntax.
- ✔️: Jenkins use `Env.`.

## Set Output

Define `output` in each job step, then reuse it later step is less side-effect than environment variable. Also it can pass value between job via `job output` , and it can't achieve with environment variable pattern.

- ✔️: GitHub Actions [use redirect to special Environment variable](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#setting-an-output-parameter) `$GITHUB_OUTPUT` via `echo "{name}={value}" >> "$GITHUB_OUTPUT"` (Linux) or `"{name}=value" >> $env:GITHUB_OUTPUT` (Windows) syntax.
- ⚠️: CircleCI has no equivalent but use Environment Variables.
- ✔️: Azure Pipeline use task.setvariable via `echo "##vso[task.setvariable variable=NAME;isoutput=true]VALUE"` syntax.
- ⚠️: Jenkins has no equivalent but use Environment Variables.

> **Info** GitHub Actions `::set-output` syntax has been deprecated for [security reason](https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/).

## Set PATH Environment variables

- ✔️: GitHub Actions use redirect to special Environment variable `$GITHUB_PATH` via `echo "{path}" >> "$GITHUB_PATH"` or `echo "{path}" | tee -a "$GITHUB_PATH"` syntax.
- `::add-path` syntax has been deprecated for [security reason](https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands/).
- ✔️: CircleCI use redirect to special Environment variable `$BASH_ENV` wiht name `PATH` via `echo "export PATH=$GOPATH/bin:$PATH" >> $BASH_ENV` syntax.
- ✔️: Azure Pipeline use task.setvariable via `echo '##vso[task.setvariable variable=path]$(PATH):/dir/to/whatever'` syntax.
- ✔️: Jenkins use `Env.`.

## Set Secrets for Job

GitHub ACtions offer Secrets for each repository and Organization. Secrets will be masked on the log, and also [you can mask desired output in log](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#masking-a-value-in-a-log).

- ✔️: GitHub Actions use Secrets and Environment Secrets.
- ✔️: CircleCI offer Environment Variables and Context.
- ✔️: Azure Pipeline has Environment Variables and Paramter.
- ✔️: Jenkins has Credential Provider.

GitHub Actions supports "Organization Secrets", "Repository Secrets" and "Environment Secrets".

- You can set secrets for Organization and filter to selected repository with `Organization > Settings > Secrets`.
- You can set secrets for each repository with `Repository > Settings > Secrets`.
- You can set Environment secrets for each repository with `Repository > Environment > Secrets`.

If same secrets key is exists, winner is `Environment Secrets` > `Repository Secrets` > `Organization Secrets`.

If you want spread your secrets with personal account, you need set each repository secrets or use [google/secrets\-sync\-action](https://github.com/google/secrets-sync-action).

## Skip CI and commit message

GitHub Actions support when HEAD commit contains key word like other ci.

- ✔️: GitHub Actions can skip workflow via `[skip ci]`, `[ci skip]`, `[no ci]`, `[skip actions]` or `[actions skip]`. If PR last commit message contains `[skip ci]`, then merge commit also skip.
- ✔️: CircleCI can skip job via `[skip ci]` or `[ci skip]`. If PR last commit message contains `[skip ci]`, then merge commit also skip.
- ✔️: Azure Pipeline can skip job via `***NO_CI***`, `[skip ci]` or `[ci skip]`, or [others](https://github.com/Microsoft/azure-pipelines-agent/issues/858#issuecomment-475768046).
- ❌: Jenkins not support skip ci on default, but there are plugins to support `[skip ci]` or any expression w/pipeline like [SCM Skip \| Jenkins plugin](https://plugins.jenkins.io/scmskip/).

## Git Checkout

GitHub Actions support checkout by actions and supports variety of checkout options include sparse checkout.

- ✔️: GitHub Actions [actions/checkout](https://github.com/actions/checkout) support `ssh` or `https` protocol, `submodule`, `shallow-clone`, `sparse checkout` and `lfs`. `actions/checkout` is default `shallow-clone` (depth 1).
- ⚠️: CircleCI [checkout](https://circleci.com/docs/configuration-reference/#checkout) support `ssh` or `https` protocol. It missing `submodule`, `shallow-clone`, `sparse-checkout` and `lfs` support. `checkout` is default full clone.
- ✔️: Azure Pipeline [checkout](https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/steps-checkout?view=azure-pipelines) support `ssh` or `https` protocol, `submodule`, `shallow-clone` and `lfs`. It missing `sparse-checkout` support. `checkout` is default `shallow-clone` (depth 1) for new pipeline created after the September 2022.
- ✔️: Jenkins [GitSCM](https://www.jenkins.io/doc/pipeline/steps/params/gitscm/) support `ssh` or `https` protocol, `submodule`, `shallow-clone`, `sparse checkout` and `lfs`. `GitSCM` is default full clone.

# Basic - Fundamentables

## Dump context metadata

Use Context to retrive job id, name and others system info.
Make sure you can not refer `gitHub` context in script.

> see: [Context and expression syntax for GitHub Actions \- GitHub Help](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context)

```yaml
# .github/workflows/context_github.yaml

name: "context github"
on:
  issue_comment:
    types: [created]
  push:
    branches: ["main"]
    tags: ["*"]
  pull_request:
    branches: ["main"]
    types: [opened, synchronize, reopened, closed]
  schedule:
    - cron: "0 0 * * *"
  workflow_dispatch:

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

```yaml
# .github/workflows/dump_context.yaml

name: dump context
on:
  issue_comment:
    types: [created]
  push:
    branches: ["main"]
    tags: ["*"]
  pull_request:
    branches: ["main"]
    types: [opened, synchronize, reopened, closed]
  schedule:
    - cron: "0 0 * * *"
  workflow_dispatch:

jobs:
  dump:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v4
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
      - uses: actions/checkout@v4
      - run: echo "GIT_TAG=${GITHUB_REF#refs/heads/}" >> "$GITHUB_ENV"
      - run: echo ${{ env.GIT_TAG }}
      - run: bash -eux .github/scripts/setenv.sh --ref "${GITHUB_REF#refs/heads/}"
      - run: echo ${{ env.GIT_TAG_SCRIPT }}
```

`echo ${{ env.GIT_TAG_SCRIPT }}` will output `chore/context_in_script` as expected.

## If and context reference

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

## Job needs and dependency

You can handle Job dependency with `needs`.

Basic usage is `needs: <job_name>`. Let's check [official example](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idneeds).

**Requiring successful dependent jobs**

Following example shows require successful dependent jobs.`job2` will run after `job1` is success, and `job3` will run after `job1` and `job2` are success. It means `job2` & `job3` never run when `job1` failed, `job3` never run when `job2` failed. In result, jobs are run seqientially in order of `job1` -> `job2` -> `job3`.

```yaml
jobs:
  job1:
  job2:
    needs: job1
  job3:
    needs: [job1, job2]
```

See actual sample.

```yaml
# .github/workflows/needs_require_success.yaml

name: Needs requiring successful dependent jobs

on:
  push:
    branches: main
  pull_request:
    branches: main
  workflow_dispatch:

jobs:
  A:
    runs-on: ubuntu-latest
    steps:
      - run: echo "a"

  B:
    needs: [A]
    runs-on: ubuntu-latest
    steps:
      - run: echo "b"

  # Run only if A and B success
  C:
    needs: [A, B]
    runs-on: ubuntu-latest
    steps:
      - run: echo "c"

```

**Not requiring successful dependent jobs**

`job3` uses the `always()` conditional expression. So that`job3` will run regardless of `job1` and `job2` job result is success or failure. Because of `needs` section, jobs are run seqientially in order of `job1` -> `job2` -> `job3`.

```yaml
jobs:
  job1:
  job2:
    needs: job1
  job3:
    if: ${{ always() }}
    needs: [job1, job2]
```

See actual sample.

```yaml
# .github/workflows/needs_not_require_success.yaml

name: Needs not requiring successful dependent jobs

on:
  push:
    branches: main
  pull_request:
    branches: main
  workflow_dispatch:

jobs:
  A:
    runs-on: ubuntu-latest
    steps:
      - run: echo "a"

  B:
    needs: [A]
    runs-on: ubuntu-latest
    steps:
      - run: echo "b"

  # always run without A and B result
  C:
    needs: [A, B]
    if: ${{ always() }}
    runs-on: ubuntu-latest
    steps:
      - run: echo "c"

```

## Job skip handling

Job `needs` can be used for skip handling. However skipping dependent job cause trouble.

Following workflow expected to run `D` when `C` is invoked. But skipping `A` and `B` cause `D` skip.

```yaml
# .github/workflows/needs_skip_no_handling.yaml

name: Needs skip on dependent jobs

on:
  push:
    branches: main
  pull_request:
    branches: main
  workflow_dispatch:

jobs:
  A:
    if: ${{ false }}
    runs-on: ubuntu-latest
    steps:
      - run: echo "a"

  B:
    if: ${{ false }}
    runs-on: ubuntu-latest
    steps:
      - run: echo "b"

  C:
    runs-on: ubuntu-latest
    steps:
      - run: echo "c"

  # D will always skip because A and B is skipped
  D:
    needs: [A, B, C]
    runs-on: ubuntu-latest
    steps:
      - run: echo "d"

```

To handle `D` to run when `C` is invoked, you need to add `if` condition to `D`. Also handle when no conditional `C` invokation, `A`, `B` and `C` is success, then `D` must run.

```yaml
# .github/workflows/needs_skip_handling.yaml

name: Needs run on specific job run

on:
  push:
    branches: main
  pull_request:
    branches: main
  workflow_dispatch:
    inputs:
      only-c:
        description: 'Run only Job C'
        required: false
        default: false
        type: boolean

jobs:
  A:
    if: ${{ !inputs.only-c }}
    runs-on: ubuntu-latest
    steps:
      - run: echo "a"

  B:
    if: ${{ !inputs.only-c }}
    runs-on: ubuntu-latest
    steps:
      - run: echo "b"

  C:
    runs-on: ubuntu-latest
    steps:
      - run: echo "c"

  # D will run when "C is success" or "all the jobs are success".
  D:
    needs: [A, B, C]
    if: ${{ inputs.only-c && needs.C.result == 'success' || success() }}
    runs-on: ubuntu-latest
    steps:
      - run: echo "d"

```

## Permissions

GitHub Actions supports specify permissions for each job or workflow.

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

The most important permission is `id-tokens: write`. It enables job to use OIDC like AWS, Azure and GCP.

## Reusable actions written in yaml - composite

To reuse local job, create local composite action is easiest way to do, this is calls `composite actions`.
Create yaml file inside local action path, then declare `using: "composite"` in local action.yaml.

- step1. Place your yaml to `.github/actions/YOUR_DIR/action.yaml`
- step2. Write your composite actions yaml.

```yaml
# .github/actions/local-composite-actions/action.yaml

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

- step3. Use actions from your workflow.

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
      - uses: actions/checkout@v4
      - name: use local action
        uses: ./.github/actions/local-composite-actions
        with:
          foo: BAR
```

## Reusable actions written in node - node12

To reuse local job, create local node action is another way to do, this is calls `node actions`.
Create yaml file inside local action path, then declare `using: "node12"` in local action.yaml.
Next place your Node.js source files inside actions directory, you may require `index.js` for entrypoint.

> TIPS: You may find it is useful when you are running on GHE and copy GitHub Actions to your local.

- step1. Place your ation.yaml to `.github/actions/YOUR_DIR/actions.yaml`
- step2. Write your node actions yaml.

```yaml
# .github/actions/local-node-actions/action.yaml

name: "Hello World"
description: |
  Desctiption of your action
runs:
  using: "node12"
  main: "index.js"
```

- step3. Write your source code to `.github/actions/YOUR_DIR/*.js`.

```js
// .github/actions/local-node-actions/index.js

console.log("Hello, World!");
```

- step4. Use actions from your workflow.

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
      - uses: actions/checkout@v4
      - name: use local action
        uses: ./.github/actions/local-node-actions
```

## Reusable workflow

GitHub Actions allow call workflow from workflow.
You can call local workflow of the same repository (Private repository), and remote workflow of the Public repository.

> detail: [Reusing workflows \- GitHub Docs](https://docs.github.com/ja/actions/using-workflows/reusing-workflows)

### Caller Limitations

There are limitations on Reusable workflow caller.

1. Private repo can call same repo's reusable workflow, but can not call other private repo's workflow.
1. Caller cannot use ${{ env.FOO }} for `with` inputs.
   ```yaml
   jobs:
     bad:
       runs-on: ubuntu-latest
       steps:
         uses: ./.github/workflows/dummy.yaml
         with:
           value: ${{ env.FOO }} # caller can not use `env.` in with block.
         secrets: inherit
   ```

### Callee Limitations

1. Callee workflow must place under `.github/workflows/`. Otherwise caller treated as calling public workflow.
   ```bash
   $ ls -l ./.github/workflows/
   ```
1. Callee cannot refer Caller's Environment Variable.
   ```yaml
   env:
     FOO: foo # Reusable workflow callee cannot refer this env.
   jobs:
     bad:
       runs-on: ubuntu-latest
       steps:
         uses: ./.github/workflows/dummy.yaml
   ```

### Reusable workflow definition sample

Place Reusable workflow yaml file under `.github/workflows/` then set `on.workflow_call` trigger, you are ready for reusable workflow.
Any `inputs`, `secrets` and `outputs` should define onder on.workflow_call.

```yaml
# .github/workflows/_reusable_workflow_called.yaml

name: _reusable workflow called
on:
  workflow_call:
    inputs:
      username:
        required: true
        description: username to show
        type: string
      is-valid:
        required: true
        description: username to show
        type: boolean
    outputs:
      firstword:
        description: "The first output string"
        value: ${{ jobs.reusable_workflow_job.outputs.output1 }}
      secondword:
        description: "The second output string"
        value: ${{ jobs.reusable_workflow_job.outputs.output2 }}
env:
  FOO: foo
jobs:
  reusable_workflow_job:
    runs-on: ubuntu-latest
    outputs:
      output1: ${{ steps.step1.outputs.firstword }}
      output2: ${{ steps.step2.outputs.secondword }}
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ github.event_name == 'pull_request' && github.event.pull_request.head.ref || '' }} # checkout PR HEAD commit instead of merge commit
      - name: (Limitation) Callee can not refer caller environment variable.
        run: echo "caller environment. ${{ env.CALLER_VALUE }}"
      - name: called username
        run: echo "called username. ${{ inputs.username }}"
      - name: called is-valid
        run: echo "called is-valid. ${{ inputs.is-valid }}"
      - name: called secret
        run: echo "called secret. ${{ secrets.APPLES }}"
      - name: called env (global)
        run: echo "called global env. ${{ env.FOO }}"
      - name: set variable (GITHUB_ENV)
        run: echo "IS_VALID=${{ inputs.is-valid }}" >> "$GITHUB_ENV"
      - name: called env (GITHUB_ENV)
        run: echo "called env. ${{ env.IS_VALID }}"
      - name: output step1
        id: step1
        run: echo "firstword=hello" >> "$GITHUB_OUTPUT"
      - name: output step2
        id: step2
        run: echo "secondword=world" >> "$GITHUB_OUTPUT"
```

### Call repository's reusable workflow

To call Reusable workflow, use `uses: ./.github/workflows/xxxx.yaml`.

When you want pass `boolean` type of input from workflow_dispatch to workflow_call, use `fromJson(inputs.YOUR_BOOLEAN_PARAMETER)`.
See [Type converter with fromJson](#type-converter-with-fromJson) for the detail.

```yaml
# .github/workflows/reusable_workflow_caller_internal.yaml

name: reusable workflow caller (internal)
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch:

# (Limitation) Callee can not refer caller environment variable.
env:
  CALLER_VALUE: caller
jobs:
  call-workflow-passing-data:
    uses: ./.github/workflows/_reusable_workflow_called.yaml
    with:
      username: "foo"
      is-valid: true
    secrets: inherit

  job2:
    runs-on: ubuntu-latest
    needs: call-workflow-passing-data
    steps:
      - run: echo ${{ needs.call-workflow-passing-data.outputs.firstword }} ${{ needs.call-workflow-passing-data.outputs.secondword }}
```

### Call public repository's reusable workflow

Yo call public repository's reusable workflow, use `uses: GITHUB_OWNER/REPOSITORY/.github/workflows/xxxx.yaml@<ref>`.

> **Warning**: To call private repository's reusable workflow, you must use absolute path of self repository.

```yaml
# .github/workflows/reusable_workflow_public_caller.yaml

name: reusable workflow caller (public)
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch:

jobs:
  call-workflow-passing-data:
    uses: guitarrapc/githubactions-lab/.github/workflows/_reusable_workflow_called.yaml@main
    with:
      username: foo
      is-valid: true
    secrets: inherit

  job2:
    runs-on: ubuntu-latest
    needs: call-workflow-passing-data
    steps:
      - run: echo ${{ needs.call-workflow-passing-data.outputs.firstword }} ${{ needs.call-workflow-passing-data.outputs.secondword }}
```

### Call reusable workflow with matrix

Reusable Workflow caller cannot use matrix, but callee can use matrix. (see limitation.)

```yaml
# .github/workflows/reusable_workflow_caller_matrix.yaml

name: reusable workflow caller (matrix)
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch:

jobs:
  call-matrix-workflow:
    strategy:
      matrix:
        username: [foo, bar]
    uses: ./.github/workflows/_reusable_workflow_called.yaml
    with:
      username: ${{ matrix.username }}
      is-valid: true
    secrets: inherit
```

### Nest reusable workflow

Reusalbe workflow can call other reusable workflow, it means nested call is supported.

```yaml
# .github/workflows/_reusable_workflow_nest.yaml

name: _reusable workflow nest
on:
  workflow_call:
    inputs:
      username:
        required: true
        description: username to show
        type: string
      is-valid:
        required: true
        description: username to show
        type: boolean

# nested call is supported
jobs:
  call-workflow-passing-data:
    uses: ./.github/workflows/_reusable_workflow_called.yaml
    with:
      username: ${{ inputs.username }}
      is-valid: ${{ inputs.is-valid }}
    secrets: inherit
```

## Run when previous job is success

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

## Run when previous step status is specific

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

## Run write Multiline code

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
      github.event_name == 'push' || github.event.forced == false
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

## Strategy matrix and secret dereference

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

## Strategy matrix and environment variables

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

## Timeout settings

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

## Workflow Concurrency Control

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

## Workflow dispatch and passing input

GitHub Actions offer `workflow_dispatch` event to execute workflow manually from Web UI.
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
      BRANCH: ${{ inputs.branch }}
      LOGLEVEL: ${{ inputs.logLevel }}
      TAGS: ${{ inputs.tags }}
    steps:
      - run: echo ${{ env.BRANCH }} ${{ env.LOGLEVEL }} ${{ env.TAGS }}
      - uses: actions/checkout@v4
        with:
          ref: ${{ inputs.branch }}
      - name: dump github context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(github) }}
      - name: dump inputs context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(github.event.inputs) }}
      - run: |
          echo "Log level: ${{ inputs.logLevel }}"
          echo "Tags: ${{ inputs.tags }}"
      # INPUT_ not automatcally generated
      - run: |
          echo "${INPUT_TEST_VAR}"
          echo "${TEST_VAR}"
      - run: echo "/path/to/dir" >> "$GITHUB_PATH"
      - run: |
          echo "INPUT_LOGLEVEL=${{ inputs.logLevel }}" >> "$GITHUB_ENV"
          echo "INPUT_TAGS=${{ inputs.tags }}" >> "$GITHUB_ENV"
      - run: |
          echo "Log level: ${INPUT_LOGLEVEL}"
          echo "Tags: ${INPUT_TAGS}"
      - run: export
```

Even if you specify action inputs, input value will not store as ENV var `INPUT_{INPUTS_ID}` as usual.

## Workflow dispatch with mixed input type

Workflow dispatch supported input type.

- boolean: `true` or `false` and Web UI offers checkbox.
- choice: enum options and Web UI offers selection box.
- environment: enum GitHub Environments and Web UI offers selection box.

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
        description: "use-emoji: Include 🎉🤣 emojis"
        required: true
      environment:
        type: environment
        description: "environment: Select environment"
        required: true
jobs:
  greet:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - name: Send greeting (github.event.inputs)
        run: |
          echo "message: ${{ github.event.inputs.message }}"
          echo "name: ${{ github.event.inputs.name }}"
          echo "use-emoji (string): ${{ github.event.inputs.use-emoji == 'true' }}"
          echo "use-emoji (bool): ${{ github.event.inputs.use-emoji == true }}"
      - name: Send greeting (inputs)
        run: |
          echo "message: ${{ inputs.message }}"
          echo "name: ${{ inputs.name }}"
          echo "use-emoji (string): ${{ inputs.use-emoji == 'true' }}"
          echo "use-emoji (bool): ${{ inputs.use-emoji == true }}"
      - name: Emoji
        run: echo "🥳 😊"
```

## Workflow Redundant Control

> **Note**
> Consider using Workflow Concurrency control instead of redundant control.

Creating PR emmits two events, `push` and `pull_request/synchronize`. This means duplicate build began and wastes build time.
Redundant build may trouble when you are runnning Private Repository, bacause there are build time limits. In other words, you don't need mind build comsume time when repo is Public.

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
    branches: ["main"]
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

# Basic - Commit, Branch and Tag handling

## Create release

## Detect file changed

you can handle commit file handle with GitHub actions [trilom/file/-changes/-action](https://github.com/trilom/file-changes-action).

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

## Schedule job on non-default branch

Schedule job will offer `Last commit on default branch`.

> ref: [Events that trigger workflows /- GitHub Help](https://help.github.com/en/actions/reference/events-that-trigger-workflows#scheduled-events-schedule)

schedule workflow should merge to default branch to apply workflow change.

Pass branch info when you want run checkout on non-default branch.
Don't forget pretend `refs/heads/` to your branch.

- good: refs/heads/some-branch
- bad: some-branch

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
      - uses: actions/checkout@v4
        with:
          ref: refs/heads/some-branch
```

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

## Trigger branch push only but skip on tag push

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

## Trigger commit message

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

## Trigger tag push only but skip on branch push

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

## Trigger for specific tag pattern

You can use pattern on `on.push.tags`, but you can't on `step.if`.
This pattern will match following.

- 0.0.1
- 1.0.0+preview
- 0.0.3-20200421-preview+abcd123408534

not for below.

- v0.0.1
- release

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

# Basic - Issue and Pull Request handling

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
      - uses: actions/checkout@v4
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
      - uses: actions/checkout@v4
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

## Checkout faster with Git sparse-checkout

[actions/checkout](https://github.com/actions) supports both [shallow-clone](https://git-scm.com/docs/shallow) and [sparse checkout](https://git-scm.com/docs/git-sparse-checkout) which is quite useful for monorepository. Typically, monorepository contains many folders and files, but you may want to checkout only specific folder or files.

- `shallow-clone` offers faster checkout by limiting depth of clone to latest 1 or N commits.
- `sparse checkout` offers faster checkout by limiting checkout files and folders.

> **Note**: actions/checkout supports `git sparse-checkout`, since 2023/June.

Let's see what is difference between `shallow-clone` and `sparse-checkout`.

**Shallow clone**

Shallow clones use the `--depth=<N>` parameter in `git clone` to truncate the commit history. Typically, --depth=1 signifies that we only care about the most recent commits. This drastically reduces the amount of data that needs to be fetched, leading to faster clones and less storage of shallow history.

![](https://github.blog/jp/wp-content/uploads/sites/2/2021/01/Image4.png?w=800&resize=800%2C414)

> ref: https://github.blog/2020-12-21-get-up-to-speed-with-partial-clone-and-shallow-clone/

**Sparse checkout**

Sparse checkout use the `git sparse-checkout set <PATH>` before `git clone` to truncate the checkout files and folders. This amazingly reduces the amount of data that needs to be fetched, leading to faster checkout and less storage of limited paths.

![](https://i0.wp.com/user-images.githubusercontent.com/121322/72286599-50af8e00-35fa-11ea-9025-d7cbb730192c.png?ssl=1)

> ref: https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/

Sparce checkout has 2 modes, `git sparse-checkout` and `git sparse-checkout --cone`. You can specify `cone` or not with `sparse-checkout-cone-mode` option. So what the difference between `cone` and not `cone`? Normally `sparse-checkout-cone-mode: true` is faster than `sparse-checkout-cone-mode: false`. But `cone` mode has some limitation, you cannot exclude specific folder. So you need to choose which mode is better for you.

- `sparse checkout: src` & `sparse-checkout-cone-mode: true`, checkout `src` folder and root files.
- `sparse checkout: src/*` & `sparse-checkout-cone-mode: false`, checkout `src` folder only.
- `sparse checkout: !src` & `sparse-checkout-cone-mode: true`, you can not use `sparse-checkout-cone-mode: true` with exclude folder.
- `sparse checkout: !src/*` & `sparse-checkout-cone-mode: false`, you can exlude `src` folder from checkout, but you need specify which folder you want to checkout.

**Sparse checkout**

Checkout "src/\*" and root files, but not checkout any not specified folders.

```yaml
# .github/workflows/git_sparsecheckout.yaml

name: git sparse-checkout
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
jobs:
  sparse-checkout:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@v4
        with:
          sparse-checkout: |
            src
      - name: list root folders
        run: ls -la
      - name: list src folders
        run: ls -laR ./src
```

Result is selected `src` folder and root files will checkout.

```sh
$ ls -la
total 104
drwxr-xr-x 4 runner docker  4096 Jun 14 10:23 .
drwxr-xr-x 3 runner docker  4096 Jun 14 10:23 ..
-rw-r--r-- 1 runner docker  3557 Jun 14 10:23 .editorconfig
drwxr-xr-x 8 runner docker  4096 Jun 14 10:23 .git
-rw-r--r-- 1 runner docker   103 Jun 14 10:23 .gitattributes
-rw-r--r-- 1 runner docker     5 Jun 14 10:23 .gitignore
-rw-r--r-- 1 runner docker  1083 Jun 14 10:23 LICENSE.md
-rw-r--r-- 1 runner docker 70249 Jun 14 10:23 README.md
drwxr-xr-x 8 runner docker  4096 Jun 14 10:23 src

$ ls -laR ./src
./src:
total 32
drwxr-xr-x 8 runner docker 4096 Jun 14 10:23 .
drwxr-xr-x 4 runner docker 4096 Jun 14 10:23 ..
drwxr-xr-x 5 runner docker 4096 Jun 14 10:23 dotnet
drwxr-xr-x 2 runner docker 4096 Jun 14 10:23 json
drwxr-xr-x 6 runner docker 4096 Jun 14 10:23 k8s
drwxr-xr-x 2 runner docker 4096 Jun 14 10:23 mermaid
drwxr-xr-x 2 runner docker 4096 Jun 14 10:23 shellscript
drwxr-xr-x 2 runner docker 4096 Jun 14 10:23 txt

.... others
```

**Sparse checkout and specify which file to checkout**

Checkout only "src/\*" path. All other files and folders will not checkout.

```yaml
# .github/workflows/git_sparsecheckout_nocorn.yaml

name: git sparse-checkout (no corn)
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
jobs:
  sparse-checkout:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@v4
        with:
          sparse-checkout: |
            src/*
          sparse-checkout-cone-mode: false # required for ! entry to work
      - name: list root folders
        run: ls -la
      - name: list src folders
        run: ls -laR ./src
```

Result is selected `src` folder and root files will checkout.

```sh
$ ls -la
total 16
drwxr-xr-x 4 runner docker 4096 Jun 14 10:23 .
drwxr-xr-x 3 runner docker 4096 Jun 14 10:23 ..
drwxr-xr-x 8 runner docker 4096 Jun 14 10:23 .git
drwxr-xr-x 8 runner docker 4096 Jun 14 10:23 src

$ ls -laR ./src
./src:
total 32
drwxr-xr-x 8 runner docker 4096 Jun 14 10:23 .
drwxr-xr-x 4 runner docker 4096 Jun 14 10:23 ..
drwxr-xr-x 5 runner docker 4096 Jun 14 10:23 dotnet
drwxr-xr-x 2 runner docker 4096 Jun 14 10:23 json
drwxr-xr-x 6 runner docker 4096 Jun 14 10:23 k8s
drwxr-xr-x 2 runner docker 4096 Jun 14 10:23 mermaid
drwxr-xr-x 2 runner docker 4096 Jun 14 10:23 shellscript
drwxr-xr-x 2 runner docker 4096 Jun 14 10:23 txt

.... others
```

**Sparse checkout exclude path**

Checkout except "src/_" path. All other files and folders will checkout by `/_`.

```yaml
# .github/workflows/git_sparsecheckout_exclude.yaml

name: git sparse-checkout (exclude)
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
jobs:
  sparse-checkout:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@v4
        with:
          sparse-checkout: |
            !src/*
            /*
          sparse-checkout-cone-mode: false # required for ! entry to work
      - name: list root folders
        run: ls -la
      - name: list .github folders
        run: ls -laR ./.github
```

Result is exclude `src` folder and all other files are checkout.

```sh
$ ls -la
total 108
drwxr-xr-x 5 runner docker  4096 Jun 14 10:23 .
drwxr-xr-x 3 runner docker  4096 Jun 14 10:23 ..
-rw-r--r-- 1 runner docker  3557 Jun 14 10:23 .editorconfig
drwxr-xr-x 8 runner docker  4096 Jun 14 10:23 .git
-rw-r--r-- 1 runner docker   103 Jun 14 10:23 .gitattributes
drwxr-xr-x 5 runner docker  4096 Jun 14 10:23 .github
-rw-r--r-- 1 runner docker     5 Jun 14 10:23 .gitignore
-rw-r--r-- 1 runner docker  1083 Jun 14 10:23 LICENSE.md
-rw-r--r-- 1 runner docker 70249 Jun 14 10:23 README.md
drwxr-xr-x 5 runner docker  4096 Jun 14 10:23 samples

$ ls -laR ./.github
./.github:
total 24
drwxr-xr-x  5 runner docker 4096 Jun 14 10:23 .
drwxr-xr-x  5 runner docker 4096 Jun 14 10:23 ..
drwxr-xr-x 12 runner docker 4096 Jun 14 10:23 actions
-rw-r--r--  1 runner docker  117 Jun 14 10:23 ban-words.txt
drwxr-xr-x  2 runner docker 4096 Jun 14 10:23 scripts
drwxr-xr-x  3 runner docker 4096 Jun 14 10:23 workflows

.... others
```

## Dispatch other repo workflow

You can dispatch this repository to other repository via calling GitHub `workflow_dispatch` event API.
You don't need use `repository_dispatch` event API anymore.

**Target repository workflow**

Here's target repo `testtest` workflow `test.yaml`.

```yaml
name: test
on:
  workflow_dispatch:

jobs:
  test:
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - uses: actions/checkout@v4
```

**Dispatcher workflow**

This repo will dispatch event with [Workflow Dispatch Action](https://github.com/marketplace/actions/workflow-dispatch) actions.

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

## Fork user workflow change prevention

One of GitHub's vulnerable point is Workflow. Editting Workflow shoulbe be requirement when using `secrets` and authenticate some service on workflow.

Easiest and simple way is use `pull_request` target and path filter, then detect PR is fork or not. There might be many ways to prevent file change. `xalvarez/prevent-file-change-action` can guard change in the step. Using `tj-actions/changed-files`, `dorny/paths-filter`, or others will be flexible way to detect change and do what you want.

```yaml
# .github/workflows/prevent_file_change1.yaml

name: prevent file change 1
on:
  pull_request:
    branches: ["main"]
    paths:
      - .github/**/*.yml
      - .github/**/*.yaml

jobs:
  detect:
    if: ${{ github.event.pull_request.head.repo.fork }} # is Fork
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - name: "Prevent file change"
        run: exit 1
```

```yaml
# .github/workflows/prevent_file_change2.yaml

name: prevent file change 2
on:
  pull_request:
    branches: ["main"]
    paths:
      - .github/**/*.yml
      - .github/**/*.yaml

permissions:
  pull-requests: read # only read required

jobs:
  detect:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - name: Prevent file change for github YAML files.
        uses: xalvarez/prevent-file-change-action@v1
        with:
          githubToken: ${{ secrets.GITHUB_TOKEN }}
          pattern: ^\.github\/.*.y[a]?ml$ # -> .github/**/*.yaml
          trustedAuthors: ${{ github.repository_owner }} # , separated. allow repository owner to change
```

```yaml
# .github/workflows/prevent_file_change3.yaml

name: prevent file change 3
on:
  pull_request:
    branches: ["main"]
    paths:
      - .github/**/*.yml
      - .github/**/*.yaml

jobs:
  detect:
    if: ${{ github.event.pull_request.head.repo.fork }} # is Fork
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 2 # To retrieve the preceding commit.
      - name: Get changed files in the .github folder
        id: changed-files-github
        uses: tj-actions/changed-files@v35
        with:
          files: .github/**/*.{yml,yaml}
      - name: Run step if any file(s) in the .github folder change
        if: ${{ steps.changed-files-github.outputs.any_changed == 'true' }}
        run: |
          echo "One or more files has changed."
          echo "List all the files that have changed: ${{ steps.changed-files-github.outputs.all_changed_files }}"
          exit 1
```

```yaml
# .github/workflows/prevent_file_change4.yaml

name: prevent file change 4
on:
  pull_request:
    branches: ["main"]
    paths:
      - .github/**/*.yml
      - .github/**/*.yaml

jobs:
  detect:
    if: ${{ github.event.pull_request.head.repo.fork }} # is Fork
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - name: Get changed files in the .github folder
        uses: dorny/paths-filter@v2
        id: changes
        with:
          filters: |
            src:
              - .github/**/*.yml
              - .github/**/*.yaml
      - name: Run step if any file(s) in the .github folder change
        if: ${{ steps.changes.outputs.src == 'true' }}
        run: |
          echo "One or more files has changed."
          echo "List all the files that have changed: ${{ steps.changes.outputs.changes }}"
          exit 1
```

## Lint GitHub Actions workflow itself

You can lint GitHub Actions yaml via actionlint. If you don't need automated PR review, run actionlint is enough.

```yaml
# .github/workflows/actionlint.yaml

name: actionlint
on:
  workflow_dispatch:
  pull_request:
    branches: ["main"]
    paths:
      - ".github/workflows/**"
  schedule:
    - cron: "0 0 * * *"

jobs:
  actionlint:
    runs-on: ubuntu-latest
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@v4
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
      - uses: actions/checkout@v4
      - name: actionlint
        uses: reviewdog/action-actionlint@v1
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          reporter: github-pr-review
          fail_on_error: true # workflow will fail when actionlint detect warning.
```


## PR info from Merge Commit

You have two choice.

1. Use Git cli. Retrieve 1st and 3rd line of merge commit.
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
      - uses: actions/checkout@v4
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


## Telemetry for GitHub Workflow execution

GitHub Actions [runforesight/workflow-telemetry-action](https://github.com/runforesight/workflow-telemetry-action) offers workflow telemetry. Telemetry indicate which step consume much Execution Time, CPU, Memory and Network I/O. Default settings post telemetry result to PR comment and JOB Summary.


To enable telemetry, set `runforesight/workflow-telemetry-action@v1` on the first step of your job, then action collect telemetry for later steps.

```yaml
# .github/workflows/workflow_telemetry.yaml

```

Here's telemetry posted to [PR comment](https://github.com/guitarrapc/githubactions-lab/pull/109).

![image](https://github.com/guitarrapc/githubactions-lab/assets/3856350/c1194994-a3ef-4ccb-a4d4-9a0e1bf287fd)

You can find same telemetry result on [Job Summary](https://github.com/guitarrapc/githubactions-lab/actions/runs/6266182534), either.

# Cheat Sheet

GitHub Actions cheet sheet.

## Actions naming

Follow to `setup-foo` style.
Use Hyphen `-` instead of Underscore `_`.

- ✔️: `setup-foo`
- ❌: `setup_foo`

action folder naming also follow this rule.

- ✔️: `.github/actions/setup-foo`
- ❌: `.github/actions/setup_foo`

## Get Branch

`github.ref` context will return branch name, however it is unsafe to directly reference in ref. It is recommended to use through env.

- pull_request: `${{ github.event.pull_request.head.ref }}`
- push and others: `${{ github.ref }}`

```yaml
# .github/workflows/_reusable_dump_context.yaml#L25-L28

- name: update current git to latest
  run: git pull origin ${{ env.CHECKOUT_REF }} --rebase
  env:
    CHECKOUT_REF: ${{ github.event_name == 'pull_request' && github.event.pull_request.head.ref || github.ref_name }}
```

## Get Tag

`echo "${GITHUB_REF##*/}"` will remove `refs/heads` from `refs/heads/xxxxx`, and `refs/tags` `refs/tags/v1.0.0`.

- `refs/heads/xxxxx` -> `xxxxx`
- `refs/tags/v1.0.0` -> `v1.0.0`

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
      - run: echo "GIT_TAG=${GITHUB_REF##*/}" >> "$GITHUB_OUTPUT"
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

Use following Git config to commit as GitHub Actions icon.

```bash
git config user.name github-actions[bot]
git config user.email 41898282+github-actions[bot]@users.noreply.github.com
```

## Type converter with fromJson

There are some cases you want convert string to other type.
Consider you want use boolean input `is-valid` with workflow_dispatch, then pass it to workflow_call as boolean.

`github.event.inputs` context treat all value as `string`, so `github.event.inputs.is-valid` isn't boolean any more.
`fromJson` expression is the trick to convert type from string to boolean.

```yaml
${{ github.event.inputs.foobar == "true" }} # true. type is string
${{ fromJson(github.event.inputs.foobar) == true }} # true. string convert to boolean
```

Other way is use `inputs.foobar` context. `inputs` have type information and pass exactly as is to other workflow calls.

```yaml
${{ inputs.foobar == 'true' }} # false. type is not string
${{ inputs.foobar == true }} # true. type is boolean
```

## Detect PullRequest (PR) is Fork or not

There are several way to achieve it. Most simple and easy to understand is `fork` boolean.

1. Check `fork` boolean.

```
# Fork
if: ${{ github.event.pull_request.head.repo.fork }}

# Not Fork
if: ${{ ! github.event.pull_request.head.repo.fork }}
```

2. Check `full_name` is match to repo.

```
# Fork
if: ${{ github.event.pull_request.head.repo.full_name != 'org/repo' }}

# Not Fork
if: ${{ github.event.pull_request.head.repo.full_name == 'org/repo' }}
```

3. Check label is match to owner. Org member commit label is match to owner.

```
# Fork
if: ${{ ! startsWith(github.event.pull_request.head.label, format('{0}:', github.repository_owner)) }}

# Not Fork
if: ${{ startsWith(github.event.pull_request.head.label, format('{0}:', github.repository_owner)) }}
```
