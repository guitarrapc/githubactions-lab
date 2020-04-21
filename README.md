githubaction-lab

language | badge
---- | ----
dotnet | ![build](https://github.com/guitarrapc/githubaction-lab/workflows/build/badge.svg?branch=master)

## commit handling

### View Webhook GitHub Context

```yaml
name: view github context

on: ['push']

jobs:
  build:
    runs-on: ubuntu-latest
  steps:
  - run: echo $GITHUB_CONTEXT
    env: 
      GITHUB_CONTEXT: ${{ toJson(github) }}
```


### skip ci

no default handling. use following.

`head_commit` may become null when event is `pull_request` or `push` for tag deletion.

```yaml
name: skip ci sample

on: ['push']

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
name: trigger ci sample

on: ['push']

jobs:
  build:
    if: "contains(toJSON(github.event.commits.*.message), '[build]')"
    runs-on: ubuntu-latest
  steps:
    - run: echo $COMMIT_MESSAGES
    env: 
      COMMIT_MESSAGES: ${{ toJson(github.event.commits.*.message) }}
```
