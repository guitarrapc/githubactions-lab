[![auto doc](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto-doc.yaml/badge.svg)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto-doc.yaml)
[![auto dump context](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto-dump-context.yaml/badge.svg)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto-dump-context.yaml)
[![actionlint](https://github.com/guitarrapc/githubactions-lab/actions/workflows/actionlint.yaml/badge.svg)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/actionlint.yaml)

# githubactions-lab

GitHub Actions research and test laboratory.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# Table of Contents

- [Not yet support](#not-yet-support)
  - [View](#view)
  - [Functionality](#functionality)
- [Plan limitation](#plan-limitation)
  - [GitHub Team Plan, GitHub Pro Plan](#github-team-plan-github-pro-plan)
- [Migrating CI to GitHub Actions](#migrating-ci-to-github-actions)
- [GitHub Actions vs Other CI Platforms](#github-actions-vs-other-ci-platforms)
  - [Core Workflow Features](#core-workflow-features)
  - [Security & Access Control](#security--access-control)
  - [Infrastructure & Performance](#infrastructure--performance)
  - [Development Experience](#development-experience)
- [Basic - Onboarding](#basic---onboarding)
  - [run step](#run-step)
  - [if section](#if-section)
  - [Runner sizing](#runner-sizing)
  - [Timeout](#timeout)
- [Basic - Fundamentables](#basic---fundamentables)
  - [Default shell](#default-shell)
  - [Dump context metadata](#dump-context-metadata)
  - [Environment variables in script](#environment-variables-in-script)
  - [Execution order](#execution-order)
  - [Job output](#job-output)
  - [Redundant Control](#redundant-control)
  - [Run when previous job is success](#run-when-previous-job-is-success)
  - [Run when previous step status is specific](#run-when-previous-step-status-is-specific)
  - [Matrix](#matrix)
  - [Workflow dispatch to invoke manually](#workflow-dispatch-to-invoke-manually)
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
- [Advanced](#advanced)
  - [Automatic Actions version update via Dependabot](#automatic-actions-version-update-via-dependabot)
  - [Build Artifacts](#build-artifacts)
  - [Concurrency Control](#concurrency-control)
  - [Container job](#container-job)
  - [Custom actions](#custom-actions)
  - [Custom actions - JavaScript Actions](#custom-actions---javascript-actions)
  - [Data passing](#data-passing)
  - [Dispatch other repo workflow](#dispatch-other-repo-workflow)
  - [Fork user workflow change prevention](#fork-user-workflow-change-prevention)
  - [git checkout faster](#git-checkout-faster)
  - [GitHub Step Summary](#github-step-summary)
  - [PR info from Merge Commit](#pr-info-from-merge-commit)
  - [Reusable workflow](#reusable-workflow)
  - [Workflow command](#workflow-command)
  - [YAML anchor](#yaml-anchor)
- [Security](#security)
  - [Checkout without persist-credentials](#checkout-without-persist-credentials)
  - [Injection attack via context](#injection-attack-via-context)
  - [Keep update the actions in your workflow](#keep-update-the-actions-in-your-workflow)
  - [Lint GitHub Actions workflow](#lint-github-actions-workflow)
  - [OIDC Connect to access external providers](#oidc-connect-to-access-external-providers)
  - [Permissions](#permissions)
  - [Pin Third-Party Actions to Commit SHA](#pin-third-party-actions-to-commit-sha)
- [Cheat Sheet](#cheat-sheet)
  - [Actions naming](#actions-naming)
  - [Actions runner info](#actions-runner-info)
  - [Detect PullRequest (PR) is Fork or not](#detect-pullrequest-pr-is-fork-or-not)
  - [Debug downloaded remote action](#debug-downloaded-remote-action)
  - [Expression string concat](#expression-string-concat)
  - [Get Branch](#get-branch)
  - [Get Tag](#get-tag)
  - [Get Workflow Name](#get-workflow-name)
  - [Get Workflow Url](#get-workflow-url)
  - [Get Job Url](#get-job-url)
  - [GitHub Actions commit icon](#github-actions-commit-icon)
  - [Path for Downloaded Remote Actions](#path-for-downloaded-remote-actions)
  - [Stale Issue and PR close automation](#stale-issue-and-pr-close-automation)
  - [Telemetry for GitHub Workflow execution](#telemetry-for-github-workflow-execution)
  - [Tool management in GitHub Actions with Aqua](#tool-management-in-github-actions-with-aqua)
  - [Type converter with fromJson](#type-converter-with-fromjson)
  - [Want to get a list of GitHub Actions scheduled workflows](#want-to-get-a-list-of-github-actions-scheduled-workflows)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Not yet support

## View
- [ ] Workflow overview status view
  - There are no view for workflow status overview. Jenkins provides view for Job status which allow user to understand current status in 1 step.
  - Workaround: None.
- [ ] GitHub Actions workflow view grouping
  - Group GitHub Actions workflows.
  - Workaround: None.
- [ ] Test Insight view
  - Like [CircleCI](https://circleci.com/docs/insights-tests) and [Azure Pipeline](https://docs.microsoft.com/en-us/azure/devops/pipelines/test/review-continuous-test-results-after-build?view=azure-devops) provides.
  - Workaround: Use [$GITHUB_STEP_SUMMARY](https://github.blog/2022-05-09-supercharging-github-actions-with-job-summaries/)

## Functionality
- [ ] Workflow level `timeout-minutes`
  - Currently timeout-minutes can set to jobs and steps, but workflow cannot change from default 360min.
  - Workaround: None. Please set `timeout-minutes` to every job.
- [ ] Workflow concurrency control customization
  - Currently concurrency control can be handled with `key` and `cancel-in-progress` options. It will terminate the action when at least 1 pending job exists. However, you cannot customize how many pending actions are allowed or prevent cancellation of pending jobs.
  - Workaround: None.
- [ ] SSH Debug
  - Like [CircleCI provides](https://circleci.com/docs/ssh-access-jobs).
  - Workaround: Use [Debugging with ssh Actions](https://github.com/marketplace/actions/debugging-with-ssh)
- [x] Dynamic Config
  - CircleCI provides [Dynamic Config](https://circleci.com/docs/dynamic-config) with setup workflows, path filtering via [path-filtering orb](https://circleci.com/developer/orbs/orb/circleci/path-filtering), and [continuation orb](https://circleci.com/developer/orbs/orb/circleci/continuation). Enabled by default for projects created after Dec 1, 2023.
  - GitHub Actions offers similar functionality: Reusable Workflow / Composite Actions with inputs parameter, and conditional workflow execution.

---

# Plan limitation

## GitHub Team Plan, GitHub Pro Plan

- [ ] `Environment > Deployment protection rules` is not allowed in GitHub Team/Pro Plan. You cannot use `Required reviewers` (Approvabl) and `Wait timer`. GitHub Enterprise Plan is required to use these features in private repository.

**Private Repository**

Missing `Required reviewers` and `Wait timer` for Environment protection rules.

<details><summary>Click to show screenshot</summary>

![Environment Private Repository](./images/environment-private-repo.png)

</details>

**Public Repository**

Can use `Required reviewers` and `Wait timer` for Environment protection rules.

<details><summary>Click to show screenshot</summary>

![Environment Public Repository](./images/environment-public-repo.png)

</details>

---

# Migrating CI to GitHub Actions

There are several documents for migration.

- CircleCI -> GitHub Actions: [Migrating from CircleCI to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-circleci-to-github-actions)
- Azure pipeline -> GitHub Actions: [Migrating from Azure Pipelines to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-azure-pipelines-to-github-actions)
- GitLab -> GitHub Actions: [Migrating from GitLab CI/CD to GitHub Actions \- GitHub Docs](https://docs.github.com/en/actions/migrating-to-github-actions/migrating-from-gitlab-cicd-to-github-actions)
- Jenkins -> GitHub Actions: [Migrating from Jenkins to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-jenkins-to-github-actions)

Also you may consider migrate from GitHub Actions.

- GitHub Actions -> CircleCI: [Migrating from Github Actions \- CircleCI](https://circleci.com/docs/migrating-from-github)

# GitHub Actions vs Other CI Platforms

A quick comparison table of key features across CI platforms:

| Feature | GitHub Actions | CircleCI | Azure Pipeline | Jenkins |
|---------|---------------|----------|----------------|---------|
| **Core Workflow** |
| YAML-based config | ✔️ | ✔️ | ✔️ | ❌ Groovy |
| Trigger Push & PR | ✔️ | ❌ | ✔️ | ⚠️ Separate |
| Reusable workflows | ✔️ Multiple | ✔️ | ✔️ | ⚠️ Complex |
| Path filter | ✔️ Built-in | ❌ | ✔️ Built-in | ❌ |
| Concurrency control | ✔️ Built-in | ✔️ | ✔️ Stage-level | ❌ |
| Re-run failed jobs | ✔️ | ✔️ | ✔️ Single stage | ✔️ |
| **Security** |
| Fork PR handling | ✔️ Approved | ⚠️ Limited | ✔️ | ❌ |
| Secrets management | ✔️ 3 scopes | ✔️ Context | ✔️ | ✔️ |
| Job approval | ⚠️ Paid plan | ✔️ | ✔️ | ✔️ |
| **Infrastructure** |
| Runner sizing | ✔️ Configurable | ✔️ | ❌ Fixed | N/A |
| Git sparse checkout | ✔️ | ❌ | ❌ | ✔️ |
| Git shallow clone | ✔️ Default | ❌ | ✔️ Default | ✔️ |
| **Development** |
| Step output | ✔️ Dedicated | ⚠️ Env only | ✔️ | ⚠️ Env only |
| Job metadata | ✔️ Context | ✔️ Env vars | ✔️ Env vars | ✔️ Env vars |
| **Build Management** |
| Artifact retention | ✔️ Configurable | ⚠️ Permanent | ⚠️ Permanent | ⚠️ Permanent |
| Skip CI keywords | ✔️ 5 types | ✔️ 2 types | ✔️ 3+ types | ❌ |

**Legend:** ✔️ Full support | ⚠️ Limited/Partial | ❌ Not supported | N/A Not applicable

---

## Core Workflow Features

### Job and workflow

- ✔️ **GitHub Actions**: Jobs defined inside workflow. Triggers both Push and PR.
- ✔️ **CircleCI**: Jobs combined in workflow. Cannot trigger both Push and PR simultaneously.
- ✔️ **Azure Pipeline**: Jobs combined in stages. Triggers both Push and PR.
- ⚠️ **Jenkins**: Uses Declarative Pipeline (Groovy, not YAML). Triggers defined outside pipeline.

<details><summary>Click to show syntax examples</summary>

**GitHub Actions**
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

**CircleCI**
```yaml
version: 2.1

jobs:
  Job_Name:
    docker:
      - image: cimg/<language>:<version TAG>  # Recommended: cimg/* (new convenience images)
      # Legacy: circleci/<language>:<version TAG>
    steps:
      - run: echo foo
workflows:
  commit:
    jobs:
      - Job_Name
```

**Azure Pipeline**
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

**Jenkins**
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

</details>

### Path filter

Filter workflow execution based on changed file paths:

- ✔️ **GitHub Actions**: Built-in support via [`on.<event>.paths`/`paths-ignore`](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#onpushpull_requestpaths)
- ✔️ **CircleCI**: [Path filtering via official orb](https://circleci.com/developer/orbs/orb/circleci/path-filtering) (requires dynamic config)
- ✔️ **Azure Pipeline**: Built-in path filter support
- ❌ **Jenkins**: No built-in support; manual implementation required

### Reusable job and workflow

- ✔️ **GitHub Actions**: Multiple reuse options: `Reusable workflow`, `Composite Actions`, `Organization workflow`, `YAML anchor`
- ✔️ **CircleCI**: Job reuse and `YAML anchor` support
- ✔️ **Azure Pipeline**: Template system for stage/job/step reuse
- ⚠️ **Jenkins**: Pipeline references available but often complex; script-based reuse preferred

### Redundant build cancellation

- ✔️ **GitHub Actions**: Built-in [concurrency control](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency) with `cancel-in-progress`. Alternative: community actions ([workflow-run-cleanup-action](https://github.com/marketplace/actions/workflow-run-cleanup-action), etc.)
- ✔️ **CircleCI**: Built-in redundant build cancellation
- ✔️ **Azure Pipeline**: [Stage-level concurrency](https://learn.microsoft.com/en-us/azure/devops/release-notes/features-timeline) (available since 2024 Q3)
- ❌ **Jenkins**: No built-in support; requires manual implementation

### Rerun failed workflow

- ✔️ **GitHub Actions**: Re-run `whole workflow`, `single job`, or `failed jobs only`
- ✔️ **CircleCI**: Re-run `whole workflow` or `failed jobs only`. Also supports [automatic step reruns](https://circleci.com/docs/configuration-reference/#automatic-step-reruns) with `max_auto_reruns` and configurable delays
- ✔️ **Azure Pipeline**: [Re-run single stage](https://learn.microsoft.com/en-us/azure/devops/release-notes/features-timeline) (available since 2024 Q1), manual stage queuing supported
- ✔️ **Jenkins**: Re-run `Job` or `Stage` (may be unstable)

### Skip CI and commit message

- ✔️ **GitHub Actions**: Skip keywords: `[skip ci]`, `[ci skip]`, `[no ci]`, `[skip actions]`, `[actions skip]`
- ✔️ **CircleCI**: Skip keywords: `[skip ci]`, `[ci skip]`
- ✔️ **Azure Pipeline**: Skip keywords: `***NO_CI***`, `[skip ci]`, `[ci skip]`, [and more](https://github.com/Microsoft/azure-pipelines-agent/issues/858#issuecomment-475768046)
- ❌ **Jenkins**: No built-in support; requires plugins like [SCM Skip](https://plugins.jenkins.io/scmskip/)

### Store Build Artifacts

- ✔️ **GitHub Actions**: [actions/upload-artifact](https://github.com/actions/upload-artifact) / [download-artifact](https://github.com/actions/download-artifact). Configurable retention period.
- ⚠️ **CircleCI**: [`store_artifacts`](https://circleci.com/docs/artifacts/) step. Download requires API call. No retention period.
- ✔️ **Azure Pipeline**: [`PublishPipelineArtifact`](https://learn.microsoft.com/en-us/azure/devops/pipelines/artifacts/pipeline-artifacts?view=azure-devops&tabs=yaml) / `DownloadPipelineArtifact` tasks. No retention period.
- ⚠️ **Jenkins**: [`archiveArtifacts`](https://www.jenkins.io/doc/pipeline/steps/core/#archiveartifacts-archive-the-artifacts) step. Download requires API call. No retention period.

---

## Security & Access Control

### Fork handling

- ✔️ **GitHub Actions**: Supports fork PR triggers with [workflow approval system](https://docs.github.com/en/actions/managing-workflow-runs/approving-workflow-runs-from-public-forks). Offers [practical security patterns](https://securitylab.github.com/research/github-actions-preventing-pwn-requests/) for secret access.
- ⚠️ **CircleCI**: Supports fork PRs but [limited by branch naming rules](https://circleci.com/docs/oss/#build-pull-requests-from-forked-repositories) like `/pull\/[0-9]+/`. No easy way to handle secret access securely.
- ✔️ **Azure Pipeline**: [Supports fork PR triggers](https://learn.microsoft.com/en-us/azure/devops/pipelines/repos/github?view=azure-devops&tabs=yaml#contributions-from-forks) with secret access, but lacks built-in security patterns.
- ❌ **Jenkins**: Not recommended for public CI; fork PR handling not a priority.

### Job Approval

- ⚠️ **GitHub Actions**: Supports approval via Environment protection rules. Limitation: Not available in `GitHub Team` plan for private repos, requires `GitHub Enterprise` plan.
- ✔️ **CircleCI**: Full approval support.
- ✔️ **Azure Pipeline**: Full approval support.
- ✔️ **Jenkins**: Full approval support.

### Set Secrets for Job

- ✔️ **GitHub Actions**: Organization/Repository/Environment Secrets with automatic log masking
- ✔️ **CircleCI**: Environment Variables and Context
- ✔️ **Azure Pipeline**: Environment Variables and Parameters
- ✔️ **Jenkins**: Credential Provider

<details><summary>Click to show GitHub Actions secret details</summary>

GitHub Actions supports three secret scopes:

- **Organization Secrets**: `Organization > Settings > Secrets` (can filter by repository)
- **Repository Secrets**: `Repository > Settings > Secrets`
- **Environment Secrets**: `Repository > Environment > Secrets`

**Priority**: `Environment Secrets` > `Repository Secrets` > `Organization Secrets`

**Personal accounts**: Set secrets per repository or use [google/secrets-sync-action](https://github.com/google/secrets-sync-action).

Secrets are automatically [masked in logs](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#masking-a-value-in-a-log).

</details>

---

## Infrastructure & Performance

### Git Checkout

- ✔️ **GitHub Actions**: [actions/checkout](https://github.com/actions/checkout) supports all features: `ssh/https`, `submodule`, `shallow-clone` (default depth 1), `sparse checkout`, `lfs`.
- ✔️ **CircleCI**: [checkout](https://circleci.com/docs/configuration-reference/#checkout) supports `ssh/https`, `submodule`, `blobless clone` (default since 2024), `lfs`. Missing: `sparse-checkout`. Can select `method: blobless` or `method: full`.
- ✔️ **Azure Pipeline**: [checkout](https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/steps-checkout?view=azure-pipelines) supports `ssh/https`, `submodule`, `shallow-clone` (default depth 1 since Sept 2022), `lfs`. Missing: `sparse-checkout`.
- ✔️ **Jenkins**: [GitSCM](https://www.jenkins.io/doc/pipeline/steps/params/gitscm/) supports all features: `ssh/https`, `submodule`, `shallow-clone`, `sparse checkout`, `lfs`. Default: full clone.

### Hosted Runner sizing

- ✔️ **GitHub Actions**: Offers [Single-CPU runners](https://docs.github.com/en/actions/reference/runners/github-hosted-runners#single-cpu-runners) and [Larger runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-larger-runners/about-larger-runners) with configurable sizing and static IP addresses.
- ✔️ **CircleCI**: Offers [resource classes](https://circleci.com/docs/resource-class-overview/) for different runner sizes.
- ⚠️ **Azure Pipeline**: Fixed size for Microsoft-hosted agents: [Standard_DS2_v2](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/hosted#hardware) (2 vCPU, 7GB RAM, 14GB SSD). For flexible sizing, use [Managed DevOps Pools](https://learn.microsoft.com/en-us/azure/devops/managed-devops-pools/overview) or self-hosted agents.
- ❌ **Jenkins**: Self-hosted solution; hosted runner concept not applicable.

---

## Development Experience

### Meta values and JobId

All CIs provide access to job metadata and unique identifiers:

- ✔️ **GitHub Actions**: [Context](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context) `github.run_id` or [env var](https://help.github.com/en/actions/configuring-and-managing-workflows/using-environment-variables#default-environment-variables) `GITHUB_RUN_ID`
- ✔️ **CircleCI**: [Env vars](https://circleci.com/docs/2.0/env-vars/#built-in-environment-variables) `CIRCLE_BUILD_NUM`, `CIRCLE_WORKFLOW_ID`
- ✔️ **Azure Pipeline**: [Env var](https://docs.microsoft.com/ja-jp/azure/devops/pipelines/process/run-number?view=azure-devops&tabs=yaml#tokens) `BuildID`
- ✔️ **Jenkins**: [Env var](https://wiki.jenkins.io/display/JENKINS/Building+a+software+project) `BUILD_NUMBER`

### Set Environment variables

- ✔️ **GitHub Actions**: Redirect to [`$GITHUB_ENV`](https://help.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-environment-variable): `echo "NAME=value" >> $GITHUB_ENV`
- ✔️ **CircleCI**: Redirect to `$BASH_ENV`: `echo "export NAME=value" >> $BASH_ENV`
- ✔️ **Azure Pipeline**: Use task.setvariable: `echo "##vso[task.setvariable variable=NAME]VALUE"`
- ✔️ **Jenkins**: Use `Env.` object

### Set Output

Pass values between steps and jobs with dedicated output parameters:

- ✔️ **GitHub Actions**: Redirect to [`$GITHUB_OUTPUT`](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#setting-an-output-parameter): `echo "name=value" >> "$GITHUB_OUTPUT"`. Supports job-to-job passing.
- ⚠️ **CircleCI**: No dedicated output; use environment variables
- ✔️ **Azure Pipeline**: Use task.setvariable with `isoutput=true`: `echo "##vso[task.setvariable variable=NAME;isoutput=true]VALUE"`
- ⚠️ **Jenkins**: No dedicated output; use environment variables

### Set PATH Environment variables

- ✔️ **GitHub Actions**: Redirect to `$GITHUB_PATH`: `echo "/path/to/dir" >> "$GITHUB_PATH"`
- ✔️ **CircleCI**: Redirect to `$BASH_ENV`: `echo "export PATH=$GOPATH/bin:$PATH" >> $BASH_ENV`
- ✔️ **Azure Pipeline**: Use task.setvariable: `echo '##vso[task.setvariable variable=path]$(PATH):/dir/to/whatever'`
- ✔️ **Jenkins**: Use `Env.` object

---

# Basic - Onboarding

## run step

You can use `run:` to execute shell command in steps. Here are some tips for `run` statement.

- Add `name:` to describe step name.
- Use `run: |` to write `run` statement in multiline.
- Use `env:` to set environment variables for step.

```yaml
# .github/workflows/run-basic.yaml

name: run basic
on:
  workflow_dispatch:
  push:
    branches: ["main"]

jobs:
  push:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - run: echo "Hello world!"
      - run: |
          echo "foo"
          echo "bar"
      - name: name to run steps
        run: |
          cat << 'EOF' > script.sh
          echo "step 1"
          echo "step 2"
          echo "step 3"
          echo "${FOO}"
          EOF
      - name: execute script
        run: bash ./script.sh
        env:
          FOO: "This is an environment variable"

```

## if section

You can use `if:` condition to control whether `job`/`step` run or not. `if` statement can use [expression](https://docs.github.com/ja/actions/reference/workflows-and-actions/expressions) syntax like `success()`, `failure()`, `contains()`, `startsWith()` and so on.

Following example shows how to use `if` condition for job level and step level.

```yaml
# .github/workflows/if-basic.yaml

name: if basic
on:
  workflow_dispatch:
  push:
    branches: ["main"]

jobs:
  push:
    if: ${{ github.event_name == 'push' || github.event.forced == false }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - run: echo "push"

  workflow_dispatch:
    if: ${{ github.event_name == 'workflow_dispatch' }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - run: echo "workflow_dispatch"

  always:
    if: ${{ always() }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - run: echo "always"
      - run: echo "this is push"
        if: ${{ github.event_name == 'push' }}

```

## Runner sizing

There are 3 types of GitHub hosted runners: Standard runners, Larger runners, and Single-CPU runners.

- Standard runners are default runners for GitHub Actions. It's suitable for most jobs.
- Single-CPU runners are suitable for lightweight jobs that do not require multiple CPUs. It can save minutes cost.
- Larger runners are suitable for resource-intensive jobs that require more CPU and RAM. (It's out of scope of this document.)
- Self-hosted runners are runners that you set up and manage on your own infrastructure. You can customize the hardware and software configuration of self-hosted runners to meet your specific needs. (It's out of scope of this document.)

```yaml
# .github/workflows/runner-sizing.yaml

name: standard runner
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  standard-runner:
    permissions:
      contents: read
    strategy:
      matrix:
        runner: ["ubuntu-24.04", "windows-2025", "macos-26"]
    runs-on: ${{ matrix.runner }}
    timeout-minutes: 3
    steps:
      - run: echo "standard runner is suitable for build. ${{ runner.os }}/${{ runner.arch }}"
        shell: bash

  single-cpu-runner:
    permissions:
      contents: read
    runs-on: ubuntu-slim
    timeout-minutes: 3
    steps:
      - run: echo "single-cpu runner is suitable for lightweight tasks, like linting or GitHub API operation. ${{ runner.os }}/${{ runner.arch }}"

```

<details><summary>Click to show runner sizing example</summary>

### Standard runners

Most GitHub Actions jobs run on GitHub hosted runners. These are virtual machines (VMs) that GitHub manages and maintains for you. Each time a job is triggered, a new VM is created, the job runs on it, and then the VM is destroyed.

You can select `ubuntu-latest`, `windows-latest`, `macos-latest` or specific version like `ubuntu-24.04`, `windows-2025`, `macos-26` as runner type. [Runner specification](https://docs.github.com/en/actions/reference/runners/github-hosted-runners#supported-runners-and-hardware-resources) is different by OS type and Public/Private repository.

Also you can specify architecture like `x64` and `arm64`, see list on [docs](https://docs.github.com/en/actions/reference/runners/github-hosted-runners). For example...

- Linux x86_64 is `ubuntu-24.04`
- Linux ARM64 is `ubuntu-24.04-arm` (available for Public repository only)
- Windows x86_64 is `windows-2025`
- Windows ARM64 is `windows-11-arm` (available for Public repository only)
- macOS x86_64 is `macos-15-intel`
- macOS ARM64 is `macos-26`.

### Single-CPU runners

You can use [Single-CPU runners](https://docs.github.com/en/actions/reference/runners/github-hosted-runners#single-cpu-runners) to save minutes cost for jobs that do not require multiple CPUs. Single-CPU runners are available on `ubuntu-slim` and it's timeout is 15 minutes. `ubuntu-slim` runner is not a VM but a container-based runner with 1 vCPU and 5 GB RAM. It is suitable for lightweight jobs such as documentation generation, code linting, and static analysis.

### Larger runners

For organization users, [Larger runners](https://docs.github.com/en/actions/how-tos/manage-runners/larger-runners) are available for resource-intensive jobs that allowing you to run build and test jobs that require higher performance. You can select Ubuntu, Windows for x86_64 and ARM architecture.

You can configure larger runner registration in `Organization > Settings > Actions > Runners > Larger runners` page.

![](./images/settings-runners.png)

Following screenshot shows default larger runner types and their specifications.

![](./images/larger-hosted-runners-list.png)

If you want other specifications, you can create custom larger runner type. Following screenshot shows ubuntu arm64 larger runner creation example.

![](./images/larger-hosted-runners-spec.png)

You can use larger runners in workflow by specifying `runs-on:` with larger name you specified.

</details>

## Timeout

You can set [job timeout](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idtimeout-minutes) with `jobs.<job_id>.timeout-minutes`, and [step timeout](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idstepstimeout-minutes) with `steps.timeout-minutes`. The default timeout is 360 minutes (6 hours). You can set a value from 1 to 4320 minutes (30 days). I recommend setting a reasonable timeout for every job to avoid wasting build time.

Following example shows how to set timeout for job and step.

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
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5 # timeout for job
    steps:
      - run: echo "done before timeout"
        timeout-minutes: 1 # timeout for step

```

# Basic - Fundamentables

## Default shell

You can select the shell type for a `run` step with `shell:`. You can also set the default shell type for `run` steps with `defaults.run.shell:`.

There are several shell types available in [default](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#defaultsrunshell). Following example shows how to set `bash`, `pwsh` and `cmd`.

**Personal recommendation:**

Considering the current boom in AI, it's best to use `bash` as the default shell across all operating systems. If you need to use PowerShell on Windows, I recommend using `pwsh` whenever possible to avoid encoding issues.

```yaml
# .github/workflows/default-shell.yaml

name: default shell
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

env:
  BRANCH_NAME: ${{ startsWith(github.event_name, 'pull_request') && github.head_ref || github.ref_name }}

jobs:
  bash:
    strategy:
      matrix:
        runs-on: [ubuntu-24.04, windows-2025]
    permissions:
      contents: read
    runs-on: ${{ matrix.runs-on }}
    timeout-minutes: 3
    defaults:
      run:
        shell: bash
    steps:
      - name: Add ENV and OUTPUT by shell
        id: shell
        run: |
          echo "BRANCH=${{ env.BRANCH_NAME }}" | tee -a "$GITHUB_ENV"
          echo "branch=${{ env.BRANCH_NAME }}" | tee -a "$GITHUB_OUTPUT"
      - name: Show ENV and OUTPUT
        run: |
          echo ${{ env.BRANCH }}
          echo ${{ steps.shell.outputs.branch }}
      - name: Add PATH
        run: echo "$HOME/foo/bar" | tee -a "$GITHUB_PATH"
      - name: Show PATH
        run: echo "$PATH"
      - name: Show PATH overwrite shell to pwsh
        run: echo "${env:PATH}"
        shell: pwsh

  pwsh:
    strategy:
      matrix:
        runs-on: [ubuntu-24.04, windows-2025]
    permissions:
      contents: read
    runs-on: ${{ matrix.runs-on }}
    timeout-minutes: 3
    defaults:
      run:
        shell: pwsh
    steps:
      - name: Add ENV and OUTPUT by shell
        id: shell
        run: |
          echo "BRANCH=${{ env.BRANCH_NAME }}" | Tee-Object -Append -FilePath "${env:GITHUB_ENV}"
          echo "branch=${{ env.BRANCH_NAME }}" | Tee-Object -Append -FilePath "${env:GITHUB_OUTPUT}"
      - name: Show ENV and OUTPUT
        run: |
          echo "${{ env.BRANCH }}"
          echo "${{ steps.shell.outputs.branch }}"
      - name: Add PATH
        run: echo "$HOME/foo/bar" | Tee-Object -Append -FilePath "${env:GITHUB_PATH}"
      - name: Show PATH
        run: echo "${env:PATH}"
      - name: Show PATH overwrite shell to bash
        run: echo "$PATH"
        shell: bash

```

## Dump context metadata

Use Context to retrieve job id, name and other system information.
Note that you cannot refer to the `github` context directly in scripts.

> see: [Context and expression syntax for GitHub Actions \- GitHub Help](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context)

**Accessing Context value**

You can get context value with `${{ CONTEXT_NAME.FIELD }}`, something like `${{ github.repository }}`.

```yaml
# .github/workflows/context-github.yaml

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
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: job
        run: echo "$GITHUB_JOB"
        env:
          GITHUB_JOB: ${{ github.job }}
      - name: ref
        run: echo "$GITHUB_REF"
        env:
          GITHUB_REF: ${{ github.ref }}
      - name: sha
        run: echo ${{ github.sha }}
      - name: repository
        run: echo ${{ github.repository }}
      - name: repository_owner
        run: echo ${{ github.repository_owner }}
      - name: actor
        run: echo "$GITHUB_ACTOR"
        env:
          GITHUB_ACTOR: ${{ github.actor }}
      - name: run_id
        run: echo ${{ github.run_id }}
      - name: workflow
        run: echo "$GITHUB_WORKFLOW"
        env:
          GITHUB_WORKFLOW: ${{ github.workflow }}
      - name: event_name
        run: echo ${{ github.event_name }}
      - name: event.ref
        run: echo "$GITHUB_EVENT_REF"
        env:
          GITHUB_EVENT_REF: ${{ github.event.ref }}
      - name: action
        run: echo "$GITHUB_ACTION"
        env:
          GITHUB_ACTION: ${{ github.action }}

```

**Context as JSON**

Use `toJson(<CONTEXT>)` To show context values in json.

```yaml
# .github/workflows/dump-context.yaml

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
  pull_request_target: # zizmor: ignore[dangerous-triggers]
    branches: ["main"]
    types: [opened, synchronize, reopened, closed]
  schedule:
    - cron: "0 0 * * *"
  workflow_dispatch:

jobs:
  dump:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - name: Dump environment
        run: env
      - name: Dump GITHUB_EVENT_PATH json
        run: cat "$GITHUB_EVENT_PATH"
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

**Environment Variables**

You can obtain GitHub Event Context from Environment Variables `GITHUB_EVENT_PATH`.

## Environment variables in script

[set environment variables for next step](#set-environment-variables-for-next-step) explains how to set environment variables for next step.
This syntax can be write in the script, let's see `.github/scripts/setenv.sh`.

```bash
# .github/scripts/setenv.sh

#!/bin/bash
set -eux

while [ $# -gt 0 ]; do
  case $1 in
    --ref) GITHUB_REF=$2; shift 2; ;;
    *) shift ;;
  esac
done

echo BRANCH_SCRIPT=${GITHUB_REF} | tee -a "$GITHUB_ENV"
echo branch=${GITHUB_REF} | tee -a "$GITHUB_OUTPUT"

```

Call this script from workflow.

```yaml
# .github/workflows/setenv-script.yaml

name: set env with script
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

env:
  BRANCH_NAME: ${{ startsWith(github.event_name, 'pull_request') && github.head_ref || github.ref_name }}

jobs:
  bash:
    strategy:
      matrix:
        runs-on: [ubuntu-24.04, windows-2025]
    permissions:
      contents: read
    runs-on: ${{ matrix.runs-on }}
    timeout-minutes: 3
    defaults:
      run:
        shell: bash
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - name: Add ENV and OUTPUT by Script
        id: script
        run: bash ./.github/scripts/setenv.sh --ref "${{ env.BRANCH_NAME }}"
      - name: Show Script  ENV and OUTPUT
        run: |
          echo ${{ env.BRANCH_SCRIPT }}
          echo ${{ steps.script.outputs.branch }}

  pwsh:
    strategy:
      matrix:
        runs-on: [ubuntu-24.04, windows-2025]
    permissions:
      contents: read
    runs-on: ${{ matrix.runs-on }}
    timeout-minutes: 3
    defaults:
      run:
        shell: pwsh
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - name: Add ENV and OUTPUT by Script
        id: script
        run: ./.github/scripts/setenv.ps1 -Ref "${{ env.BRANCH_NAME }}"
      - name: Show Script ENV and OUTPUT
        run: |
          echo "${{ env.BRANCH_SCRIPT }}"
          echo "${{ steps.script.outputs.branch }}"

```

## Execution order

GitHub Actions workflow execution order is `Workflow` -> `Job` -> `Step`.

- Workflows run in parallel by default, but you can control workflow execution order with the [workflow_call](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#workflow_call) event defined in `on.workflow_call`.
- Jobs run in parallel by default, but you can control job execution order with [needs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idneeds) defined in `jobs.<job_id>.needs`.
- Steps run in sequential order within each job.

### Workflow execution order control with workflow_call

If a workflow has no `on.workflow_call` section, it runs in parallel with other workflows. When you add an `on.workflow_call` section, the workflow can be called from another workflow. As a result, workflows run sequentially in the order: caller workflow -> callee workflow.

See [workflow_call](#reusable-workflow) section for actual sample.

> [!WARNING]
> Concider avoid using the `workflow_run` event to control workflow execution order. As the [official documentation](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#workflow_run) mentions, running untrusted code on the `workflow_run` trigger may lead to security vulnerabilities. These vulnerabilities include cache poisoning and granting unintended access to write privileges or secrets.

### Job execution order control with needs

If a job has no `needs` section, it runs in parallel with other jobs. When you set a `needs` section, the job runs after the previous job(s) defined in the `needs` section. By default, a job with `needs` requires the previous job to succeed.

The following example flow shows that `job2` will run after `job1` succeeds, and `job3` will run after both `job1` and `job2` succeed. This means `job2` & `job3` will never run when `job1` fails, and `job3` will never run when `job2` fails. As a result, jobs run sequentially in the order: `job1` -> `job2` -> `job3`.

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
# .github/workflows/job-needs-basic.yaml

name: job needs basic

on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  workflow_dispatch:

jobs:
  A:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "a"

  B:
    needs: [A]
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "b"

  # Run only if A and B success
  C:
    needs: [A, B]
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "c"

```

### Job needs dependency without success result requirement

The following example flow shows that job `job2` will run after `job1` succeeds, but `job3` uses the `always()` conditional expression. Therefore, `job3` will run regardless of whether `job1` and `job2` succeed or fail. Due to the `needs` section, jobs run sequentially in the order: `job1` -> `job2` -> `job3`.

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
# .github/workflows/job-needs-always.yaml

name: job needs always

on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  workflow_dispatch:

jobs:
  A:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "a"

  B:
    needs: [A]
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "b"

  # always run without A and B result
  C:
    needs: [A, B]
    if: ${{ always() }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "c"

```

### Job needs and skip handling

The following example shows how to handle job skipping with the `needs` section. Job `needs` can be used for skip handling. However, skipping a dependent job causes problems for the next job. The following workflow is expected to run `D` when `C` is invoked. However, skipping `A` and `B` causes `D` to be skipped as well.

```yaml
# .github/workflows/job-needs-skip-handling-bad.yaml

name: job needs skip handling (bad)
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  workflow_dispatch:

jobs:
  A:
    if: ${{ false }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "a"

  B:
    if: ${{ false }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "b"

  C:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "c"

  # D will always skip because A and B is skipped
  D:
    needs: [A, B, C]
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "d"

```

To correct the above example and ensure `D` runs when `C` is invoked, you need to add an `if` condition to `D`. This should also handle the case when there is no conditional invocation: when `A`, `B` and `C` succeed, then `D` must run.

```yaml
# .github/workflows/job-needs-skip-handling-ok.yaml

name: job needs skip handling (ok)
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  workflow_dispatch:
    inputs:
      only-c:
        description: "Run only Job C"
        required: false
        default: false
        type: boolean

jobs:
  A:
    if: ${{ !inputs.only-c }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "a"

  B:
    if: ${{ !inputs.only-c }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "b"

  C:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "c"

  # D will run when "C is success" or "all the jobs are success".
  D:
    needs: [A, B, C]
    if: ${{ inputs.only-c && needs.C.result == 'success' || success() }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "d"

```

## Job output

If you want to pass values between jobs, you can use [job output](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/pass-job-outputs) and [job needs](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idneeds). Use `jobs.<job_id>.outputs` to set job output, and other jobs can refer to it via `needs.<job_id>.outputs.<output_name>`.

If you want to pass values between steps in the same job, you can use [step output](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-commands#setting-an-output-parameter). Use `steps.<step_id>.outputs` to set step output, and other steps can refer to it via `steps.<step_id>.outputs.<output_name>`.

The following example shows how to set job output in the `a` job and refer to it in the `b` job.

```yaml
# .github/workflows/job-outputs.yaml

name: job needs basic

on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  workflow_dispatch:

jobs:
  a:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    outputs:
      result: ${{ steps.a-step.outputs.result }}
    steps:
      - name: run a
        id: a-step
        run: echo "result=a" | tee -a "$GITHUB_OUTPUT"

  b:
    needs: [a]
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "a=${{ needs.a.outputs.result }}"

```

## Redundant Control

> [!WARNING]
> Consider using Workflow Concurrency control instead of redundant control.

Creating a PR emits two events: `push` and `pull_request/synchronize`. This means duplicate builds begin and waste build time.
Redundant builds may cause issues when you are running a Private Repository because there are build time limits. In other words, you don't need to worry about build time consumption when the repo is Public.

### Avoid push on pull_request trigger on same repo

In this example, `push` will trigger only on `main`, the default branch. This means push will not run when the `pull_request` synchronize event is emitted.
This is simple enough for most use cases.

```yaml
# .github/workflows/push-and-pr-avoid-redundant.yaml

name: push and pull_request avoid redundant
on:
  # prevent push run on pull_request
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  my-job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo push and pull_request trigger

```

### redundant build cancel

Cancel duplicate workflow and mark CI failure.

```yaml
# .github/workflows/cancel-redundantbuild.yaml

name: cancel redundant build
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  cancel:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      # no check for main and tag
      - uses: rokroskar/workflow-run-cleanup-action@ee1451b869ba1e381729b3d40489997021f0d562 # v0.3.3
        if: ${{ !startsWith(github.ref, 'refs/tags/') && github.ref != 'refs/heads/main' }}
        env:
          GITHUB_TOKEN: "${{ secrets.GITHUB_TOKEN }}"

```

## Run when previous job is success

To accomplish sequential job execution within a workflow, use `needs:` to specify which job the current job depends on.

This enforces the job to run only when the previous job is **successful**.

```yaml
# .github/workflows/sequential-run.yaml

name: sequential jobs
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  build:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo "$COMMIT_MESSAGES"
        env:
          COMMIT_MESSAGES: ${{ toJson(github.event.commits.*.message) }}

  publish:
    needs: [build]
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo run when only build success

```

## Run when previous step status is specific

> [job-status-check-functions /- Context and expression syntax for GitHub Actions /- GitHub Help](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#job-status-check-functions)

Use `if:` when you want to set a step to run based on a particular status.

```yaml
# .github/workflows/status-step.yaml

name: status step
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo "$COMMIT_MESSAGES"
        env:
          COMMIT_MESSAGES: ${{ toJson(github.event.commits.*.message) }}
      - run: echo "success() runs when none of the previous steps have failed or been canceled"
        if: ${{ success() }}
      - run: echo "always() runs even when cancelled. It runs only when a critical failure prevents the task."
        if: ${{ always() }}
      - run: echo "cancelled() runs when workflow is cancelled."
        if: ${{ cancelled() }}
      - run: echo "failure() runs when any previous step of a job fails."
        if: ${{ failure() }}

```


## Matrix

Matrix is useful when you want to run the same job with different parameters like OS, version, and so on. A matrix is defined with `jobs.<job_id>.strategy.matrix`. The following example shows how to use a matrix.

- To control how job failures are handled, use `fail-fast: false` to continue other matrix jobs when one matrix job fails.
- Matrix runs jobs in parallel by default. However, you can set parallelism with `max-parallel` to limit the number of parallel jobs.
- A matrix can define multiple axes like OS and version. The following example will run 6 jobs in parallel (3 versions x 2 OS).

```yaml
# .github/workflows/matrix.yaml

name: matrix
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  parallel:
    strategy:
      # If set true, then if one matrix job fails, cancel others
      fail-fast: false # default is true.
      matrix:
        version: [10, 12, 14]
        runs-on: [ubuntu-24.04, ubuntu-latest]
    permissions:
      contents: read
    runs-on: ${{ matrix.runs-on }}
    timeout-minutes: 3
    steps:
      - name: Show runner info
        run: |
          echo "runner.os: ${{ runner.os }}"
          echo "matrix.runs-on: ${{ matrix.runs-on }}"
          echo "matrix.version: ${{ matrix.version }}"

  serial:
    strategy:
      # run matrix jobs one by one = serial execution
      max-parallel: 1
      matrix:
        version: [10, 12, 14]
        runs-on: [ubuntu-24.04, ubuntu-latest]
    permissions:
      contents: read
    runs-on: ${{ matrix.runs-on }}
    timeout-minutes: 3
    steps:
      - name: Show runner info
        run: |
          echo "runner.os: ${{ runner.os }}"
          echo "matrix.runs-on: ${{ matrix.runs-on }}"

```

You can expand or adding matrix combinations with `jobs.<job_id>.strategy.matrix.include`. The value of include is a list of objects. See details [link](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/run-job-variations#expanding-or-adding-matrix-configurations).

Let's create following workflow.

```yaml
# .github/workflows/matrix-include.yaml

name: matrix include
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  include:
    permissions:
      contents: read
    strategy:
      matrix:
        fruta: [manzana, pera]
        animal: [gato, perro]
        include:
          - color: verde
          - color: rosa
            animal: gato
          - fruta: manzana
            forma: círculo
          - fruta: plátano
            forma: cuadrado
          - fruta: plátano
            animal: gato
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo "${CONTEXT}"
        env:
          CONTEXT: ${{ toJson(matrix) }}

```

Following matrix will run 6 jobs in total.

```json
// manzana, gato
{
  "fruta": "manzana",
  "animal": "gato",
  "color": "rosa",
  "forma": "círculo"
}
// manzana, perro
{
  "fruta": "manzana",
  "animal": "perro",
  "color": "verde",
  "forma": "círculo"
}
// pera, gato
{
  "fruta": "pera",
  "animal": "gato",
  "color": "rosa"
}
// pera, perro
{
  "fruta": "pera",
  "animal": "perro",
  "color": "verde"
}
// plátano, cuadrado
{
  "fruta": "plátano",
  "forma": "cuadrado"
}
// plátano, gato
{
  "fruta": "plátano",
  "animal": "gato"
}
```

You can exclude specific matrix combinations with `jobs.<job_id>.strategy.matrix.exclude`. See details [link](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/run-job-variations#excluding-matrix-configurations).

Let's create following workflow.

```yaml
# .github/workflows/matrix-exclude.yaml

name: matrix exclude
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  exclude:
    permissions:
      contents: read
    strategy:
      matrix:
        fruta: [manzana, pera]
        animal: [gato, perro]
        exclude:
          - fruta: manzana
            animal: gato
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo "${CONTEXT}"
        env:
          CONTEXT: ${{ toJson(matrix) }}

```

Following matrix will run 3 jobs in total, because `manzana` and `gato` combination is excluded.

```json
// manzana, gato
{
  "fruta": "manzana",
  "animal": "gato"
}
// pera, gato
{
  "fruta": "pera",
  "animal": "gato"
}
// pera, perro
{
  "fruta": "pera",
  "animal": "perro"
}
```

### Secret dereference in matrix

You cannot reference `secret` context inside `strategy.matrix` section, so pass secret key in matrix then dereference secret with `secrets[matrix.SECRET_KEY]`.

Let's set secrets in settings, then run following workflow.

![GitHub Secrets sample](./images/secrets.png)

```yaml
# .github/workflows/matrix-secret.yaml

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
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo "org:${{ matrix.org }} secret:${SECRET}"
        env:
          SECRET: ${{ secrets[matrix.secret] }} # zizmor: ignore[overprovisioned-secrets]
      - run: echo "env:${{ env.fruit }} secret:${SECRET}"
        env:
          SECRET: ${{ secrets[env.fruit] }} # zizmor: ignore[overprovisioned-secrets]

```

### Matrix reference in env

You can refer matrix in job's `env:` section before steps.

```yaml
# .github/workflows/matrix-envvar.yaml

name: matrix envvar
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  echo:
    strategy:
      matrix:
        org: [apples, bananas, carrots]
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    env:
      ORG: ${{ matrix.org }}
      # you can not use expression inside env:. do it on step.
    steps:
      - run: echo "${ORG}"
      - run: echo "${NEW_ORG}"
        env:
          NEW_ORG: new-${{ env.ORG }}

```

## Workflow dispatch to invoke manually

When you want to run workflow manually, use `workflow_dispatch` event trigger.

- Web UI offers `Run workflow` button on Actions tab.
- `gh` CLI can trigger workflow dispatch.
- You can use GitHub API to trigger workflow dispatch.

### Workflow dispatch and passing value

You can specify [action inputs](https://docs.github.com/en/actions/creating-actions/metadata-syntax-for-github-actions#inputs) to pass value when you invoke workflow dispatch.

inputs are defined in `on.workflow_dispatch.inputs` section. Following example shows how to define inputs and refer them in job steps.

- `on.workflow_dispatch.inputs`: Define input parameters to pass when invoking workflow dispatch.
  - input parameters have `description`, `required`, `default` and `type` properties. You can specify `type` as `string`, `boolean`, `choice` and `environment`.
- In job steps, you can refer input values with `${{ inputs.<input_name> }}` syntax.

Input types supported are:

- `string`: default type, Web UI offers text box.
- `number`: numeric value, Web UI offers text box.
- `boolean`: `true` or `false` and Web UI offers checkbox.
- `choice`: enum options and Web UI offers selection box. You need to define `options` property.
- `environment`: enum GitHub Environments and Web UI offers selection box.

```yaml
# .github/workflows/workflowdispatch-inputs.yaml

name: workflowdispatch inputs
on:
  workflow_dispatch:
    inputs:
      branch:
        description: "branch name to clone"
        required: true
        default: "main"
        type: string
      logLevel:
        description: "Log level"
        required: true
        default: "warning"
        type: choice
        options:
          - debug
          - info
          - warning
          - error
      dry-run:
        description: "Enable dry-run mode"
        required: false
        type: boolean
      number:
        description: "An optional number"
        required: false
        default: 0
        type: number
      tags:
        description: "Test scenario tags"
        required: false

jobs:
  printInputs:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    env:
      BRANCH: ${{ inputs.branch }}
      LOGLEVEL: ${{ inputs.logLevel }}
      TAGS: ${{ inputs.tags }}
      DRY_RUN: ${{ inputs.dry-run }}
    steps:
      - name: Show Environment Variables
        run: env
      - run: echo "BRANCH=${{ env.BRANCH }}, LOGLEVEL=${{ env.LOGLEVEL }}, TAGS=${{ env.TAGS }}, DRY_RUN=${{ env.DRY_RUN }}"
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          ref: ${{ inputs.branch }}
          persist-credentials: false
      - name: Show Input value
        run: |
          echo "Log level: ${LOG_LEVEL}"
          echo "Number: ${NUMBER}"
        env:
          LOG_LEVEL: ${{ inputs.logLevel }}
          NUMBER: ${{ inputs.number }}
      - name: INPUT_ is not generated automatcally
        run: |
          echo "INPUT_BRANCH: ${INPUT_BRANCH}"
          echo "TEST_number: ${TEST_numer}"

```

# Basic - Commit, Branch and Tag handling

## Create release

You can create a GitHub Release with the `gh` CLI tool. There are some actions, but I recommend using the `gh` CLI tool directly because release creation is simple enough.

The key commands are `gh release create` and `gh release upload`. I recommend creating a draft release first, then uploading files to the release. Change the draft release to published when everything is ready.

```sh
# create draft release with auto generated notes
gh release create <TAG> --draft --verify-tag --title "Ver.<TAG>" --generate-notes

# upload files to release
gh release upload <TAG> file-1.txt file-2.txt
```

The following example triggers when you push a tag like `v1.0.0`. The workflow creates a draft release with auto-generated notes and uploads files.

```yaml
# .github/workflows/create-release-simple.yaml

name: create release simple
concurrency: ${{ github.workflow }}-${{ github.event.pull_request.number || github.ref }}
on:
  push:
    tags:
      - "v[0-9]+.[0-9]+.[0-9]+*"

jobs:
  create-release:
    permissions:
      contents: write
    runs-on: ubuntu-24.04
    timeout-minutes: 10
    steps:
      - name: Setup tag
        id: tag
        run: echo "value=${{ env.TAG_VALUE }}" | tee -a "$GITHUB_OUTPUT"
        env:
          TAG_VALUE: ${{ github.ref_name }}
      # create dummy files
      - run: echo "hoge" > "hoge.${{ steps.tag.outputs.value }}.txt"
      - run: echo "fuga" > "fuga.${{ steps.tag.outputs.value }}.txt"
      # create draft release
      - name: Create Release
        run: gh release create ${{ steps.tag.outputs.value }} --draft --verify-tag --title "Ver.${{ steps.tag.outputs.value }}" --generate-notes
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GH_REPO: ${{ github.repository }}
      # upload files to release
      - name: Upload file to release
        run: gh release upload ${{ steps.tag.outputs.value }} hoge.${{ steps.tag.outputs.value }}.txt fuga.${{ steps.tag.outputs.value }}.txt
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GH_REPO: ${{ github.repository }}

```

## Detect file changed

You can detect which files were changed with push or pull_request events in GitHub Actions. This is useful when you want to use `path-filter` but require further file handling. The following actions are available and can be used in the same way.

`dorny/paths-filter` is still actively developed. However, its output is quite dynamic and hard to handle with static linters like actionlint.

```yaml
# .github/workflows/file-change-detect-dorny.yaml

name: file change detect dorny
on:
  pull_request:
    branches: ["main"]
  push:
    branches: ["main"]

jobs:
  changed-files:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      # see: https://github.com/dorny/paths-filter/blob/master/README.md
      - id: changed-files
        uses: dorny/paths-filter@de90cc6fb38fc0963ad72b210f1f284cd68cea36 # v3.0.2
        with:
          base: ${{ github.event_name == 'push' && github.ref || '' }}
          list-files: csv # default 'none'. Disables listing of matching files.
          filters: |
            foo:
              - '**'
      - name: Is any change happen on some filters?
        run: echo "${{ steps.changed-files.outputs.changes }}"
      - name: Is change happen on foo filter?
        run: echo "${{ steps.changed-files.outputs.foo }}"
      - name: Changed file list for foo filter
        run: echo "${{ steps.changed-files.outputs.foo_files }}"
      - name: Is foo filter changed files include .github/workflows?
        run: echo "${{ contains(steps.changed-files.outputs.foo_files, '.github/workflows')}}"
      - name: Is foo filter changed files include .github/dummy?
        run: echo "${{ contains(steps.changed-files.outputs.foo_files, '.github/dummy')}}"
      # space separated
      - id: changed-files2
        uses: dorny/paths-filter@de90cc6fb38fc0963ad72b210f1f284cd68cea36 # v3.0.2
        if: ${{ github.event.pull_request.changed_files < 100 }} # when changed files less than 100
        with:
          base: ${{ github.event_name == 'push' && github.ref || '' }}
          list-files: shell
          filters: |
            foo:
              - '**'
      - name: List all changed files
        env:
          CHANGED_FILES: ${{ steps.changed-files2.outputs.foo_files }}
        run: |
          for file in ${CHANGED_FILES}; do
            echo "$file was changed"
          done
      # json separated
      - id: changed-files3
        uses: dorny/paths-filter@de90cc6fb38fc0963ad72b210f1f284cd68cea36 # v3.0.2
        with:
          base: ${{ github.event_name == 'push' && github.ref || '' }}
          list-files: json
          filters: |
            foo:
              - '**'
      - name: Changed file list for foo filter
        run: echo "${{ steps.changed-files3.outputs.foo_files }}"

```

`trilom/file-changes-action` has stopped development, so I have stopped using it.

```yaml
# .github/workflows/file-change-detect-dorny.yaml

name: file change detect dorny
on:
  pull_request:
    branches: ["main"]
  push:
    branches: ["main"]

jobs:
  changed-files:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      # see: https://github.com/dorny/paths-filter/blob/master/README.md
      - id: changed-files
        uses: dorny/paths-filter@de90cc6fb38fc0963ad72b210f1f284cd68cea36 # v3.0.2
        with:
          base: ${{ github.event_name == 'push' && github.ref || '' }}
          list-files: csv # default 'none'. Disables listing of matching files.
          filters: |
            foo:
              - '**'
      - name: Is any change happen on some filters?
        run: echo "${{ steps.changed-files.outputs.changes }}"
      - name: Is change happen on foo filter?
        run: echo "${{ steps.changed-files.outputs.foo }}"
      - name: Changed file list for foo filter
        run: echo "${{ steps.changed-files.outputs.foo_files }}"
      - name: Is foo filter changed files include .github/workflows?
        run: echo "${{ contains(steps.changed-files.outputs.foo_files, '.github/workflows')}}"
      - name: Is foo filter changed files include .github/dummy?
        run: echo "${{ contains(steps.changed-files.outputs.foo_files, '.github/dummy')}}"
      # space separated
      - id: changed-files2
        uses: dorny/paths-filter@de90cc6fb38fc0963ad72b210f1f284cd68cea36 # v3.0.2
        if: ${{ github.event.pull_request.changed_files < 100 }} # when changed files less than 100
        with:
          base: ${{ github.event_name == 'push' && github.ref || '' }}
          list-files: shell
          filters: |
            foo:
              - '**'
      - name: List all changed files
        env:
          CHANGED_FILES: ${{ steps.changed-files2.outputs.foo_files }}
        run: |
          for file in ${CHANGED_FILES}; do
            echo "$file was changed"
          done
      # json separated
      - id: changed-files3
        uses: dorny/paths-filter@de90cc6fb38fc0963ad72b210f1f284cd68cea36 # v3.0.2
        with:
          base: ${{ github.event_name == 'push' && github.ref || '' }}
          list-files: json
          filters: |
            foo:
              - '**'
      - name: Changed file list for foo filter
        run: echo "${{ steps.changed-files3.outputs.foo_files }}"

```

## Schedule job on non-default branch

Scheduled jobs will use the `Last commit on default branch`.

> ref: [Events that trigger workflows /- GitHub Help](https://help.github.com/en/actions/reference/events-that-trigger-workflows#scheduled-events-schedule)

A scheduled workflow must be merged to the default branch to apply workflow changes.

Pass branch info when you want to run checkout on a non-default branch.
Don't forget to prepend `refs/heads/` to your branch.

- Good: refs/heads/some-branch
- Bad: some-branch

```yaml
# .github/workflows/schedule-job.yaml

name: schedule job
on:
  schedule:
    - cron: "0 0 * * *"

jobs:
  job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: Dump GitHub context
        run: echo "$CONTEXT"
        env:
          CONTEXT: ${{ toJson(github) }}
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          ref: refs/heads/some-branch
          persist-credentials: false

```

You can create releases and upload assets through GitHub Actions.
Multiple asset uploads are supported by running `actions/upload-release-asset` for each asset.

```yaml
# .github/workflows/create-release.yaml

name: create release
concurrency: ${{ github.workflow }}-${{ github.event.pull_request.number || github.ref }}
on:
  # auto clean up
  push:
    tags:
      - "[0-9]+.[0-9]+.[0-9]+*"
  # auto clean up
  pull_request:
    branches: ["main"]
  workflow_dispatch:
    inputs:
      tag:
        description: "tag: git tag you want create. (1.0.0)"
        required: true
      delete-release:
        description: "delete-release: delete release after creation. (true/false)"
        required: false
        default: false
        type: boolean

env:
  GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  GH_REPO: ${{ github.repository }}

jobs:
  create-release:
    if: ${{ github.actor != 'dependabot[bot]' }}
    permissions:
      contents: write
    runs-on: ubuntu-24.04
    timeout-minutes: 10
    steps:
      - name: Setup tag
        id: tag
        run: echo "value=${{ env.TAG_VALUE || (github.event_name == 'pull_request' && '0.1.0-test' || env.GITHUB_REF_NAME) }}" | tee -a "$GITHUB_OUTPUT"
        env:
          TAG_VALUE: ${{ inputs.tag }}
          GITHUB_REF_NAME: ${{ github.ref_name }}
      # Create Tag
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      # Use the appropriate tag output from the condition steps
      - name: set git remote
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          git remote set-url origin "https://github-actions:${GITHUB_TOKEN}@github.com/${{ github.repository }}"
          git config user.name  "github-actions[bot]"
          git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
      - name: Create Tag and push if not exists
        env:
          TAG_VALUE: ${{ steps.tag.outputs.value  }}
        run: |
          if ! git ls-remote --tags | grep "$TAG_VALUE"; then
            git tag "$TAG_VALUE"
            git push origin "$TAG_VALUE"
            git ls-remote --tags
          fi
      # set release tag(*.*.*) to version string
      - run: echo "foo" > "foo.${{ steps.tag.outputs.value }}.txt"
      - run: echo "hoge" > "hoge.${{ steps.tag.outputs.value }}.txt"
      - run: echo "fuga" > "fuga.${{ steps.tag.outputs.value }}.txt"
      - run: ls -l
      # Create Releases
      - name: Create Release
        run: gh release create ${{ steps.tag.outputs.value }} --draft --verify-tag --title "Ver.${{ steps.tag.outputs.value }}" --generate-notes
      - name: Upload file to release
        run: gh release upload ${{ steps.tag.outputs.value }} hoge.${{ steps.tag.outputs.value }}.txt fuga.${{ steps.tag.outputs.value }}.txt
      - name: Upload additional file to release
        run: gh release upload ${{ steps.tag.outputs.value }} foo.${{ steps.tag.outputs.value }}.txt
      # Clean up
      - name: Clean up (Wait 60s and delete Release)
        run: |
          if gh release list | grep Draft | grep ${{ steps.tag.outputs.value }}; then
            sleep 60
            gh release delete ${{ steps.tag.outputs.value }} --yes --cleanup-tag
          fi
        if: ${{ failure() || inputs.delete-release || (github.event_name == 'pull_request' || github.event_name == 'push') }}

```

## Trigger branch push only but skip on tag push

If you want to run a job only when pushing to a branch, and not for tag pushes. Just remove `tags` section from `on.push` or set negation pattern `!*`.

```yaml
# .github/workflows/branch-push-only.yaml

name: branch push only
on:
  push:
    branches: ["main"]
    tags:
      - "!*" # not a tag push

jobs:
  aws:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo not run on tag

```

## Trigger commit message

```yaml
# .github/workflows/trigger-ci.yaml

name: trigger ci commit
on:
  push:
    branches: ["main"]

jobs:
  job:
    if: ${{ contains(toJSON(github.event.commits.*.message), '[build]') }}
    runs-on: ubuntu-24.04
    permissions:
      contents: read
    timeout-minutes: 3
    steps:
      - run: echo "$COMMIT_MESSAGES"
        env:
          COMMIT_MESSAGES: ${{ toJson(github.event.commits.*.message) }}

```

## Trigger tag push only but skip on branch push

If you want to run a job only when pushing to a tag, and not for branch pushes.

```yaml
# .github/workflows/tag-push-only.yaml

name: tag push only
on:
  push:
    tags:
      - "**" # only tag

jobs:
  job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
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
# .github/workflows/tag-push-only-pattern.yaml

name: tag push only pattern
on:
  push:
    tags:
      - "[0-9]+.[0-9]+.[0-9]+*" # only tag with pattern match

jobs:
  job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo not run on branch push

```

# Basic - Issue and Pull Request handling

## Detect labels on pull request

The `pull_request` event contains labels and you can use them to filter step execution.
`${{ contains(github.event.pull_request.labels.*.name, 'hoge') }}` will return `true` if the label contains `hoge`.

```yaml
# .github/workflows/pr-label-get.yaml

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
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    env:
      IS_HOGE: "false"
    steps:
      - run: echo "${GITHUB_LABELS}"
        env:
          GITHUB_LABELS: ${{ toJson(github.event.pull_request.labels.*.name) }}
      - if: ${{ env.IS_HOGE == 'true' }}
        run: echo "run!"
        env:
          IS_HOGE: ${{ contains(github.event.pull_request.labels.*.name, 'hoge') }}

```

## Skip ci on pull request title

The default `pull_request` event will trigger when the activity type is `opened`, `synchronize`, or `reopened`.

> [Events that trigger workflows /- GitHub Help](https://help.github.com/en/actions/reference/events-that-trigger-workflows#pull-request-event-pull_request)

```yaml
# .github/workflows/skip-ci-pr-title.yaml

name: skip ci pr title
on:
  pull_request:

jobs:
  skip:
    if: ${{ !(contains(github.event.pull_request.title, '[skip ci]') || contains(github.event.pull_request.title, '[ci skip]')) }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo "$GITHUB_CONTEXT"
        env:
          GITHUB_CONTEXT: ${{ toJson(github) }}
      - run: echo "$TITLE"
        env:
          TITLE: ${{ toJson(github.event.pull_request.title) }}
  build:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    needs: skip
    steps:
      - run: echo run when not skipped

```

## Skip pr from fork repo

By default, the `pull_request` event triggers even from fork repositories. However, fork PRs cannot read `secrets` and may fail PR checks.
To skip jobs from forks but run them on your own PRs or pushes, use `if` conditions.

```yaml
# .github/workflows/skip-pr-from-fork.yaml

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
    if: ${{ (github.event_name == 'push' && github.repository_owner == 'guitarrapc') || startsWith(github.event.pull_request.head.label, 'guitarrapc:') }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo build

```

## Skip job when Draft PR

You can skip jobs and steps if the Pull Request is a draft.
Unfortunately, the GitHub Webhook v3 event does not provide a draft PR type, but `event.pull_request.draft` returns `true` when the PR is a draft.

```yaml
# .github/workflows/skip-draft-pr.yaml

name: skip draft pr
on:
  pull_request: null
  push:
    branches: ["main"]

jobs:
  job:
    if: ${{ ! github.event.pull_request.draft }}
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false

```

You can control behaviour with PR label.

```yaml
# .github/workflows/skip-draft-but-label-pr.yaml

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
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false

```

---

# Advanced

Advanced tips.

## Automatic Actions version update via Dependabot

You can use [Dependabot](https://docs.github.com/en/code-security/dependabot/working-with-dependabot/automating-dependabot-with-github-actions) to update GitHub Actions versions automatically. Dependabot creates pull requests to keep your actions up to date, and you can merge them manually or automatically.

To enable Dependabot for GitHub Actions update, add `.github/dependabot.yml` to your repository.

The following is an example dependabot.yaml file.

- Update GitHub Actions/NuGet weekly, but ignore patch version updates.
- Also set a cooldown period of 14 days, which means Dependabot will not create a new PR for the same dependency within 14 days after the previous update PR was created. This is useful for reducing security risks from transient dependency vulnerabilities.

```yaml
# .github/dependabot.yaml

# ref: https://docs.github.com/en/code-security/dependabot/working-with-dependabot/keeping-your-actions-up-to-date-with-dependabot
version: 2
updates:
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly" # Check for updates to GitHub Actions every week
    cooldown:
      default-days: 14
    ignore:
      # I just want update action when major/minor version is updated. patch updates are too noisy.
      - dependency-name: "*"
        update-types:
          - version-update:semver-patch
  - package-ecosystem: "nuget"
    directory: "/"
    schedule:
      interval: "weekly"
    cooldown:
      default-days: 14
    ignore:
      # I just want update action when major/minor version is updated. patch updates are too noisy.
      - dependency-name: "*"
        update-types:
          - version-update:semver-patch

```

**Customize dependabot.yaml**

There are several [configuration options for the dependabot.yaml file](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file).

**Accessing secrets on dependabot action**

When a Dependabot event triggers a workflow, the only secrets available to the workflow are Dependabot secrets. GitHub Actions secrets are not available.

> ref: https://docs.github.com/en/code-security/dependabot/working-with-dependabot/automating-dependabot-with-github-actions#accessing-secrets

Therefore, I recommend not using secrets for Dependabot-triggered workflows. If you need secrets, add the same secret name to Dependabot secrets.

## Build Artifacts

GitHub Actions [actions/upload-artifact](https://github.com/actions/upload-artifact) and [actions/download-artifact](https://github.com/actions/download-artifact) offer artifact handling between jobs. You can upload and download artifacts to/from GitHub Actions.

**file**

```yaml
# .github/workflows/artifacts-file.yaml

name: artifacts (file)
on:
  workflow_dispatch:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  # single file
  upload-file:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: output
        run: |
          echo "hoge" > ./hoge.txt
      - uses: actions/upload-artifact@330a01c490aca151604b8cf639adc76d48f6c5d4 # v5.0.0
        with:
          name: hoge.txt
          path: ./hoge.txt
          retention-days: 1

  download-file:
    needs: [upload-file]
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/download-artifact@018cc2cf5baa6db3ef3c5f8a56943fffe632ef53 # v6.0.0
        with:
          name: hoge.txt
          path: .
      - name: ls
        run: ls -lR
      - name: cat hoge.txt
        run: cat hoge.txt

```

**directory**

```yaml
# .github/workflows/artifacts-directory.yaml

name: artifacts (directory)
on:
  workflow_dispatch:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  # directory
  upload-directory:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: output
        run: |
          mkdir -p ./directory/bin
          echo "hoge" > ./directory/hoge.txt
          echo "fuga" > ./directory/fuga.txt
          echo "foo" > ./directory/bin/foo.txt
          echo "bar" > ./directory/bin/bar.txt
      - uses: actions/upload-artifact@330a01c490aca151604b8cf639adc76d48f6c5d4 # v5.0.0
        with:
          name: directory
          path: ./directory/
          retention-days: 1

  download-directory:
    needs: [upload-directory]
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/download-artifact@018cc2cf5baa6db3ef3c5f8a56943fffe632ef53 # v6.0.0
        with:
          name: directory
          path: ./directory
      - name: ls
        run: ls -lR
      - name: cat hoge.txt
        run: cat directory/hoge.txt

```

**.tar.gz**

```yaml
# .github/workflows/artifacts-targz.yaml

name: artifacts (tar.gz)
on:
  workflow_dispatch:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  # tar.gz
  upload-targz:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: output
        run: |
          mkdir -p ./output/bin
          echo "hoge" > ./output/hoge.txt
          echo "fuga" > ./output/fuga.txt
          echo "foo" > ./output/bin/foo.txt
          echo "bar" > ./output/bin/bar.txt
          tar -zcvf output.tar.gz ./output/
      - uses: actions/upload-artifact@330a01c490aca151604b8cf639adc76d48f6c5d4 # v5.0.0
        with:
          name: output.tar.gz
          path: ./output.tar.gz
          retention-days: 1

  download-targz:
    needs: [upload-targz]
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      # specify path: . to download tar.gz to current directory
      - uses: actions/download-artifact@018cc2cf5baa6db3ef3c5f8a56943fffe632ef53 # v6.0.0
        with:
          name: output.tar.gz
          path: .
      - name: ls
        run: ls -lR
      - name: expand
        run: tar -zxvf output.tar.gz
      - name: ls
        run: ls -lR
      - name: cat hoge.txt
        run: cat ./output/hoge.txt
      - name: cat foo.txt
        run: cat ./output/bin/foo.txt

```


## Concurrency Control

GitHub Actions has concurrency control to prevent you from running Workflows or Jobs at the same time.
This helps you achieve a serial build pipeline.

### Workflow level concurrency

Workflow concurrency control is useful when you want to prevent workflows from running at the same time. Imagine you have a long-running workflow and you want to run it only once at a time.

You can use build context like `github.head_ref` or others. This means you can control concurrency based on commit, branch, workflow, or any other context.

```yaml
# .github/workflows/concurrency-workflow.yaml

name: "concurrency workflow"
concurrency: ${{ github.workflow }}-${{ github.ref }}
on:
  workflow_dispatch:

jobs:
  long_job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - run: sleep 60s

```

Specifying `cancel-in-progress: true` will cancel parallel build.

```yaml
# .github/workflows/concurrency-workflow-cancel-in-progress.yaml

name: "concurrency workflow cancel in progress"
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
on:
  workflow_dispatch:

jobs:
  long_job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - run: sleep 60s

```

### Job level concurrency

Job concurrency control is useful when you want to prevent jobs from running at the same time. Imagine you have a deployment job and you want to run it only once at a time.

```yaml
# .github/workflows/concurrency-job.yaml

name: "concurrency job"
on:
  push:
    branches:
      - main

jobs:
  job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    concurrency:
      group: concurrency-job
    steps:
      - name: Show current time
        run: date

```

Specifying `cancel-in-progress: true` will cancel parallel build.

```yaml
# .github/workflows/concurrency-job-cancel-in-progress.yaml

name: "concurrency job cancel in progress"
on:
  push:
    branches:
      - main

jobs:
  job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    concurrency:
      group: concurrency-job-cip
      cancel-in-progress: true
    steps:
      - name: Show current time
        run: date

```

## Container job

GitHub Actions has 2 types of container support. One is Job container, another is Service container.

**Job conatiner**

GitHub Actions is running on selected OS runner, such as `ubuntu-latest`, `windows-latest`, or `macos-latest`. However, sometimes you may want to run job on specific container image. GitHub Actions supports running job on container with `jobs.<job_id>.container` option. Following example shows how to run job on `golang:1.25` container, and run Go program.

```yaml
# .github/workflows/container-job.yaml

name: container job
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  container:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 10
    container:
      image: golang:1.25
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - name: Show Go version
        run: go version
      - name: Run Go program
        run: go run main.go
        working-directory: ./src/go

```

**Service container**

Service container is used to run container alongside your job. Typical usecase is database server such as MySQL, PostgreSQL, or Redis. You can define one or more service containers with `jobs.<job_id>.services` option. Following example show how to run Redis service container alongside job container.

```yaml
# .github/workflows/container-service.yaml

name: container service
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  container:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 10
    services:
      redis:
        image: redis:8
        ports:
          - 6379:6379
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - uses: actions/setup-go@4dc6199c7b1a012772edbd06daecab0f50c9053c # v6.1.0
        with:
          go-version: "1.25"
      - name: Show Go version
        run: go version
      - name: Run Go program
        run: go run main.go
        working-directory: ./src/go-db

```

## Custom actions

There are 2 types of custom actions. Composite actions and JavaScript actions. Both are useful to create reusable action logic. If you want to reusse workflow logic, you can also use [Reusable workflows](#reusable-workflow) feature.

- If you just want to run shell commands, then Composite actions is easiest way.
- If you want to write complex logic in Node.js, then JavaScript actions is way to go.

### Composite Actions

[Composite action](https://docs.github.com/en/actions/tutorials/create-actions/create-a-composite-action) is kind of meta action which runs multiple steps in single action. You can write shell script steps in Composite actions. To create Composite actions, follow steps below.

Place your actions yaml under `.github/actions/<ACTION_NAME>/action.yaml`.

```sh
$ mkdir -p .github/actions/composite-actions
$ cd .github/actions/composite-actions
$ touch action.yaml
```

Write your Composite actions in action.yaml.

- `inputs`: Define input parameters to Composite actions. You cannot use `type:` field, all inputs are string type. Even if you specify action inputs, input value will not store as ENV var `INPUT_{INPUTS_ID}` as usual.
- `outputs`: Define output parameters from Composite actions.
- `runs.using: "composite"`: This is key point to define Composite action.

```yaml
# .github/actions/composite-actions/action.yaml

name: "Hello World"
description: |
  Desctiption of your action

# Define input parameters to pass from caller to callee.
inputs:
  foo:
    description: thi is foo input
    required: false
    default: FOO

# Define output parameters to pass from callee to caller.
outputs:
  number:
    description: "an example output number"
    value: ${{ steps.output_example.outputs.number }}

runs:
  using: "composite" # this is key point
  steps:
    - name: THIS IS STEP1
      shell: bash # this is key point
      env:
        FOO_VALUE: ${{ inputs.foo }}
      run: echo "$FOO_VALUE"
    - name: output example
      shell: bash
      id: output_example
      run: echo "number=123" | tee -a "$GITHUB_OUTPUT"

```

To use a Composite action within the same repository, refer action path with `uses: ./PATH/TO/ACTION`. If you have input parameters, set `with:` section. If a Composite action has output parameters, you can get it with `steps.<STEP_ID>.outputs.<OUTPUT_NAME>`.

```yaml
# .github/workflows/composite-actions.yaml

name: composite actions
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      # require checkout to use local action
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      # specify local action path with `uses: ./PATH/TO/ACTION`
      - name: Use Composite action
        id: action
        uses: ./.github/actions/composite-actions
        with:
          foo: BAR
      - name: show output
        run: echo "output number is ${{ steps.action.outputs.number }}"

```

## Custom actions - JavaScript Actions

[JavaScript action](https://docs.github.com/en/actions/tutorials/create-actions/create-a-javascript-action) is custom action written in Node.js. You can write complex logic in JavaScript action. To create JavaScript actions, follow steps below.

> [!Note]
> Most cases, JavaScript actions are written in TypeScript, then  compile into JavaScript, place compiled JavaScript file under `dist/` folder. Following example just use plain JavaScript for simplicity.

Place your actions yaml under `.github/actions/<ACTION_NAME>/action.yaml`, and main JavaScript file `dist/index.js` in same folder.

```sh
$ mkdir -p .github/actions/javascript-actions
$ cd .github/actions/javascript-actions
$ touch action.yaml
$ touch dist/index.js
```

Write your JavaScript actions definition in action.yaml.

- `inputs`: Define input parameters to JavaScript actions.
- `outputs`: Define output parameters from JavaScript actions.
- `runs.using: "node20"`: This is key point to define JavaScript action.

```yaml
# .github/actions/javascript-actions/action.yaml

name: "Hello World"
description: |
  Desctiption of your action

# Define input parameters to pass from caller to callee.
inputs:
  name:
    description: "Name to greet"
    required: false
    default: "World"

# Define output parameters to pass from callee to caller.
outputs:
  greeting:
    description: "The greeting message"

runs:
  using: "node20"
  main: "index.js"

```

Write your logic in `dist/index.js`. Following example shows standard output, input parameter usage, and output parameter setting.

```js
// .github/actions/javascript-actions/index.js

// Standard output
console.log("Hello, World!");

// input example
const name = process.env['INPUT_NAME'];

// output example
const greeting = `Hello, ${name}!`;
console.log(greeting);
console.log(`::set-output name=greeting::${greeting}`);

```

To use a JavaScript action within the same repository, refer action path with `uses: ./PATH/TO/ACTION`. If you have input parameters, set `with:` section. If a JavaScript action has output parameters, you can get it with `steps.<STEP_ID>.outputs.<OUTPUT_NAME>`.

```yaml
# .github/workflows/javascript-actions.yaml

name: javascript actions
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      # specify local action path with `uses: ./PATH/TO/ACTION`
      - name: Use JavaScript action
        id: action
        uses: ./.github/actions/javascript-actions
        with:
          name: John
      - name: show output
        run: echo "greeting is ${{ steps.action.outputs.greeting }}"

```

## Data passing

### Data passing between steps

There are several ways to pass data between steps in the same job.

- step outputs
- environment variables
- files

### Data passing between jobs

There are several ways to pass data between jobs.

- job outputs and needs
- artifacts (files)


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
# .github/workflows/dispatch-changes-actions.yaml

name: dispatch changes actions
on:
  workflow_dispatch:

jobs:
  dispatch:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
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
        uses: benc-uk/workflow-dispatch@e2e5e9a103e331dad343f381a29e654aea3cf8fc # v1.2.4
        with:
          repo: ${{ matrix.repo }}
          ref: ${{ matrix.ref }}
          workflow: ${{ matrix.workflow }}
          token: ${{ secrets.SYNCED_GITHUB_TOKEN_REPO }}

```

## Fork user workflow change prevention

One of GitHub's vulnerable point is Workflow. Editting Workflow shoulbe be requirement when using `secrets` and authenticate some service on workflow.

Easiest and simple way is use `pull_request` target and path filter, then detect PR is fork or not. There might be many ways to prevent file change. `xalvarez/prevent-file-change-action` can guard change in the step. Using `dorny/paths-filter`, or others will be flexible way to detect change and do what you want.

> [!Warning]
> Stop using `tj-actions/changed-files` as of reaction to the [security vulnerbility](https://www.stepsecurity.io/blog/harden-runner-detection-tj-actions-changed-files-action-is-compromised)

```yaml
# .github/workflows/prevent-file-change1.yaml

name: prevent file change 1
on:
  pull_request:
    branches: ["main"]
    paths:
      - .github/**/*.yaml

jobs:
  detect:
    if: ${{ github.event.pull_request.head.repo.fork }} # is Fork
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: "Prevent file change"
        run: exit 1

```

```yaml
# .github/workflows/prevent-file-change2.yaml

name: prevent file change 2

on:
  pull_request_target: # zizmor: ignore[dangerous-triggers]
    branches: ["main"]
    paths:
      - .github/**/*.yaml

jobs:
  detect:
    if: ${{ github.actor != 'dependabot[bot]' }}
    permissions:
      contents: read
      pull-requests: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: Prevent file change for github YAML files.
        uses: xalvarez/prevent-file-change-action@8ba6c9f0f3c6c73caea35ae4b13988047f9cd104 # v3.0.0
        with:
          githubToken: ${{ secrets.GITHUB_TOKEN }}
          pattern: ^\.github\/.*.y[a]?ml$ # -> .github/**/*.yaml
          trustedAuthors: ${{ github.repository_owner }} # , separated. allow repository owner to change

```

```yaml
# .github/workflows/prevent-file-change3.yaml

name: prevent file change 3
on:
  pull_request:
    branches: ["main"]
    paths:
      - .github/**/*.yaml
      - .github/**/*.yml

jobs:
  detect:
    if: ${{ github.event.pull_request.head.repo.fork }} # is Fork
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: Run step if any file(s) in the .github folder change
        run: exit 1

```

```yaml
# .github/workflows/prevent-file-change4.yaml

name: prevent file change 4
on:
  pull_request:
    branches: ["main"]
    paths:
      - .github/**/*.yaml

jobs:
  detect:
    if: ${{ github.event.pull_request.head.repo.fork }} # is Fork
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: Run step if any file(s) in the .github folder change
        run: |
          echo "One or more files has changed."
          exit 1

```

## git checkout faster

[actions/checkout](https://github.com/actions) supports both [shallow-clone](https://git-scm.com/docs/shallow) and [sparse checkout](https://git-scm.com/docs/git-sparse-checkout) which is quite useful for monorepository. Typically, monorepository contains huge number of files and folders, so normal git clone/checkout may take long time and huge disk space. If you want to speed up git checkout, enable both `shallow-clone` and `sparse checkout`.

- `shallow-clone` (Enable by default): Offers faster clone by limiting commit history depth.
- `sparse checkout` (Added 2023/June -): Offers faster checkout by limiting checked out files and folders.

<details><summary>Click to show explanation of shallow clone and sparse checkout</summary>

**What's Shallow clone**

Shallow clones use the `--depth=<N>` parameter in `git clone` to truncate the commit history. Typically, --depth=1 signifies that we only care about the most recent commits. This drastically reduces the amount of data that needs to be fetched, leading to faster clones and less storage of shallow history.

![Shallow clone](./images/shallow-clone.png)

> ref: https://github.blog/2020-12-21-get-up-to-speed-with-partial-clone-and-shallow-clone/

**What's Sparse checkout**

Sparse checkout use the `git sparse-checkout set <PATH>` before `git clone` to truncate the checkout files and folders. This amazingly reduces the amount of data that needs to be fetched, leading to faster checkout and less storage of limited paths.

![Sparse checkout](./images/sparse-checkout.png)

> ref: https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/

Sparce checkout has 2 modes, `git sparse-checkout` and `git sparse-checkout --cone`. You can specify `cone` or not with `sparse-checkout-cone-mode` option. So what the difference between `cone` and not `cone`? Normally `sparse-checkout-cone-mode: true` is faster than `sparse-checkout-cone-mode: false`. But `cone` mode has some limitation, you cannot exclude specific folder. So you need to choose which mode is better for you.

- `sparse checkout: src` & `sparse-checkout-cone-mode: true`, checkout `src` folder and root files.
- `sparse checkout: src/*` & `sparse-checkout-cone-mode: false`, checkout `src` folder only.
- `sparse checkout: !src` & `sparse-checkout-cone-mode: true`, you can not use `sparse-checkout-cone-mode: true` with exclude folder.
- `sparse checkout: !src/*` & `sparse-checkout-cone-mode: false`, you can exlude `src` folder from checkout, but you need specify which folder you want to checkout.

</details>

### Sparse checkout

To use sparse checkout, just specify `sparse-checkout` option to `actions/checkout` action. Following example checkout only `src/` folder and root files.

```yaml
# .github/workflows/git-sparse-checkout.yaml

name: git sparse checkout
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  sparse-checkout:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          sparse-checkout: |
            src
          persist-credentials: false
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

### Sparse checkout and specify which file to checkout

To use sparse checkout and specify which file/folder to checkout, just specify `sparse-checkout` option to `actions/checkout` action. Following example checkout only `src/*` folder. Disable cone mode by `sparse-checkout-cone-mode: false` to use `!` exclude pattern.

```yaml
# .github/workflows/git-sparse-checkout-disable-cone.yaml

name: git sparse checkout (disable cone)
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  sparse-checkout:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          sparse-checkout: |
            src/*
          sparse-checkout-cone-mode: false # required for ! entry to work
          persist-credentials: false
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

### Sparse checkout exclude path

To use sparse checkout and exclude specific file/folder from checkout, just specify `sparse-checkout` option to `actions/checkout` action. Following example exclude `src/*` folder. Disable cone mode by `sparse-checkout-cone-mode: false` to use `!` exclude pattern.

```yaml
# .github/workflows/git-sparse-checkout-exclude.yaml

name: git sparse checkout exclude
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  sparse-checkout:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          sparse-checkout: |
            !src/*
            /*
          sparse-checkout-cone-mode: false # required for ! entry to work
          persist-credentials: false
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


## GitHub Step Summary

If you want to add a job summary, use [GITHUB_STEP_SUMMARY](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#adding-a-job-summary). Job summaries are useful for displaying important information after a job finishes. You can see the Job Summary at the bottom of the job page.

```yaml
# .github/workflows/github-step-summary.yaml

name: GitHub Step Summary
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  # Summary is consolidated per job
  script:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - name: add summary
        uses: actions/github-script@ed597411d8f924073f98dfc5c65a23a2325f34cd # v8.0.0
        with:
          script: |
            await core.summary.addHeading("Hello world! 🚀").write()
            await core.summary.addTable([
              ["Key", "Value"],
              ["GITHUB_REF", process.env.GITHUB_REF],
              ["github.event_name", '${{ github.event_name }}'],
              ["github.head_ref", process.env.HEAD_REF],
              ["github.ref_name", process.env.REF_NAME],
            ]).write()
        env:
          HEAD_REF: ${{ github.head_ref }}
          REF_NAME: ${{ github.ref_name }}

  # To split summary, use different job
  bash:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - name: add summary
        run: |
          {
            echo "### Parameters"
            echo ""
            echo "| Key | Value |"
            echo "| --- | --- |"
            echo "| GITHUB_REF | ${GITHUB_REF} |"
            echo "| github.event_name | ${{ github.event_name }} |"
            echo "| github.head_ref | ${HEAD_REF} |"
            echo "| github.ref_name | ${REF_NAME} |"
          } | tee -a "$GITHUB_STEP_SUMMARY"
        env:
          HEAD_REF: ${{ github.head_ref }}
          REF_NAME: ${{ github.ref_name }}

```

## PR info from Merge Commit

You have two choices:

1. Use Git CLI to retrieve the 1st and 3rd lines of the merge commit.
2. Use an action to retrieve PR info from the merge commit.

Below use [jwalton/gh-find-current-pr](https://github.com/jwalton/gh-find-current-pr) to retrieve PR info from merge commit.

```yaml
# .github/workflows/pr-from-merge-commit.yaml

name: pr from merge commit
on:
  push:
    branches: ["main"]

jobs:
  get:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - uses: jwalton/gh-find-current-pr@89ee5799558265a1e0e31fab792ebb4ee91c016b # v1.3.3
        id: pr
        with:
          state: closed
      - if: ${{ success() && steps.pr.outputs.number }}
        run: |
          echo "PR #${PR_NUMBER}"
          echo "PR Title: ${PR_TITLE}"
        env:
          PR_NUMBER: ${{ steps.pr.outputs.number }}
          PR_TITLE: ${{ steps.pr.outputs.title }}

```

## Reusable workflow

GitHub Actions allows you to create [Reusable workflows](https://docs.github.com/en/actions/how-tos/reuse-automations/reuse-workflows) to share common workflow logic across multiple workflows and repositories. You can call a local workflow from the same repository, a public repository's workflow, or a private repository's workflow from the same Organization. To create a reusable workflow, follow the steps below.

### Limitations

There are some limitations when calling reusable workflows:

1. A private repo can call the same repo's reusable workflow, but cannot call other private repos' workflows.
2. Caller cannot use ${{ env.FOO }} for `with` inputs.

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

3. The callee workflow must be placed under `.github/workflows/`. Otherwise, the caller is treated as calling a public workflow.

   ```bash
   $ ls -l ./.github/workflows/
   ```

4. Callee cannot refer Caller's Environment Variable.

   ```yaml
   env:
     FOO: foo # Reusable workflow callee cannot refer this env.
   jobs:
     bad:
       runs-on: ubuntu-latest
       steps:
         uses: ./.github/workflows/dummy.yaml
   ```

### Reusable workflow basic

Place Reusable workflow yaml file under `.github/workflows/<WORKFLOW_NAME>.yaml`.

```sh
$ mkdir -p .github/workflows
$ cd .github/workflows
$ touch _reusable-workflow-called.yaml
```

Write your Reusable workflow in `_reusable-workflow-called.yaml`. You can pass value by `inputs` and get value by `outputs`.

- `on.workflow_call`: Key point to define Reusable workflow.
- `on.workflow_call.inputs`: Define input parameters to pass from caller to callee.
  - You can specify `type` of input parameter. Supported types are `string`, `boolean`, `number`.
- `on.workflow_call.secrets`: Define input secret parameters to pass from caller to callee.
- `on.workflow_call.outputs`: Define output parameters to pass from callee to caller.

```yaml
# .github/workflows/_reusable-workflow-called.yaml

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
      number:
        required: false
        description: an optional number
        type: number
        default: 0
    secrets:
      APPLES:
        required: true
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
    timeout-minutes: 5
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    outputs:
      output1: ${{ steps.step1.outputs.firstword }}
      output2: ${{ steps.step2.outputs.secondword }}
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          ref: ${{ github.event_name == 'pull_request' && github.event.pull_request.head.ref || '' }} # checkout PR HEAD commit instead of merge commit
          persist-credentials: false
      - name: (Limitation) Callee can not refer caller environment variable.
        run: echo "caller environment. ${CALLER_VALUE}"
      - name: called username
        run: echo "called username. $USERNAME"
        env:
          USERNAME: ${{ inputs.username }}
      - name: called is-valid
        run: echo "called is-valid. $IS_VALID_INPUT"
        env:
          IS_VALID_INPUT: ${{ inputs.is-valid }}
      - name: called number
        run: echo "called number. $NUMBER_INPUT"
        env:
          NUMBER_INPUT: ${{ inputs.number }}
      - name: called secret
        run: echo "called secret. ${{ secrets.APPLES }}"
      - name: called env (global)
        run: echo "called global env. ${{ env.FOO }}"
      - name: output step1
        id: step1
        run: echo "firstword=hello" >> "$GITHUB_OUTPUT"
      - name: output step2
        id: step2
        run: echo "secondword=world" >> "$GITHUB_OUTPUT"

```

### Call Reusable workflow in same repository

To call Reusable workflow in same repository, use `uses: ./.github/workflows/xxxx.yaml`.

> [!TIP]
> If you want pass `boolean` type of input from workflow_dispatch to workflow_call, use `fromJson(inputs.YOUR_BOOLEAN_PARAMETER)`.
See [Type converter with fromJson](#type-converter-with-fromJson) for the detail.

```yaml
# .github/workflows/reusable-workflow-caller-internal.yaml

name: reusable workflow caller (internal)
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  workflow_dispatch:


# (Limitation) Callee can not refer caller environment variable.
env:
  CALLER_VALUE: caller

jobs:
  call-workflow-passing-data:
    permissions:
      contents: read
    uses: ./.github/workflows/_reusable-workflow-called.yaml
    with:
      username: "foo"
      is-valid: true
    secrets:
      APPLES: ${{ secrets.APPLES }}

  job2:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    needs: call-workflow-passing-data
    steps:
      - run: echo ${{ needs.call-workflow-passing-data.outputs.firstword }} ${{ needs.call-workflow-passing-data.outputs.secondword }}

```

### Call Reusable workflow in public repository

To call Reusable workflow in public repository, use `uses: GITHUB_OWNER/REPOSITORY/.github/workflows/xxxx.yaml@<ref>`.

```yaml
# .github/workflows/reusable-workflow-public-caller.yaml

name: reusable workflow caller (public)
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  workflow_dispatch:

jobs:
  call-workflow-passing-data:
    permissions:
      contents: read
    uses: guitarrapc/githubactions-lab/.github/workflows/_reusable-workflow-called.yaml@main
    with:
      username: foo
      is-valid: true
    secrets:
      APPLES: ${{ secrets.APPLES }}

  job2:
    needs: [call-workflow-passing-data]
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 1
    steps:
      - run: echo "${{ needs.call-workflow-passing-data.outputs.firstword }} ${{ needs.call-workflow-passing-data.outputs.secondword }}"

```

### Nested reusable workflow

Reusalbe workflow support nested call. Callee workflow can call another reusable workflow.

```yaml
# .github/workflows/_reusable-workflow-nest.yaml

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
    permissions:
      contents: read
    uses: ./.github/workflows/_reusable-workflow-called.yaml
    with:
      username: ${{ inputs.username }}
      is-valid: ${{ inputs.is-valid }}
    secrets:
      APPLES: ${{ secrets.APPLES }}

```

## Workflow command

GitHub Actions support [Workflow commands](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-commands) to interact with workflow runner. You can use workflow commands to set output parameters, add debug messages to the output logs, and other tasks.

Most workflow commands use the echo command in a specific format, while others are invoked by writing to a file.

```sh
echo "::workflow-command parameter1={data},parameter2={data}::{command value}"
```

If you are using JavaScript or TypeScript to create GitHub Actions, you can use the [@actions/core](https://github.com/actions/toolkit).

```js
core.error('Missing semicolon', {file: 'app.js', startLine: 1})
```

```yaml
# .github/workflows/workflow-command.yaml

name: workflow commands
# https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  commands:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo "action_fruit=strawberry" >> "$GITHUB_OUTPUT"
      - run: echo "::debug::Set the Octocat variable"
      - run: echo "::warning file=app.js,line=1,col=5::Missing semicolon"
      - run: echo "::error file=app.js,line=10,col=15::Something went wrong"
      - run: |
          echo "::group::My title"
            echo "Inside group"
          echo "::endgroup::"

          echo "::group::My next title"
            echo "Inside group"
          echo "::endgroup::"
      - run: |
          MY_NAME="Mona The Octocat"
          echo "::add-mask::$MY_NAME"

```

## YAML anchor

> [!WARNING]
> I don't recommend using complex anchor structure, because it may make yaml hard to read. Instead, use Reusable Workflow, Composite Actions, JavaScript Actions to share common logic.

You can use [YAML anchor](https://docs.github.com/ja/actions/reference/workflows-and-actions/reusing-workflow-configurations#yaml-anchors-and-aliases) to reduce duplication in GitHub Actions workflow yaml. Define anchor with `&anchor_name` and refer anchor with `*anchor_name`. Be aware that YAML Merge Keys `<<: *anchor_name` is not supported, yet.

```yaml
# .github/workflows/yaml-anchor-basic.yaml

name: yaml anchor basic
on:
  push:
    branches: ["main"]
    # Define an anchor named common_paths with `&NAME`
    paths: &common_paths
      - ".github/workflows/**.yaml"
      - "README.md"
  pull_request:
    branches: ["main"]
    # Reference the anchor with `*NAME`
    paths: *common_paths

jobs:
  job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: Show message
        run: echo "This workflow is triggered by changes in paths defined with YAML anchor."

```

To debug anchor, use `yq` command to see expanded yaml.

```sh
$ yq "explode(.)" .github/workflows/yaml-anchor-basic.yaml
name: yaml anchor basic
on:
  push:
    branches: ["main"]
    # Define an anchor named common_paths with `&NAME`
    paths:
      - ".github/workflows/**.yaml"
      - "README.md"
  pull_request:
    branches: ["main"]
    # Reference the anchor with `*NAME`
    paths:
      - ".github/workflows/**.yaml"
      - "README.md"
jobs:
  job:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: Show message
        run: echo "This workflow is triggered by changes in paths defined with YAML anchor."
```

---

# Security

## Checkout without persist-credentials

When you use `actions/checkout`, by default it keep git remote url with token authentication after checkout. This should be not needed for normal case, and it may cause security issue. So that you should set `persist-credentials: false` to disable it.

```yaml
# .github/workflows/checkout-without-persistcredentials.yaml

name: checkout without persist-credentials
on:
  pull_request:
    branches: ["main"]

jobs:
  checkout:
    permissions:
      contents: write
    runs-on: ubuntu-24.04
    timeout-minutes: 10
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          # default is true. Set to false to avoid persisting the token in git config.
          persist-credentials: false

      - name: tag setup
        run: git tag test-auth-checkout

      - name: verify credentials are not persisted
        run: |
          if ! git push origin test-auth-checkout; then
            echo "✔️ push tag failed as expected due to missing credentials"
          else
            echo "❌ push tag succeeded unexpectedly, credentials were persisted"
            git push --delete origin test-auth-checkout
            exit 1
          fi

      # If you need to do git operations, you need to set git remote again
      - name: set git remote
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          git remote set-url origin "https://github-actions:${GITHUB_TOKEN}@github.com/${{ github.repository }}"
          git config user.name  "github-actions[bot]"
          git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

      - name: Push and delete test tag to confirm auth
        run: |
          git push origin test-auth-checkout
          git push --delete origin test-auth-checkout
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      # Delete git config to avoid affecting other steps
      - name: Remove git config
        if: always()
        run: |
          git remote rm origin
          git config --unset user.email
          git config --unset user.name
```

## Injection attack via context

GitHub Actions context may be vulnerable to injection attacks if untrusted data is used. For example, if you use `${{ github.event.head_commit.message }}` directly in a shell command, an attacker could craft a commit message that includes shell commands, leading to arbitrary code execution.

To mitigate this risk, avoid directly embedding untrusted data into shell commands or scripts. Instead, [use an intermediate environment variable](https://docs.github.com/en/actions/reference/security/secure-use#use-an-action-instead-of-an-inline-script).

You can detect potential injection attacks via context with [ghalint](https://github.com/suzuki-shunsuke/ghalint), [zizmor](https://github.com/woodruffw/zizmor), and others. See detail in [Lint GitHub Actions workflow](#lint-github-actions-workflow).

```yaml
# .github/workflows/injection-attack-via-context.yaml

name: injection attack via context
on:
  workflow_dispatch:
    inputs:
      dummy:
        description: "A dummy input to trigger the workflow"
        required: false
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  sample:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: Avoid injection attack via PR title
        run: echo "PR_TITLE=${PR_TITLE}"
        env:
          PR_TITLE: ${{ github.event.pull_request.title }}
      - name: Avoid injection attack via branch name
        run: echo "BRANCH_NAME=${BRANCH_NAME}"
        env:
          BRANCH_NAME: ${{ github.ref_name }}
      - name: Avoid injection attack via commit message
        run: echo "COMMIT_MESSAGE=${COMMIT_MESSAGE}"
        env:
          COMMIT_MESSAGE: ${{ github.event.head_commit.message }}
      - name: Avoid injection attack via workflow input
        run: echo "DUMMY_INPUT=${DUMMY_INPUT}"
        env:
          DUMMY_INPUT: ${{ inputs.dummy }}

```

## Keep update the actions in your workflow

[Dependabot](https://docs.github.com/en/actions/reference/security/secure-use#using-dependabot-version-updates-to-keep-actions-up-to-date), or Renovate, can automatically check for updates to the GitHub Actions used in your workflows. To enable Dependabot for GitHub Actions, create a `.github/dependabot.yaml` file.

Here's some tips for configuring Dependabot for GitHub Actions.

- Use cooldown period like `cooldown.default-days: 14` to avoid updating right after a new version is released. This gives time to monitor for any issues with the new version.
- Use `ignore.dependency-name[].update-types` to control which types of updates to apply (e.g., `version-update:semver-patch` if you want to avoid patch version updates).

## Lint GitHub Actions workflow

You can lint GitHub Actions yaml via [actionlint](https://github.com/rhysd/actionlint), [ghalint](https://github.com/suzuki-shunsuke/ghalint) and [zizmor](https://github.com/woodruffw/zizmor). If you don't need automated PR review, run any of these linter on schedule may be fine.

Linter will check follows.

* actionlint: Check syntax and structure of GitHub Actions workflow yaml.
* ghalint: Check actions/checkout should set `persist-credentials: false`, Reusable workflow's `secrets: inherit`.
* zizmor: Check GitHub Action's security vulnerability.

> TIPS: See [Tool management in GitHub Actions with Aqua](#tool-management-in-github-actions-with-aqua) for Aqua usage.

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
  lint:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - uses: aquaproj/aqua-installer@9ebf656952a20c45a5d66606f083ff34f58b8ce0 # v4.0.0
        with:
          aqua_version: v2.43.1
      # github workflows/action's Static Checker
      - name: Run actionlint
        run: actionlint -color -oneline
      # checkout's persist-credentials: false checker
      - name: Run ghalint
        run: ghalint run
      # A static analysis tool for GitHub Actions
      - name: Run zizmor
        run: docker run -t -v .:/github ghcr.io/woodruffw/zizmor:1.5.2 /github --min-severity medium

```

## OIDC Connect to access external providers

Since 2024 and later, many cloud providers and Programing language's package registries support OIDC (OpenID Connect) to authenticate GitHub Actions workflows. OIDC allows your workflow to securely access external resources without needing to store long-lived credentials like API keys or tokens in your repository secrets.

To use OIDC in your GitHub Actions workflow, `permissions` must include `id-token: write`. Each resistry or cloud provider may have different actions to request OIDC token and different `audience` value. Please refer to the documentation of the respective provider for details. GitHub also provides [OIDC documentation](https://docs.github.com/en/actions/concepts/security/openid-connect) for more information.

Following is an example of using OIDC to access AWS resources.

```yaml
# .github/workflows/aws-oidc-credential.yaml

name: aws oidc credential
on:
  workflow_dispatch:
  push:
    branches: ["main"]

jobs:
  aws:
    strategy:
      fail-fast: true
      matrix:
        multi: [a, b, c, d, e, f, g, h, i, j]
    permissions:
      id-token: write
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@00943011d9042930efac3dcd3a170e4273319bc8 # v5.1.0
        with:
          aws-region: ap-northeast-1
          role-to-assume: ${{ secrets.AWS_ROLE_TO_ASSUME }}
          role-session-name: GitHubActions-${{ github.run_id }}
          role-duration-seconds: 900 # minimum: 900sec, maximum: iam role session duration

```

## Permissions

Newly created repository's GitHub Actions token `github.token` permissions are set to `readonly` by default in 2025. However if you have an older repository, your actions token may still have `write` permissions. To enhance security, it is recommended to explicitly set the minimum required permissions for each workflow. You can confirm your repository's default permissions in the repository settings under "Actions" > "General" > "Workflow permissions".

![](./images/workflow-permissions.png)

GitHub Actions supports specify permissions for each job or workflow. You can set `permissions:` at workflow level or job level. Job level permission override workflow level permission and can set `job.<job_name>.permissions`. You can turn all permission off with `permissions: {}`.

In general, it is a good practice to set `contents: read` permission for workflows that do not require write access. This minimizes the potential impact of any security vulnerabilities in your workflows. If you just checkout and build code, you probably only need `contents: read` permission.

```yaml
# .github/workflows/permissions-minimum.yaml

name: permissions minimum
on:
  pull_request:
    branches: ["main"]

# avoid workflow level permission, set job level permission as needed
# permissions:
#   contents: write

jobs:
  build:
    # specify minimum permissions as possible
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - uses: actions/setup-go@4dc6199c7b1a012772edbd06daecab0f50c9053c # v6.1.0
        with:
          go-version: "1.25"
      - name: Build
        run: go build
        working-directory: ./src/go

```

Avoiding workflow level permissions like below is also recommended. Instead, set job level permissions as needed.

```yaml
# Avoid this
permissions:
  contents: write

jobs:
  need-write:
    # specify job level permissions as needed
    permissions:
      contents: write
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo "foo"

  need-read:
    # specify job level permissions as needed
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo "bar"
```

## Pin Third-Party Actions to Commit SHA

Several vulnerabilities in GitHub Actions have been identified due to the use of tags or version numbers. To mitigate these risks, [always pin your actions to a specific commit SHA](https://docs.github.com/en/actions/reference/security/secure-use#using-third-party-actions).

- There are several ways to find the commit SHA for a specific version of an action, I recommend using the [suzuki-shunsuke/pinact](https://github.com/suzuki-shunsuke/pinact).
- Both Dependabot and Renovate can help you keep your actions up to date even pinned to a specific commit SHA.

<details><summary>How to use pinact</summary>

For example, instead of using action version like below:

```
uses: actions/checkout@v5
```

Run pinact to get the commit SHA.

```sh
$ pinact run
```

Then action will be pinned to specific commit SHA like below:

```
uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
```

</details>

Following is an example of using pinned sha in your workflow.

```yaml
# .github/workflows/pin-sha.yaml

name: pin sha
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  pin-sha:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      # Don't use a tag or branch, but specify the full sha instead
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false

```

---

# Cheat Sheet

Cheat sheet for GitHub Actions.

## Actions naming

Follow the `setup-foo` style.
Use hyphens `-` instead of underscores `_`.

- ✔️: `setup-foo`
- ❌: `setup_foo`

Action folder naming also follows this rule.

- ✔️: `.github/actions/setup-foo`
- ❌: `.github/actions/setup_foo`

## Actions runner info

When you want to see hosted runner information, here is a sample.

```yaml
# .github/workflows/actionrunner-info.yaml

name: action runner info
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  schedule:
    - cron: "0 0 * * *"

jobs:
  info:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: Ubuntu Version
        run: lsb_release -a
      - name: CPU (/proc/cpuinfo)
        run: cat /proc/cpuinfo
      - name: CPU (lscpu)
        run: lscpu
      - name: CPU Name
        id: cpu
        run: |
          cpu=$(less /proc/cpuinfo | grep -m 1 'model name' | cut -f 2 -d ":")
          echo "name=${cpu:1}" | tee -a "${GITHUB_OUTPUT}"
      - name: Memory Info (/proc/meminfo)
        run: cat /proc/meminfo
      - name: Storage (df)
        run: df -h
      - name: Network (ip)
        run: ip -o -f inet addr show
      - name: User (passwd)
        run: cat /etc/passwd
      - name: Group (group)
        run: cat /etc/group

```

## Detect PullRequest (PR) is Fork or not

There are several ways to achieve this. The simplest and easiest to understand is the `fork` boolean.

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

3. Check if the label matches the owner. An org member's commit label matches the owner.

```
# Fork
if: ${{ ! startsWith(github.event.pull_request.head.label, format('{0}:', github.repository_owner)) }}

# Not Fork
if: ${{ startsWith(github.event.pull_request.head.label, format('{0}:', github.repository_owner)) }}
```

## Debug downloaded remote action

A specified remote action is downloaded to the `/home/runner/work/_actions/{Owner}/{Repository}/{Ref}/{RepositoryStructures}` folder. You can check the downloaded action contents by listing the folder. This is useful when you want to see how a remote action works under the hood.

```yaml
# .github/workflows/debug-downloaded-remote-action.yaml

name: debug downloaded remote action
on:
  workflow_dispatch:

jobs:
  remote:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      # wow, remote action will be download under `/home/runner/work/_actions/{Owner}/{Repository}/{Ref}/{RepositoryStructures}`
      - name: debug
        run: ls -R /home/runner/work/_actions/actions/checkout/v4
      - name: debug by workspace
        run: ls -R ${{ github.workspace }}/../../_actions/actions/checkout/v4

```

## Expression string concat

You may be confused about how to concatenate strings and use them in an `if` condition. The following example shows how to use `format()` to concatenate strings and use them in an `if` condition.

```yaml
# .github/workflows/expression-string-concat.yaml

name: expression string concat
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
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - run: echo "this is hoge FORMAT"
        if: ${{ format('local/{0}', matrix.sample) == 'local/hoge' }}
      - run: echo "this is fuga FORMAT"
        if: ${{ format('local/{0}', matrix.sample) == 'local/fuga' }}

```


## Get Branch

`github.ref` context will return branch name, however it is unsafe to directly reference in ref. It is recommended to use through env.

- pull_request: `${{ github.event.pull_request.head.ref }}`
- push and others: `${{ github.ref }}`

```yaml
# .github/workflows/_reusable-dump-context.yaml#L20-L22

runs-on: ${{ matrix.runs-on }}
timeout-minutes: 5
steps:
```

## Get Tag

When triggering a push with a tag, you have 2 choices:

1. `echo "${{ github.ref_name }}"`
2. `echo "${GITHUB_REF##*/}"`
  - `refs/heads/xxxxx` -> `xxxxx`
  - `refs/tags/v1.0.0` -> `v1.0.0`

```yaml
# .github/workflows/tag-push-only-context.yaml

name: tag push context
on:
  push:
    tags:
      - "**" # only tag

jobs:
  ref:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: Use GITHUB_REF and GITHUB_OUTPUT
        run: echo "GIT_TAG=${GITHUB_REF##*/}" >> "$GITHUB_OUTPUT"
        id: CI_TAG
      - name: Use GITHUB_REF and GITHUB_ENV
        run: echo "GIT_TAG=${GITHUB_REF##*/}" >> "$GITHUB_ENV"
      - name: Show tag value by GITHUB_REF
        run: |
          echo "${{ steps.CI_TAG.outputs.GIT_TAG }}"
          echo "${{ env.GIT_TAG }}"
      - name: Show tag value by github.ref_name
        run: echo "${GITHUB_REF_NAME}"
        env:
          GITHUB_REF_NAME: ${{ github.ref_name }}

```

## Get Workflow Name

```yaml
${{ github.workflow }}
```

## Get Workflow Url

```yaml
${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}
```

## Get Job Url

```yaml
${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}/job/${{ job.check_run_id }}
```


## GitHub Actions commit icon

Use following Git config to commit as GitHub Actions icon.

```bash
git config user.name github-actions[bot]
git config user.email 41898282+github-actions[bot]@users.noreply.github.com
```

## Path for Downloaded Remote Actions

If a job uses remote actions or remote workflows, they will be downloaded to the `/home/runner/work/_actions/{OWNER}/{REPOSITORY}/{REF}` folder. For example, `actions/checkout@v4` will be downloaded to `/home/runner/work/_actions/actions/checkout/v4`.

This path is useful when you want to access files or use them beyond the action.

```yaml
# .github/workflows/remote-actions-download-path.yaml

name: remote actions download path
on:
  workflow_dispatch:
  pull_request:
    branches: ["main"]

jobs:
  action:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - name: Downloaded actions from the marketplace
        run: ls -l /home/runner/work/_actions
      - name: See actions download path
        run: ls -l /home/runner/work/_actions/actions/checkout/
      - name: See actions download contents
        run: ls -lR /home/runner/work/_actions/actions/checkout/08c6903cd8c0fde910a37f88322edcfb5dd907a8
      - name: Cat action's src/main.ts
        run: cat /home/runner/work/_actions/actions/checkout/08c6903cd8c0fde910a37f88322edcfb5dd907a8/src/main.ts

```

## Stale Issue and PR close automation

You can automatically close stale issues and PRs with [actions/stale](https://github.com/actions/stale). This action will mark issues and PRs as stale after a certain period of inactivity, then close them after another period of inactivity. If an update/comment occurs on stale issues or pull requests, the stale label will be removed and the timer will restart.

```yaml
# .github/workflows/stale.yaml

name: "stale"
on:
  workflow_dispatch:
  schedule:
    - cron: "0 0 * * *"

jobs:
  stale:
    permissions:
      contents: read
      issues: write
      pull-requests: write
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/stale@5f858e3efba33a5ca4407a664cc011ad407f2008 # v10.1.0
        with:
          repo-token: ${{ secrets.GITHUB_TOKEN }}
          # enable issue
          stale-issue-message: "This issue is stale because it has been open 180 days with no activity. Remove stale label or comment or this will be closed in 30 days."
          stale-issue-label: "stale"
          # enable pr
          stale-pr-message: "This PR is stale because it has been open 180 days with no activity. Remove stale label or comment or this will be closed in 30 days."
          stale-pr-label: "stale"
          days-before-stale: 180
          days-before-close: 30
          exempt-issue-labels: "no-stale"
          exempt-pr-labels: "no-stale"
          remove-stale-when-updated: true

```

## Telemetry for GitHub Workflow execution

GitHub Actions [runforesight/workflow-telemetry-action](https://github.com/runforesight/workflow-telemetry-action) offers workflow telemetry. Telemetry indicate which step consume much Execution Time, CPU, Memory and Network I/O. Default settings post telemetry result to PR comment and JOB Summary.


To enable telemetry, set `runforesight/workflow-telemetry-action@v1` on the first step of your job, then action collect telemetry for later steps.

```yaml
# .github/workflows/actions-telemetry.yaml

name: actions telemetry
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  dotnet:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: Collect actions workflow telemetry
        uses: runforesight/workflow-telemetry-action@94c3c3d9567a0205de6da68a76c428ce4e769af1 # v2.0.0
        with:
          theme: dark # or light. dark generate charts compatible with Github dark mode.
          comment_on_pr: false # post telemetry to PR comment. It won't override existing comment, therefore too noisy for PR.
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - uses: actions/setup-dotnet@d4c94342e560b34958eacfc5d055d21461ed1c5d # v5.0.0
        with:
          dotnet-version: 10.0.x
      - name: dotnet build
        run: dotnet build ./src/dotnet -c Debug
      - name: dotnet test
        run: dotnet test ./src/dotnet -c Debug --logger GitHubActions --logger "console;verbosity=normal"
      - name: dotnet publish
        run: dotnet publish ./src/dotnet/ -c Debug

```

Telemetry is posted to [Job Summary](https://github.com/guitarrapc/githubactions-lab/actions/runs/6266182534).

![GitHub Workflow Telemetry in GitHub Step Summary](./images/workflow-telemetry-action-githubstepsummary.png)

Also if workflow ran with `pull_request` trigger, then you can enable [PR comment](https://github.com/guitarrapc/githubactions-lab/pull/109) by default or set `comment_on_pr: true`.

![GitHub Workflow Telemetry PR Comment](./images/workflow-telemetry-action-prcomment.png)

## Tool management in GitHub Actions with Aqua

[Aqua](https://aquaproj.github.io/) is a tool manager and useful for GitHub Actions. Aqua can install and manage multiple tools in your GitHub Actions workflow. Aqua uses `aqua.yaml` file to define which tools and versions to install. Just calling `aqua install` command will install all tools defined in `aqua.yaml`, you don't need to install each tool one by one.

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
  lint:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
        with:
          persist-credentials: false
      - uses: aquaproj/aqua-installer@9ebf656952a20c45a5d66606f083ff34f58b8ce0 # v4.0.0
        with:
          aqua_version: v2.43.1
      # github workflows/action's Static Checker
      - name: Run actionlint
        run: actionlint -color -oneline
      # checkout's persist-credentials: false checker
      - name: Run ghalint
        run: ghalint run
      # A static analysis tool for GitHub Actions
      - name: Run zizmor
        run: docker run -t -v .:/github ghcr.io/woodruffw/zizmor:1.5.2 /github --min-severity medium

```

## Type converter with fromJson

There are some cases where you want to convert a string to another type.
Consider a case where you want to use a boolean input `is-valid` with workflow_dispatch, then pass it to workflow_call as a boolean.

The `github.event.inputs` context treats all values as `string`, so `github.event.inputs.is-valid` is no longer a boolean.
The `fromJson` expression is the trick to convert types from string to boolean.

```yaml
${{ github.event.inputs.foobar == "true" }} # true. type is string
${{ fromJson(github.event.inputs.foobar) == true }} # true. string convert to boolean
```

Another way is to use the `inputs.foobar` context. `inputs` has type information and passes it exactly as-is to other workflow calls.

```yaml
${{ inputs.foobar == 'true' }} # false. type is not string
${{ inputs.foobar == true }} # true. type is boolean
```


## Want to get a list of GitHub Actions scheduled workflows

You can get a list of scheduled workflows with the following script. Make sure you have [gh](https://github.com/cli/cli#installation), [jq](https://github.com/jqlang/jq) and [yq](https://github.com/mikefarah/yq) installed.

```
echo "| Workflow | File Name | Schedule (UTC) | Last Commit by |"
echo "| ---- | ---- | ---- | ---- |"
repo=$(gh repo view --json owner,name -q ".owner.login + \"/\" + .name")
json=$(gh workflow list --json name,path,state --limit 300)
echo "$json" | jq -c '.[] | select(.state == "active") | {name: .name, path: .path}' | sort | while read -r item; do
  name=$(echo "$item" | jq -r '.name')
  path=$(echo "$item" | jq -r '.path')
  if [[ ! -f "$path" ]]; then continue; fi
  schedule=$(cat "$path" | yq -o=json | jq -r 'select(.on.schedule != null) | [.on.schedule[].cron] | join("<br/>")')
  if [[ -z "$schedule" ]]; then continue; fi
  commiter=$(gh api -X GET "repos/${repo}/commits" -f path="$path" -F per_page=1 | jq -r ".[].committer.login")
  echo "| $name | $path | $schedule | $commiter |"
done
```

> [!TIP]
> Please avoid using `on: [array]`, it will show error message `jq: error (at <stdin>:87): Cannot index array with string "schedule"`. Instead, use `on: object` like below.
> ```
> on:
>   pull_request:
> ```

Following is the result of the script.

| Workflow | File Name | Schedule (UTC) | Last Commit by |
| ---- | ---- | ---- | ---- |
| action runner info | .github/workflows/actionrunner-info.yaml | 0 0 * * * | guitarrapc |
| actionlint | .github/workflows/actionlint.yaml | 0 0 * * * | guitarrapc |
| auto dump context | .github/workflows/auto-dump-context.yaml | 0 0 * * * | guitarrapc |
| context github | .github/workflows/context-github.yaml | 0 0 * * * | guitarrapc |
| dotnet lint | .github/workflows/dotnet-lint.yaml | 0 1 * * 1 | guitarrapc |
| dump context | .github/workflows/dump-context.yaml | 0 0 * * * | guitarrapc |
| schedule job | .github/workflows/schedule-job.yaml | 0 0 * * * | guitarrapc |
| stale | .github/workflows/stale.yaml | 0 0 * * * | guitarrapc |
