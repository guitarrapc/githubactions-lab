---
on:
  schedule:
    - cron: "52 9 1 * *"
      timezone: "Asia/Tokyo"

permissions:
  contents: read
  issues: read
  pull-requests: read

safe-outputs:
  create-issue:
    title-prefix: "[oss status] "
    labels: [report]

tools:
  github:
---

# Monthly OSS Repo Status Report

Create a monthly status report for maintainers covering the past 30 days from the workflow execution time.

Include
- Collect all OSS repositories under the `guitarrapc` GitHub account (not just this repository), which are public and not archived, and have at least one commit, issue or PR created in the past 30 days.
- Repository activity from the past 30 days (issues, PRs, discussions, releases, code changes)
- Progress tracking, highlights, and suspicious activities observed in the past 30 days
- Projects status summary
- Actionable next steps for maintainers

Keep it concise and link to the relevant issues/PRs.
