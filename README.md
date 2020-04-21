githubaction-lab

language | badge
---- | ----
dotnet | ![build](https://github.com/guitarrapc/githubaction-lab/workflows/build/badge.svg?branch=master)

## fundamentals

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

on:
  pull_request:
    types: opened, synchronize, labeled

jobs:
  comment:
    runs-on: ubuntu-latest
    steps:
      - run: echo $GITHUB_CONTEXT
        env:
          GITHUB_CONTEXT: ${{ toJson(github) }}
      - run: echo $TITLE
        env:
          TITLE: ${{ toJson(github.event.title) }}
```