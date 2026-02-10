[![auto doc](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto-doc.yaml/badge.svg)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto-doc.yaml)
[![auto dump context](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto-dump-context.yaml/badge.svg)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/auto-dump-context.yaml)
[![actionlint](https://github.com/guitarrapc/githubactions-lab/actions/workflows/actionlint.yaml/badge.svg)](https://github.com/guitarrapc/githubactions-lab/actions/workflows/actionlint.yaml)

[English](./README.md) | 日本語

# githubactions-lab

GitHub Actionsの研究とテストラボです。

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# Table of Contents

- [まだサポートされていない機能](#%E3%81%BE%E3%81%A0%E3%82%B5%E3%83%9D%E3%83%BC%E3%83%88%E3%81%95%E3%82%8C%E3%81%A6%E3%81%84%E3%81%AA%E3%81%84%E6%A9%9F%E8%83%BD)
  - [ビュー](#%E3%83%93%E3%83%A5%E3%83%BC)
  - [機能](#%E6%A9%9F%E8%83%BD)
  - [プラン制限](#%E3%83%97%E3%83%A9%E3%83%B3%E5%88%B6%E9%99%90)
- [GitHub ActionsへのCIの移行](#github-actions%E3%81%B8%E3%81%AEci%E3%81%AE%E7%A7%BB%E8%A1%8C)
- [GitHub Actions vs 他のCIプラットフォーム](#github-actions-vs-%E4%BB%96%E3%81%AEci%E3%83%97%E3%83%A9%E3%83%83%E3%83%88%E3%83%95%E3%82%A9%E3%83%BC%E3%83%A0)
  - [コアワークフロー機能](#%E3%82%B3%E3%82%A2%E3%83%AF%E3%83%BC%E3%82%AF%E3%83%95%E3%83%AD%E3%83%BC%E6%A9%9F%E8%83%BD)
  - [セキュリティとアクセス制御](#%E3%82%BB%E3%82%AD%E3%83%A5%E3%83%AA%E3%83%86%E3%82%A3%E3%81%A8%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E5%88%B6%E5%BE%A1)
  - [インフラストラクチャとパフォーマンス](#%E3%82%A4%E3%83%B3%E3%83%95%E3%83%A9%E3%82%B9%E3%83%88%E3%83%A9%E3%82%AF%E3%83%81%E3%83%A3%E3%81%A8%E3%83%91%E3%83%95%E3%82%A9%E3%83%BC%E3%83%9E%E3%83%B3%E3%82%B9)
  - [開発体験](#%E9%96%8B%E7%99%BA%E4%BD%93%E9%A8%93)
- [基本 - オンボーディング](#%E5%9F%BA%E6%9C%AC---%E3%82%AA%E3%83%B3%E3%83%9C%E3%83%BC%E3%83%87%E3%82%A3%E3%83%B3%E3%82%B0)
  - [runステップ](#run%E3%82%B9%E3%83%86%E3%83%83%E3%83%97)
  - [ifセクション](#if%E3%82%BB%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3)
  - [ランナーのサイズ設定](#%E3%83%A9%E3%83%B3%E3%83%8A%E3%83%BC%E3%81%AE%E3%82%B5%E3%82%A4%E3%82%BA%E8%A8%AD%E5%AE%9A)
  - [Timeout](#timeout)
- [基本 - 基礎](#%E5%9F%BA%E6%9C%AC---%E5%9F%BA%E7%A4%8E)
  - [デフォルトシェル](#%E3%83%87%E3%83%95%E3%82%A9%E3%83%AB%E3%83%88%E3%82%B7%E3%82%A7%E3%83%AB)
  - [コンテキストメタデータのダンプ](#%E3%82%B3%E3%83%B3%E3%83%86%E3%82%AD%E3%82%B9%E3%83%88%E3%83%A1%E3%82%BF%E3%83%87%E3%83%BC%E3%82%BF%E3%81%AE%E3%83%80%E3%83%B3%E3%83%97)
  - [スクリプト内の環境変数](#%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E5%86%85%E3%81%AE%E7%92%B0%E5%A2%83%E5%A4%89%E6%95%B0)
  - [実行順序](#%E5%AE%9F%E8%A1%8C%E9%A0%86%E5%BA%8F)
  - [ジョブ出力](#%E3%82%B8%E3%83%A7%E3%83%96%E5%87%BA%E5%8A%9B)
  - [冗長制御](#%E5%86%97%E9%95%B7%E5%88%B6%E5%BE%A1)
  - [前のジョブが成功したときに実行](#%E5%89%8D%E3%81%AE%E3%82%B8%E3%83%A7%E3%83%96%E3%81%8C%E6%88%90%E5%8A%9F%E3%81%97%E3%81%9F%E3%81%A8%E3%81%8D%E3%81%AB%E5%AE%9F%E8%A1%8C)
  - [前のステップステータスが特定の場合に実行](#%E5%89%8D%E3%81%AE%E3%82%B9%E3%83%86%E3%83%83%E3%83%97%E3%82%B9%E3%83%86%E3%83%BC%E3%82%BF%E3%82%B9%E3%81%8C%E7%89%B9%E5%AE%9A%E3%81%AE%E5%A0%B4%E5%90%88%E3%81%AB%E5%AE%9F%E8%A1%8C)
  - [Matrix](#matrix)
  - [手動実行のためのWorkflow dispatch](#%E6%89%8B%E5%8B%95%E5%AE%9F%E8%A1%8C%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AEworkflow-dispatch)
- [Basic - Commit, Branch and Tag handling](#basic---commit-branch-and-tag-handling)
  - [リリースを作成する](#%E3%83%AA%E3%83%AA%E3%83%BC%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B)
  - [ファイル変更を検出する](#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%A4%89%E6%9B%B4%E3%82%92%E6%A4%9C%E5%87%BA%E3%81%99%E3%82%8B)
  - [非デフォルトブランチでのスケジュールジョブ](#%E9%9D%9E%E3%83%87%E3%83%95%E3%82%A9%E3%83%AB%E3%83%88%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%A7%E3%81%AE%E3%82%B9%E3%82%B1%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%82%B8%E3%83%A7%E3%83%96)
  - [ブランチプッシュのみをトリガーし、タグプッシュではスキップ](#%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%83%97%E3%83%83%E3%82%B7%E3%83%A5%E3%81%AE%E3%81%BF%E3%82%92%E3%83%88%E3%83%AA%E3%82%AC%E3%83%BC%E3%81%97%E3%82%BF%E3%82%B0%E3%83%97%E3%83%83%E3%82%B7%E3%83%A5%E3%81%A7%E3%81%AF%E3%82%B9%E3%82%AD%E3%83%83%E3%83%97)
  - [コミットメッセージでトリガーする](#%E3%82%B3%E3%83%9F%E3%83%83%E3%83%88%E3%83%A1%E3%83%83%E3%82%BB%E3%83%BC%E3%82%B8%E3%81%A7%E3%83%88%E3%83%AA%E3%82%AC%E3%83%BC%E3%81%99%E3%82%8B)
  - [タグプッシュのみをトリガーし、ブランチプッシュではスキップ](#%E3%82%BF%E3%82%B0%E3%83%97%E3%83%83%E3%82%B7%E3%83%A5%E3%81%AE%E3%81%BF%E3%82%92%E3%83%88%E3%83%AA%E3%82%AC%E3%83%BC%E3%81%97%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%83%97%E3%83%83%E3%82%B7%E3%83%A5%E3%81%A7%E3%81%AF%E3%82%B9%E3%82%AD%E3%83%83%E3%83%97)
  - [特定のタグパターンでトリガーする](#%E7%89%B9%E5%AE%9A%E3%81%AE%E3%82%BF%E3%82%B0%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E3%81%A7%E3%83%88%E3%83%AA%E3%82%AC%E3%83%BC%E3%81%99%E3%82%8B)
- [Basic - Issue and Pull Request handling](#basic---issue-and-pull-request-handling)
  - [プルリクエストのラベルを検出する](#%E3%83%97%E3%83%AB%E3%83%AA%E3%82%AF%E3%82%A8%E3%82%B9%E3%83%88%E3%81%AE%E3%83%A9%E3%83%99%E3%83%AB%E3%82%92%E6%A4%9C%E5%87%BA%E3%81%99%E3%82%8B)
  - [プルリクエストのタイトルでCIをスキップする](#%E3%83%97%E3%83%AB%E3%83%AA%E3%82%AF%E3%82%A8%E3%82%B9%E3%83%88%E3%81%AE%E3%82%BF%E3%82%A4%E3%83%88%E3%83%AB%E3%81%A7ci%E3%82%92%E3%82%B9%E3%82%AD%E3%83%83%E3%83%97%E3%81%99%E3%82%8B)
  - [フォークリポジトリからのPRをスキップ](#%E3%83%95%E3%82%A9%E3%83%BC%E3%82%AF%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%8B%E3%82%89%E3%81%AEpr%E3%82%92%E3%82%B9%E3%82%AD%E3%83%83%E3%83%97)
  - [ドラフトPR時にジョブをスキップ](#%E3%83%89%E3%83%A9%E3%83%95%E3%83%88pr%E6%99%82%E3%81%AB%E3%82%B8%E3%83%A7%E3%83%96%E3%82%92%E3%82%B9%E3%82%AD%E3%83%83%E3%83%97)
- [高度な機能](#%E9%AB%98%E5%BA%A6%E3%81%AA%E6%A9%9F%E8%83%BD)
  - [Dependabotによる自動Actionsバージョン更新](#dependabot%E3%81%AB%E3%82%88%E3%82%8B%E8%87%AA%E5%8B%95actions%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E6%9B%B4%E6%96%B0)
  - [Build Artifacts](#build-artifacts)
  - [並行制御](#%E4%B8%A6%E8%A1%8C%E5%88%B6%E5%BE%A1)
  - [コンテナジョブ](#%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%82%B8%E3%83%A7%E3%83%96)
  - [Custom actions](#custom-actions)
  - [Custom actions - JavaScript Actions](#custom-actions---javascript-actions)
  - [Data passing](#data-passing)
  - [他のリポジトリのワークフローをディスパッチする](#%E4%BB%96%E3%81%AE%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E3%83%AF%E3%83%BC%E3%82%AF%E3%83%95%E3%83%AD%E3%83%BC%E3%82%92%E3%83%87%E3%82%A3%E3%82%B9%E3%83%91%E3%83%83%E3%83%81%E3%81%99%E3%82%8B)
  - [フォークユーザーのワークフロー変更防止](#%E3%83%95%E3%82%A9%E3%83%BC%E3%82%AF%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC%E3%81%AE%E3%83%AF%E3%83%BC%E3%82%AF%E3%83%95%E3%83%AD%E3%83%BC%E5%A4%89%E6%9B%B4%E9%98%B2%E6%AD%A2)
  - [git checkoutの高速化](#git-checkout%E3%81%AE%E9%AB%98%E9%80%9F%E5%8C%96)
  - [GitHub Step Summary](#github-step-summary)
  - [PR info from Merge Commit](#pr-info-from-merge-commit)
  - [Reusable workflow](#reusable-workflow)
  - [ワークフローコマンド](#%E3%83%AF%E3%83%BC%E3%82%AF%E3%83%95%E3%83%AD%E3%83%BC%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
  - [YAMLアンカー](#yaml%E3%82%A2%E3%83%B3%E3%82%AB%E3%83%BC)
- [Security](#security)
  - [Checkout without persist-credentials](#checkout-without-persist-credentials)
  - [Personal Access Tokenの代わりにGitHub App Token](#personal-access-token%E3%81%AE%E4%BB%A3%E3%82%8F%E3%82%8A%E3%81%ABgithub-app-token)
  - [コンテキスト経由のインジェクション攻撃](#%E3%82%B3%E3%83%B3%E3%83%86%E3%82%AD%E3%82%B9%E3%83%88%E7%B5%8C%E7%94%B1%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B8%E3%82%A7%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%E6%94%BB%E6%92%83)
  - [ワークフロー内のアクションを最新に保つ](#%E3%83%AF%E3%83%BC%E3%82%AF%E3%83%95%E3%83%AD%E3%83%BC%E5%86%85%E3%81%AE%E3%82%A2%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E6%9C%80%E6%96%B0%E3%81%AB%E4%BF%9D%E3%81%A4)
  - [GitHub Actionsワークフローのリント](#github-actions%E3%83%AF%E3%83%BC%E3%82%AF%E3%83%95%E3%83%AD%E3%83%BC%E3%81%AE%E3%83%AA%E3%83%B3%E3%83%88)
  - [外部プロバイダーへのアクセスのためのOIDC接続](#%E5%A4%96%E9%83%A8%E3%83%97%E3%83%AD%E3%83%90%E3%82%A4%E3%83%80%E3%83%BC%E3%81%B8%E3%81%AE%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AEoidc%E6%8E%A5%E7%B6%9A)
  - [Permissions](#permissions)
  - [Pin Third-Party Actions to Commit SHA](#pin-third-party-actions-to-commit-sha)
- [Cheat Sheet](#cheat-sheet)
  - [Actions naming](#actions-naming)
  - [Actionsランナー情報](#actions%E3%83%A9%E3%83%B3%E3%83%8A%E3%83%BC%E6%83%85%E5%A0%B1)
  - [プルリクエスト(PR)がフォークかどうかを検出する](#%E3%83%97%E3%83%AB%E3%83%AA%E3%82%AF%E3%82%A8%E3%82%B9%E3%83%88pr%E3%81%8C%E3%83%95%E3%82%A9%E3%83%BC%E3%82%AF%E3%81%8B%E3%81%A9%E3%81%86%E3%81%8B%E3%82%92%E6%A4%9C%E5%87%BA%E3%81%99%E3%82%8B)
  - [ダウンロードされたリモートアクションをデバッグする](#%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89%E3%81%95%E3%82%8C%E3%81%9F%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%82%A2%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E3%83%87%E3%83%90%E3%83%83%E3%82%B0%E3%81%99%E3%82%8B)
  - [式での文字列連結](#%E5%BC%8F%E3%81%A7%E3%81%AE%E6%96%87%E5%AD%97%E5%88%97%E9%80%A3%E7%B5%90)
  - [ブランチを取得する](#%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%82%92%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B)
  - [タグを取得する](#%E3%82%BF%E3%82%B0%E3%82%92%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B)
  - [ワークフロー名を取得する](#%E3%83%AF%E3%83%BC%E3%82%AF%E3%83%95%E3%83%AD%E3%83%BC%E5%90%8D%E3%82%92%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B)
  - [ワークフローURLを取得する](#%E3%83%AF%E3%83%BC%E3%82%AF%E3%83%95%E3%83%AD%E3%83%BCurl%E3%82%92%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B)
  - [ジョブURLを取得する](#%E3%82%B8%E3%83%A7%E3%83%96url%E3%82%92%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B)
  - [GitHub Actionsのコミットアイコン](#github-actions%E3%81%AE%E3%82%B3%E3%83%9F%E3%83%83%E3%83%88%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3)
  - [ダウンロードされたリモートアクションのパス](#%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89%E3%81%95%E3%82%8C%E3%81%9F%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%82%A2%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AE%E3%83%91%E3%82%B9)
  - [古いIssueとPRの自動クローズ](#%E5%8F%A4%E3%81%84issue%E3%81%A8pr%E3%81%AE%E8%87%AA%E5%8B%95%E3%82%AF%E3%83%AD%E3%83%BC%E3%82%BA)
  - [GitHubワークフロー実行のテレメトリー](#github%E3%83%AF%E3%83%BC%E3%82%AF%E3%83%95%E3%83%AD%E3%83%BC%E5%AE%9F%E8%A1%8C%E3%81%AE%E3%83%86%E3%83%AC%E3%83%A1%E3%83%88%E3%83%AA%E3%83%BC)
  - [AquaでGitHub Actionsのツール管理](#aqua%E3%81%A7github-actions%E3%81%AE%E3%83%84%E3%83%BC%E3%83%AB%E7%AE%A1%E7%90%86)
  - [fromJsonを使用した型変換](#fromjson%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%97%E3%81%9F%E5%9E%8B%E5%A4%89%E6%8F%9B)
  - [GitHub Actionsのスケジュールワークフロー一覧を取得したい](#github-actions%E3%81%AE%E3%82%B9%E3%82%B1%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E3%83%AF%E3%83%BC%E3%82%AF%E3%83%95%E3%83%AD%E3%83%BC%E4%B8%80%E8%A6%A7%E3%82%92%E5%8F%96%E5%BE%97%E3%81%97%E3%81%9F%E3%81%84)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# まだサポートされていない機能

## ビュー
- [ ] ワークフロー概要ステータスビュー
  - ワークフローステータスの概要ビューがありません。Jenkinsはジョブステータスのビューを提供しており、1ステップで現在のステータスを把握できます。
  - 回避策: なし。
- [ ] GitHub Actionsワークフロービューのグループ化
  - GitHub Actionsワークフローをグループ化できません。
  - 回避策: なし。
- [ ] テストインサイトビュー
  - [CircleCI](https://circleci.com/docs/insights-tests)や[Azure Pipeline](https://docs.microsoft.com/en-us/azure/devops/pipelines/test/review-continuous-test-results-after-build?view=azure-devops)が提供するようなテストインサイトビューがありません。
  - 回避策: [$GITHUB_STEP_SUMMARY](https://github.blog/2022-05-09-supercharging-github-actions-with-job-summaries/)を使用してください。

## 機能
- [ ] ワークフローレベルの`timeout-minutes`
  - 現在、timeout-minutesはジョブとステップに設定できますが、ワークフロー全体のデフォルト360分を変更できません。
  - 回避策: なし。すべてのジョブに`timeout-minutes`を設定してください。
- [ ] ワークフロー並行制御のカスタマイズ
  - 現在、並行制御は`key`と`cancel-in-progress`オプションで処理できます。少なくとも1つの保留中のジョブが存在する場合、アクションは終了します。ただし、保留中のアクションの数をカスタマイズしたり、保留中のジョブのキャンセルを防止したりすることはできません。
  - 回避策: なし。
- [ ] SSHデバッグ
  - [CircleCIが提供](https://circleci.com/docs/ssh-access-jobs)するようなSSHデバッグ機能がありません。
  - 回避策: [Debugging with ssh Actions](https://github.com/marketplace/actions/debugging-with-ssh)を使用してください。
- [x] 動的設定
  - CircleCIは[Dynamic Config](https://circleci.com/docs/dynamic-config)を提供しており、セットアップワークフロー、[path-filtering orb](https://circleci.com/developer/orbs/orb/circleci/path-filtering)によるパスフィルタリング、[continuation orb](https://circleci.com/developer/orbs/orb/circleci/continuation)が利用できます。2023年12月1日以降に作成されたプロジェクトではデフォルトで有効です。
  - GitHub Actionsは同様の機能を提供しています: 再利用可能なワークフロー/入力パラメータを持つComposite Actions、および条件付きワークフロー実行。

## プラン制限

### GitHub Team Plan, GitHub Pro Plan

- [ ] `Environment > Deployment protection rules`はGitHub Team/Proプランでは利用できません。`Required reviewers`（承認）と`Wait timer`を使用できません。プライベートリポジトリでこれらの機能を使用するには、GitHub Enterpriseプランが必要です。

<details><summary>詳細を表示するにはクリック</summary>

**プライベートリポジトリ**

Environment protection rulesで`Required reviewers`と`Wait timer`が使用できません。

![Environment Private Repository](./images/environment-private-repo.png)

**パブリックリポジトリ**

Environment protection rulesで`Required reviewers`と`Wait timer`が使用できます。

![Environment Public Repository](./images/environment-public-repo.png)

</details>

---

# GitHub ActionsへのCIの移行

移行に関するいくつかのドキュメントがあります。

- CircleCI -> GitHub Actions: [Migrating from CircleCI to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-circleci-to-github-actions)
- Azure pipeline -> GitHub Actions: [Migrating from Azure Pipelines to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-azure-pipelines-to-github-actions)
- GitLab -> GitHub Actions: [Migrating from GitLab CI/CD to GitHub Actions \- GitHub Docs](https://docs.github.com/en/actions/migrating-to-github-actions/migrating-from-gitlab-cicd-to-github-actions)
- Jenkins -> GitHub Actions: [Migrating from Jenkins to GitHub Actions \- GitHub Help](https://help.github.com/en/actions/migrating-to-github-actions/migrating-from-jenkins-to-github-actions)

GitHub Actionsからの移行も検討できます。

- GitHub Actions -> CircleCI: [Migrating from Github Actions \- CircleCI](https://circleci.com/docs/migrating-from-github)

# GitHub Actions vs 他のCIプラットフォーム

CIプラットフォーム間の主要機能の簡単な比較表:

| Feature | GitHub Actions | CircleCI | Azure Pipeline | Jenkins |
|---------|---------------|----------|----------------|---------|
| **Core Workflow** |
| YAML-based config | ✔️ | ✔️ | ✔️ | ❌ Groovy |
| Trigger Push & PR | ✔️ | ❌ | ✔️ | ⚠️ Separate |
| Reusable workflows | ✔️ Multiple | ✔️ | ✔️ | ⚠️ Complex |
| Path filter | ✔️ Built-in | ⚠️ Orb | ✔️ Built-in | ❌ |
| Concurrency control | ✔️ Built-in | ✔️ | ✔️ Stage-level | ⚠️ Built-in |
| Re-run failed jobs | ✔️ | ✔️ | ✔️ Single stage | ⚠️ Job-level |
| **Security** |
| Fork PR handling | ✔️ Approved | ⚠️ Limited | ✔️ | ❌ |
| Secrets management | ✔️ 3 scopes | ✔️ Context | ✔️ | ✔️ |
| Job approval | ⚠️ Paid plan | ✔️ | ✔️ | ✔️ |
| **Infrastructure** |
| Runner sizing | ✔️ Configurable | ✔️ | ❌ Fixed | N/A |
| Git sparse checkout | ✔️ | ❌ | ❌ | ✔️ |
| Git shallow clone | ✔️ Default | ✔️ Blobless | ✔️ Default | ✔️ |
| **Development** |
| Step output | ✔️ Dedicated | ⚠️ Env only | ✔️ | ⚠️ Env only |
| Job metadata | ✔️ Context | ✔️ Env vars | ✔️ Env vars | ✔️ Env vars |
| **Build Management** |
| Artifact retention | ✔️ Configurable | ⚠️ Permanent | ⚠️ Permanent | ⚠️ Configurable |
| Skip CI keywords | ✔️ 5 types | ✔️ 2 types | ✔️ 3+ types | ⚠️ Plugin |

**凡例:** ✔️ 完全サポート | ⚠️ 制限付き/部分的 | ❌ サポートなし | N/A 該当なし

## コアワークフロー機能

### ジョブとワークフロー

- ✔️ **GitHub Actions**: ジョブはワークフロー内で定義。PushとPR両方をトリガー。
- ✔️ **CircleCI**: ジョブはワークフロー内で結合。PushとPRを同時にトリガーできない。
- ✔️ **Azure Pipeline**: ジョブはstageで結合。PushとPR両方をトリガー。
- ⚠️ **Jenkins**: Declarative Pipeline(Groovy、YAMLではない)を使用。トリガーはパイプライン外で定義。

<details><summary>構文例を表示するにはクリック</summary>

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

### パスフィルター

変更されたファイルパスに基づいてワークフロー実行をフィルタリング:

- ✔️ **GitHub Actions**: [`on.<event>.paths`/`paths-ignore`](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#onpushpull_requestpaths)経由で組み込みサポート
- ✔️ **CircleCI**: [公式orbでパスフィルタリング](https://circleci.com/developer/orbs/orb/circleci/path-filtering)(動的設定が必要)
- ✔️ **Azure Pipeline**: 組み込みパスフィルターサポート
- ❌ **Jenkins**: 組み込みサポートなし。手動実装が必要。

### 再利用可能なジョブとワークフロー

- ✔️ **GitHub Actions**: 複数の再利用オプション: `再利用可能なワークフロー`、`Composite Actions`、`組織ワークフロー`、`YAMLアンカー`
- ✔️ **CircleCI**: ジョブの再利用と`YAMLアンカー`サポート
- ✔️ **Azure Pipeline**: stage/job/stepの再利用のためのテンプレートシステム
- ⚠️ **Jenkins**: パイプライン参照が利用可能だが複雑なことが多い。スクリプトベースの再利用が推奨される。

### 冗長ビルドのキャンセル

- ✔️ **GitHub Actions**: `cancel-in-progress`を使用した組み込み[並行制御](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency)。代替: コミュニティアクション([workflow-run-cleanup-action](https://github.com/marketplace/actions/workflow-run-cleanup-action)など)
- ✔️ **CircleCI**: 組み込み冗長ビルドキャンセル
- ✔️ **Azure Pipeline**: [ステージレベルの並行制御](https://learn.microsoft.com/en-us/azure/devops/release-notes/features-timeline)(2024 Q3以降利用可能)
- ⚠️ **Jenkins**: Declarative Pipelineに組み込み[`disableConcurrentBuilds()`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)オプション。`disableConcurrentBuilds(abortPrevious: true)`で以前のビルドを中止可能

### 失敗したワークフローの再実行

- ✔️ **GitHub Actions**: `ワークフロー全体`、`単一ジョブ`、または`失敗したジョブのみ`を再実行
- ✔️ **CircleCI**: `ワークフロー全体`または`失敗したジョブのみ`を再実行。また、`max_auto_reruns`と設定可能な遅延を使用した[自動ステップ再試行](https://circleci.com/docs/configuration-reference/#automatic-step-reruns)もサポート
- ✔️ **Azure Pipeline**: [単一ステージの再実行](https://learn.microsoft.com/en-us/azure/devops/release-notes/features-timeline)(2024 Q1以降利用可能)、手動ステージキューイングサポート
- ⚠️ **Jenkins**: `ジョブ全体`の再実行(安定版)。[`preserveStashes`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)オプションでステージレベルの再起動が利用可能(実験的機能)

### CIのスキップとコミットメッセージ

- ✔️ **GitHub Actions**: スキップキーワード: `[skip ci]`、`[ci skip]`、`[no ci]`、`[skip actions]`、`[actions skip]`
- ✔️ **CircleCI**: スキップキーワード: `[skip ci]`、`[ci skip]`
- ✔️ **Azure Pipeline**: スキップキーワード: `***NO_CI***`、`[skip ci]`、`[ci skip]`、[その他](https://github.com/Microsoft/azure-pipelines-agent/issues/858#issuecomment-475768046)
- ⚠️ **Jenkins**: [SCM Skipプラグイン](https://plugins.jenkins.io/scmskip/)が必要。デフォルトパターン: `.*\[ci skip\].*`(フリースタイルとパイプラインジョブの両方をサポート、カスタマイズ可能な正規表現)

### ビルド成果物の保存

- ✔️ **GitHub Actions**: [actions/upload-artifact](https://github.com/actions/upload-artifact) / [download-artifact](https://github.com/actions/download-artifact)。設定可能な保持期間。
- ⚠️ **CircleCI**: [`store_artifacts`](https://circleci.com/docs/artifacts/)ステップ。ダウンロードにはAPI呼び出しが必要。保持期間なし。
- ✔️ **Azure Pipeline**: [`PublishPipelineArtifact`](https://learn.microsoft.com/en-us/azure/devops/pipelines/artifacts/pipeline-artifacts?view=azure-devops&tabs=yaml) / `DownloadPipelineArtifact`タスク。保持期間なし。
- ⚠️ **Jenkins**: 保持ポリシーのための[`buildDiscarder`](https://www.jenkins.io/doc/book/pipeline/syntax/#options)を使用した[`archiveArtifacts`](https://www.jenkins.io/doc/pipeline/steps/core/#archiveartifacts-archive-the-artifacts)ステップ。Jenkins UIまたはAPI経由でダウンロード。

---

## セキュリティとアクセス制御

### フォーク処理

- ✔️ **GitHub Actions**: [ワークフロー承認システム](https://docs.github.com/en/actions/managing-workflow-runs/approving-workflow-runs-from-public-forks)でフォークPRトリガーをサポート。シークレットアクセスのための[実用的なセキュリティパターン](https://securitylab.github.com/research/github-actions-preventing-pwn-requests/)を提供。
- ⚠️ **CircleCI**: フォークPRをサポートするが、`/pull\/[0-9]+/`のような[ブランチ命名規則による制限](https://circleci.com/docs/oss/#build-pull-requests-from-forked-repositories)がある。シークレットアクセスを安全に処理する簡単な方法がない。
- ✔️ **Azure Pipeline**: シークレットアクセスで[フォークPRトリガーをサポート](https://learn.microsoft.com/en-us/azure/devops/pipelines/repos/github?view=azure-devops&tabs=yaml#contributions-from-forks)するが、組み込みのセキュリティパターンが不足。
- ❌ **Jenkins**: パブリックCIには推奨されない。フォークPR処理は優先事項ではない。

### ジョブ承認

- ⚠️ **GitHub Actions**: Environment保護ルール経由で承認をサポート。制限: プライベートリポジトリの`GitHub Team`プランでは利用不可、`GitHub Enterprise`プランが必要。
- ✔️ **CircleCI**: 完全な承認サポート。
- ✔️ **Azure Pipeline**: 完全な承認サポート。
- ✔️ **Jenkins**: 完全な承認サポート。

### ジョブのシークレット設定

- ✔️ **GitHub Actions**: 自動ログマスキング付きのOrganization/Repository/Environment Secrets
- ✔️ **CircleCI**: 環境変数とContext
- ✔️ **Azure Pipeline**: 環境変数とパラメータ
- ✔️ **Jenkins**: Credential Provider

<details><summary>GitHub Actionsのシークレット詳細を表示するにはクリック</summary>

GitHub Actionsは3つのシークレットスコープをサポート:

- **Organization Secrets**: `Organization > Settings > Secrets`(リポジトリでフィルタリング可能)
- **Repository Secrets**: `Repository > Settings > Secrets`
- **Environment Secrets**: `Repository > Environment > Secrets`

**優先順位**: `Environment Secrets` > `Repository Secrets` > `Organization Secrets`

**個人アカウント**: リポジトリごとにシークレットを設定するか、[google/secrets-sync-action](https://github.com/google/secrets-sync-action)を使用。

シークレットは自動的に[ログでマスク](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#masking-a-value-in-a-log)されます。

</details>

---

## インフラストラクチャとパフォーマンス

### Git Checkout

- ✔️ **GitHub Actions**: [actions/checkout](https://github.com/actions/checkout)はすべての機能をサポート: `ssh/https`、`submodule`、`shallow-clone`(デフォルト深度1)、`sparse checkout`、`lfs`。
- ✔️ **CircleCI**: [checkout](https://circleci.com/docs/configuration-reference/#checkout)は`ssh/https`、`submodule`、`blobless clone`(2024年以降デフォルト)、`lfs`をサポート。欠落: `sparse-checkout`。`method: blobless`または`method: full`を選択可能。
- ✔️ **Azure Pipeline**: [checkout](https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/steps-checkout?view=azure-pipelines)は`ssh/https`、`submodule`、`shallow-clone`(2022年9月以降デフォルト深度1)、`lfs`をサポート。欠落: `sparse-checkout`。
- ✔️ **Jenkins**: [GitSCM](https://www.jenkins.io/doc/pipeline/steps/params/gitscm/)はすべての機能をサポート: `ssh/https`、`submodule`、`shallow-clone`、`sparse checkout`、`lfs`。デフォルト: フルクローン。

### ホストランナーのサイジング

- ✔️ **GitHub Actions**: 設定可能なサイジングと静的IPアドレスを備えた[Single-CPUランナー](https://docs.github.com/en/actions/reference/runners/github-hosted-runners#single-cpu-runners)と[より大きなランナー](https://docs.github.com/en/actions/using-github-hosted-runners/about-larger-runners/about-larger-runners)を提供。
- ✔️ **CircleCI**: 異なるランナーサイズのための[リソースクラス](https://circleci.com/docs/resource-class-overview/)を提供。
- ⚠️ **Azure Pipeline**: Microsoftホストエージェントの固定サイズ: [Standard_DS2_v2](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/hosted#hardware)(2 vCPU、7GB RAM、14GB SSD)。柔軟なサイジングには、[Managed DevOps Pools](https://learn.microsoft.com/en-us/azure/devops/managed-devops-pools/overview)またはセルフホストエージェントを使用。
- ❌ **Jenkins**: セルフホストソリューション。ホストランナーの概念は適用されない。

---

## 開発体験

### メタ値とJobId

すべてのCIはジョブメタデータと一意の識別子へのアクセスを提供:

- ✔️ **GitHub Actions**: [Context](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context)`github.run_id`または[環境変数](https://help.github.com/en/actions/configuring-and-managing-workflows/using-environment-variables#default-environment-variables)`GITHUB_RUN_ID`
- ✔️ **CircleCI**: [環境変数](https://circleci.com/docs/2.0/env-vars/#built-in-environment-variables)`CIRCLE_BUILD_NUM`、`CIRCLE_WORKFLOW_ID`
- ✔️ **Azure Pipeline**: [環境変数](https://docs.microsoft.com/ja-jp/azure/devops/pipelines/process/run-number?view=azure-devops&tabs=yaml#tokens)`BuildID`
- ✔️ **Jenkins**: [環境変数](https://wiki.jenkins.io/display/JENKINS/Building+a+software+project)`BUILD_NUMBER`

### 環境変数の設定

- ✔️ **GitHub Actions**: [`$GITHUB_ENV`](https://help.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-environment-variable)にリダイレクト: `echo "NAME=value" >> $GITHUB_ENV`
- ✔️ **CircleCI**: `$BASH_ENV`にリダイレクト: `echo "export NAME=value" >> $BASH_ENV`
- ✔️ **Azure Pipeline**: task.setvariableを使用: `echo "##vso[task.setvariable variable=NAME]VALUE"`
- ✔️ **Jenkins**: `Env.`オブジェクトを使用

### 出力の設定

専用の出力パラメータでステップ間とジョブ間で値を渡す:

- ✔️ **GitHub Actions**: [`$GITHUB_OUTPUT`](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#setting-an-output-parameter)にリダイレクト: `echo "name=value" >> "$GITHUB_OUTPUT"`。ジョブ間の受け渡しをサポート。
- ⚠️ **CircleCI**: 専用出力なし。環境変数を使用
- ✔️ **Azure Pipeline**: `isoutput=true`でtask.setvariableを使用: `echo "##vso[task.setvariable variable=NAME;isoutput=true]VALUE"`
- ⚠️ **Jenkins**: 専用出力なし。環境変数を使用

### PATH環境変数の設定

- ✔️ **GitHub Actions**: `$GITHUB_PATH`にリダイレクト: `echo "/path/to/dir" >> "$GITHUB_PATH"`
- ✔️ **CircleCI**: `$BASH_ENV`にリダイレクト: `echo "export PATH=$GOPATH/bin:$PATH" >> $BASH_ENV`
- ✔️ **Azure Pipeline**: task.setvariableを使用: `echo '##vso[task.setvariable variable=path]$(PATH):/dir/to/whatever'`
- ✔️ **Jenkins**: `Env.`オブジェクトを使用

---

# 基本 - オンボーディング

## runステップ

ステップ内でシェルコマンドを実行するために`run:`を使用できます。`run`ステートメントのヒント:

- ステップ名を説明するために`name:`を追加。
- 複数行で`run`ステートメントを書くために`run: |`を使用。
- ステップの環境変数を設定するために`env:`を使用。

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

## ifセクション

`if:`条件を使用して、`job`/`step`を実行するかどうかを制御できます。`if`ステートメントは`success()`、`failure()`、`contains()`、`startsWith()`などの[式](https://docs.github.com/ja/actions/reference/workflows-and-actions/expressions)構文を使用できます。

次の例は、ジョブレベルとステップレベルで`if`条件を使用する方法を示しています。

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

## ランナーのサイズ設定

GitHubホストランナーには3つのタイプがあります: 標準ランナー、より大きなランナー、シングルCPUランナー。

- 標準ランナーはGitHub Actionsのデフォルトランナーです。ほとんどのジョブに適しています。
- シングルCPUランナーは、複数のCPUを必要としない軽量なジョブに適しています。分単位のコストを節約できます。
- より大きなランナーは、より多くのCPUとRAMを必要とするリソース集約的なジョブに適しています。(このドキュメントの範囲外です。)
- セルフホストランナーは、独自のインフラストラクチャに設定および管理するランナーです。セルフホストランナーのハードウェアおよびソフトウェア構成をカスタマイズして、特定のニーズを満たすことができます。(このドキュメントの範囲外です。)

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

<details><summary>ランナーサイズの例を表示するにはクリック</summary>

### 標準ランナー

ほとんどのGitHub Actionsジョブは、GitHubホストランナーで実行されます。これらはGitHubが管理・維持する仮想マシン(VM)です。ジョブがトリガーされるたびに新しいVMが作成され、ジョブが実行され、その後VMは破棄されます。

ランナータイプとして`ubuntu-latest`、`windows-latest`、`macos-latest`、または`ubuntu-24.04`、`windows-2025`、`macos-26`などの特定バージョンを選択できます。[ランナーの仕様](https://docs.github.com/en/actions/reference/runners/github-hosted-runners#supported-runners-and-hardware-resources)はOSタイプやPublic/Privateリポジトリによって異なります。

また、`x64`や`arm64`などのアーキテクチャを指定することもできます。詳細は[ドキュメント](https://docs.github.com/en/actions/reference/runners/github-hosted-runners)を参照してください。例:

- Linux x86_64は`ubuntu-24.04`
- Linux ARM64は`ubuntu-24.04-arm`(Publicリポジトリのみ利用可能)
- Windows x86_64は`windows-2025`
- Windows ARM64は`windows-11-arm`(Publicリポジトリのみ利用可能)
- macOS x86_64は`macos-15-intel`
- macOS ARM64は`macos-26`

### シングルCPUランナー

複数のCPUを必要としないジョブの分単位コストを節約するために、[シングルCPUランナー](https://docs.github.com/en/actions/reference/runners/github-hosted-runners#single-cpu-runners)を使用できます。シングルCPUランナーは`ubuntu-slim`で利用可能で、タイムアウトは15分です。`ubuntu-slim`ランナーはVMではなく、1 vCPUと5 GB RAMを備えたコンテナベースのランナーです。ドキュメント生成、コードリンティング、静的解析などの軽量なジョブに適しています。

### より大きなランナー

組織ユーザー向けに、[より大きなランナー](https://docs.github.com/en/actions/how-tos/manage-runners/larger-runners)がリソース集約的なジョブに利用可能で、より高いパフォーマンスを必要とするビルドとテストジョブを実行できます。x86_64およびARMアーキテクチャ用のUbuntu、Windowsを選択できます。

`Organization > Settings > Actions > Runners > Larger runners`ページでより大きなランナーの登録を設定できます。

![](./images/settings-runners.png)

次のスクリーンショットは、デフォルトのより大きなランナータイプとその仕様を示しています。

![](./images/larger-hosted-runners-list.png)

他の仕様が必要な場合は、カスタムのより大きなランナータイプを作成できます。次のスクリーンショットは、ubuntu arm64のより大きなランナー作成例を示しています。

![](./images/larger-hosted-runners-spec.png)

指定した名前で`runs-on:`を指定することで、ワークフロー内でより大きなランナーを使用できます。

</details>

## Timeout

`jobs.<job_id>.timeout-minutes`で[ジョブタイムアウト](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idtimeout-minutes)を、`steps.timeout-minutes`で[ステップタイムアウト](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idstepstimeout-minutes)を設定できます。デフォルトのタイムアウトは360分(6時間)です。1から4320分(30日)までの値を設定できます。ビルド時間の無駄を避けるために、すべてのジョブに適切なタイムアウトを設定することをお勧めします。

次の例は、ジョブとステップにタイムアウトを設定する方法を示しています。

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

# 基本 - 基礎

## デフォルトシェル

`shell:`で`run`ステップのシェルタイプを選択できます。また、`defaults.run.shell:`で`run`ステップのデフォルトシェルタイプを設定することもできます。

[デフォルト](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#defaultsrunshell)でいくつかのシェルタイプが利用可能です。次の例は、`bash`、`pwsh`、`cmd`の設定方法を示しています。

**個人的な推奨:**

現在のAIブームを考慮すると、すべてのオペレーティングシステムでデフォルトシェルとして`bash`を使用するのが最善です。WindowsでPowerShellを使用する必要がある場合は、エンコーディングの問題を避けるため、可能な限り`pwsh`を使用することをお勧めします。

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

## コンテキストメタデータのダンプ

コンテキストを使用して、ジョブID、名前、その他のシステム情報を取得します。
スクリプト内で`github`コンテキストを直接参照できないことに注意してください。

> 参照: [Context and expression syntax for GitHub Actions \- GitHub Help](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context)

**コンテキスト値へのアクセス**

`${{ CONTEXT_NAME.FIELD }}`でコンテキスト値を取得できます。例: `${{ github.repository }}`

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
    - cron: "0 0 * * 1"
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

**JSONとしてのコンテキスト**

コンテキスト値をJSONで表示するには、`toJson(<CONTEXT>)`を使用します。

```yaml
# .github/workflows/dump-context.yaml

name: dump context
on:
  issues:
    types: [opened, transferred, closed]
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
  release:
    types: [created, published]
  schedule:
    - cron: "0 0 * * 1"
  workflow_dispatch:

jobs:
  dump:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

**環境変数**

環境変数`GITHUB_EVENT_PATH`からGitHub Eventコンテキストを取得できます。

## スクリプト内の環境変数

[次のステップの環境変数を設定](#次のステップの環境変数を設定)では、次のステップの環境変数を設定する方法を説明しています。
この構文はスクリプト内に記述できます。`.github/scripts/setenv.sh`を見てみましょう。

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

このスクリプトをワークフローから呼び出します。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

## 実行順序

GitHub Actionsワークフローの実行順序は`ワークフロー` -> `ジョブ` -> `ステップ`です。

- ワークフローはデフォルトで並列実行されますが、`on.workflow_call`で定義された[workflow_call](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#workflow_call)イベントでワークフロー実行順序を制御できます。
- ジョブはデフォルトで並列実行されますが、`jobs.<job_id>.needs`で定義された[needs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idneeds)でジョブ実行順序を制御できます。
- ステップは各ジョブ内で順次実行されます。

### workflow_callでワークフロー実行順序を制御

ワークフローに`on.workflow_call`セクションがない場合、他のワークフローと並列実行されます。`on.workflow_call`セクションを追加すると、そのワークフローは他のワークフローから呼び出すことができます。その結果、ワークフローは呼び出し元ワークフロー -> 呼び出し先ワークフローの順序で順次実行されます。

実際のサンプルは[workflow_call](#再利用可能なワークフロー)セクションを参照してください。

> [!WARNING]
> `workflow_run`イベントを使用してワークフロー実行順序を制御することは避けることを検討してください。[公式ドキュメント](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#workflow_run)に記載されているように、`workflow_run`トリガーで信頼できないコードを実行すると、セキュリティ脆弱性につながる可能性があります。これらの脆弱性には、キャッシュポイズニングや書き込み特権またはシークレットへの意図しないアクセスの付与が含まれます。

### needsでジョブ実行順序を制御

ジョブに`needs`セクションがない場合、他のジョブと並列実行されます。`needs`セクションを設定すると、そのジョブは`needs`セクションで定義された前のジョブの後に実行されます。デフォルトでは、`needs`を持つジョブは前のジョブが成功することを必要とします。

次の例のフローでは、`job2`は`job1`が成功した後に実行され、`job3`は`job1`と`job2`の両方が成功した後に実行されます。これは、`job1`が失敗した場合は`job2`と`job3`が実行されず、`job2`が失敗した場合は`job3`が実行されないことを意味します。その結果、ジョブは`job1` -> `job2` -> `job3`の順序で順次実行されます。

```yaml
jobs:
  job1:
  job2:
    needs: job1
  job3:
    needs: [job1, job2]
```

\u5b9f\u969b\u306e\u30b5\u30f3\u30d7\u30eb\u3092\u53c2\u7167\u3057\u3066\u304f\u3060\u3055\u3044\u3002

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

### 成功結果要件なしのジョブneeds依存関係

次の例のフローでは、ジョブ`job2`は`job1`が成功した後に実行されますが、`job3`は`always()`条件式を使用しています。そのため、`job3`は`job1`と`job2`が成功または失敗にかかわらず実行されます。`needs`セクションにより、ジョブは`job1` -> `job2` -> `job3`の順序で順次実行されます。

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

### \u30b8\u30e7\u30d6needs\u3068\u30b9\u30ad\u30c3\u30d7\u51e6\u7406\n\n\u6b21\u306e\u4f8b\u306f\u3001`needs`\u30bb\u30af\u30b7\u30e7\u30f3\u3067\u30b8\u30e7\u30d6\u30b9\u30ad\u30c3\u30d7\u3092\u51e6\u7406\u3059\u308b\u65b9\u6cd5\u3092\u793a\u3057\u3066\u3044\u307e\u3059\u3002\u30b8\u30e7\u30d6`needs`\u306f\u30b9\u30ad\u30c3\u30d7\u51e6\u7406\u306b\u4f7f\u7528\u3067\u304d\u307e\u3059\u3002\u3057\u304b\u3057\u3001\u4f9d\u5b58\u30b8\u30e7\u30d6\u3092\u30b9\u30ad\u30c3\u30d7\u3059\u308b\u3068\u3001\u6b21\u306e\u30b8\u30e7\u30d6\u306b\u554f\u984c\u304c\u767a\u751f\u3057\u307e\u3059\u3002\u6b21\u306e\u30ef\u30fc\u30af\u30d5\u30ed\u30fc\u306f\u3001`C`\u304c\u547c\u3073\u51fa\u3055\u308c\u305f\u3068\u304d\u306b`D`\u3092\u5b9f\u884c\u3059\u308b\u3053\u3068\u304c\u671f\u5f85\u3055\u308c\u3066\u3044\u307e\u3059\u3002\u3057\u304b\u3057\u3001`A`\u3068`B`\u3092\u30b9\u30ad\u30c3\u30d7\u3059\u308b\u3068`D`\u3082\u30b9\u30ad\u30c3\u30d7\u3055\u308c\u307e\u3059\u3002

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

\u4e0a\u8a18\u306e\u4f8b\u3092\u4fee\u6b63\u3057\u3001`C`\u304c\u547c\u3073\u51fa\u3055\u308c\u305f\u3068\u304d\u306b`D`\u304c\u5b9f\u884c\u3055\u308c\u308b\u3088\u3046\u306b\u3059\u308b\u306b\u306f\u3001`D`\u306b`if`\u6761\u4ef6\u3092\u8ffd\u52a0\u3059\u308b\u5fc5\u8981\u304c\u3042\u308a\u307e\u3059\u3002\u3053\u308c\u306f\u3001\u6761\u4ef6\u4ed8\u304d\u547c\u3073\u51fa\u3057\u304c\u306a\u3044\u5834\u5408\u3082\u51e6\u7406\u3059\u308b\u5fc5\u8981\u304c\u3042\u308a\u307e\u3059: `A`\u3001`B`\u3001`C`\u304c\u6210\u529f\u3057\u305f\u5834\u5408\u3001`D`\u3092\u5b9f\u884c\u3059\u308b\u5fc5\u8981\u304c\u3042\u308a\u307e\u3059\u3002

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

## ジョブ出力

ジョブ間で値を渡したい場合は、[ジョブ出力](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/pass-job-outputs)と[ジョブneeds](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idneeds)を使用できます。`jobs.<job_id>.outputs`でジョブ出力を設定し、他のジョブは`needs.<job_id>.outputs.<output_name>`でそれを参照できます。

同じジョブ内のステップ間で値を渡したい場合は、[ステップ出力](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-commands#setting-an-output-parameter)を使用できます。`steps.<step_id>.outputs`でステップ出力を設定し、他のステップは`steps.<step_id>.outputs.<output_name>`でそれを参照できます。

次の例は、`a`ジョブでジョブ出力を設定し、`b`ジョブでそれを参照する方法を示しています。

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

## 冗長制御

> [!WARNING]
> 冗長制御の代わりにワークフロー並行制御の使用を検討してください。

PRを作成すると、`push`と`pull_request/synchronize`の2つのイベントが発生します。これは、重複するビルドが開始され、ビルド時間を無駄にすることを意味します。
プライベートリポジトリを実行している場合、ビルド時間制限があるため、冗長ビルドは問題を引き起こす可能性があります。言い換えれば、リポジトリがPublicの場合はビルド時間の消費を心配する必要はありません。

### 同じリポジトリでpull_requestトリガー時のpushを回避

この例では、`push`はデフォルトブランチの`main`でのみトリガーされます。これは、`pull_request` synchronizeイベントが発生したときにpushが実行されないことを意味します。
これはほとんどのユースケースに十分簡単です。

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

### 冗長ビルドのキャンセル

重複するワークフローをキャンセルし、CIを失敗としてマークします。

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

## 前のジョブが成功したときに実行

ワークフロー内で順次ジョブ実行を実現するには、`needs:`を使用して現在のジョブが依存するジョブを指定します。

これにより、ジョブは前のジョブが**成功**した場合にのみ実行されます。

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

## 前のステップステータスが特定の場合に実行

> [job-status-check-functions /- Context and expression syntax for GitHub Actions /- GitHub Help](https://help.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#job-status-check-functions)

特定のステータスに基づいてステップを実行するように設定する場合は、`if:`を使用します。

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

Matrixは、OS、バージョンなど、異なるパラメータで同じジョブを実行したい場合に便利です。Matrixは`jobs.<job_id>.strategy.matrix`で定義します。次の例は、matrixの使用方法を示しています。

- ジョブ失敗の処理方法を制御するには、`fail-fast: false`を使用して1つのmatrixジョブが失敗しても他のmatrixジョブを続行します。
- Matrixはデフォルトでジョブを並列実行します。ただし、`max-parallel`で並列ジョブ数を制限することができます。
- MatrixはOSやバージョンなどの複数の軸を定義できます。次の例では、6個のジョブが並列実行されます(3バージョン x 2 OS)。

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

`jobs.<job_id>.strategy.matrix.include`でmatrixの組み合わせを拡張または追加できます。includeの値はオブジェクトのリストです。詳細は[リンク](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/run-job-variations#expanding-or-adding-matrix-configurations)を参照してください。

次のワークフローを作成しましょう。

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

`jobs.<job_id>.strategy.matrix.exclude`で特定のmatrixの組み合わせを除外できます。詳細は[リンク](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/run-job-variations#excluding-matrix-configurations)を参照してください。

次のワークフローを作成しましょう。

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

次のmatrixは合計3個のジョブを実行します。`manzana`と`gato`の組み合わせが除外されているためです。

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

### matrix内のシークレット参照

`strategy.matrix`セクション内で`secret`コンテキストを参照できないため、matrixでシークレットキーを渡し、`secrets[matrix.SECRET_KEY]`でシークレットを参照します。

設定でシークレットを設定してから、次のワークフローを実行しましょう。

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

### env内のMatrix参照

stepsの前にジョブの`env:`セクションでmatrixを参照できます。

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

## 手動実行のためのWorkflow dispatch

ワークフローを手動で実行したい場合は、`workflow_dispatch`イベントトリガーを使用します。

- Web UIはActionsタブに`Run workflow`ボタンを提供します。
- `gh` CLIでworkflow dispatchをトリガーできます。
- GitHub APIを使用してworkflow dispatchをトリガーできます。

### Workflow dispatchと値の渡し方

workflow dispatchを呼び出すときに値を渡すために[アクション入力](https://docs.github.com/en/actions/creating-actions/metadata-syntax-for-github-actions#inputs)を指定できます。

入力は`on.workflow_dispatch.inputs`セクションで定義されます。次の例は、入力の定義とジョブステップでの参照方法を示しています。

- `on.workflow_dispatch.inputs`: workflow dispatchを呼び出すときに渡す入力パラメータを定義します。
  - 入力パラメータは`description`、`required`、`default`、`type`プロパティを持ちます。`type`として`string`、`boolean`、`choice`、`environment`を指定できます。
- ジョブステップでは、`${{ inputs.<input_name> }}`構文で入力値を参照できます。

サポートされている入力タイプ:

- `string`: デフォルトタイプ、Web UIはテキストボックスを提供します。
- `number`: 数値、Web UIはテキストボックスを提供します。
- `boolean`: `true`または`false`、Web UIはチェックボックスを提供します。
- `choice`: 列挙オプション、Web UIは選択ボックスを提供します。`options`プロパティを定義する必要があります。
- `environment`: GitHub Environmentsの列挙、Web UIは選択ボックスを提供します。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

## リリースを作成する

`gh` CLIツールを使用してGitHubリリースを作成できます。いくつかのアクションがありますが、リリース作成は十分にシンプルなので、`gh` CLIツールを直接使用することをお勧めします。

主要なコマンドは`gh release create`と`gh release upload`です。最初にドラフトリリースを作成し、その後リリースにファイルをアップロードすることをお勧めします。すべての準備が整ったら、ドラフトリリースを公開済みに変更します。

```sh
# create draft release with auto generated notes
gh release create <TAG> --draft --verify-tag --title "Ver.<TAG>" --generate-notes

# upload files to release
gh release upload <TAG> file-1.txt file-2.txt
```

次の例は、`v1.0.0`のようなタグをプッシュしたときにトリガーされます。ワークフローは自動生成されたノートでドラフトリリースを作成し、ファイルをアップロードします。

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

## ファイル変更を検出する

GitHub Actionsのpushまたはpull_requestイベントで、どのファイルが変更されたかを検出できます。これは、`path-filter`を使用したいが、さらにファイル処理が必要な場合に便利です。次のアクションが利用可能で、同じように使用できます。

`dorny/paths-filter`は現在も活発に開発されています。ただし、その出力は非常に動的で、actionlintのような静的リンターでは扱いにくいです。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

`trilom/file-changes-action`は開発が停止したため、使用を中止しました。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

## 非デフォルトブランチでのスケジュールジョブ

スケジュールされたジョブは`デフォルトブランチの最後のコミット`を使用します。

> 参照: [Events that trigger workflows /- GitHub Help](https://help.github.com/en/actions/reference/events-that-trigger-workflows#scheduled-events-schedule)

スケジュールされたワークフローは、ワークフロー変更を適用するためにデフォルトブランチにマージされている必要があります。

非デフォルトブランチでcheckoutを実行したい場合は、ブランチ情報を渡します。
ブランチに`refs/heads/`を前置することを忘れないでください。

- 良い: refs/heads/some-branch
- 悪い: some-branch

```yaml
# .github/workflows/schedule-job.yaml

name: schedule job
on:
  schedule:
    - cron: "0 0 * * 1"

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
        with:
          ref: refs/heads/some-branch
          persist-credentials: false

```

GitHub Actionsを通じてリリースを作成し、アセットをアップロードできます。
複数のアセットアップロードは、各アセットに対して`actions/upload-release-asset`を実行することでサポートされます。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

## ブランチプッシュのみをトリガーし、タグプッシュではスキップ

ブランチへのプッシュ時のみジョブを実行し、タグプッシュでは実行したくない場合。`on.push`から`tags`セクションを削除するか、否定パターン`!*`を設定します。

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

## コミットメッセージでトリガーする

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

## タグプッシュのみをトリガーし、ブランチプッシュではスキップ

タグへのプッシュ時のみジョブを実行し、ブランチプッシュでは実行したくない場合。

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

## 特定のタグパターンでトリガーする

`on.push.tags`でパターンを使用できますが、`step.if`では使用できません。
このパターンは次のものにマッチします。

- 0.0.1
- 1.0.0+preview
- 0.0.3-20200421-preview+abcd123408534

次のものにはマッチしません。

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

## プルリクエストのラベルを検出する

`pull_request`イベントにはラベルが含まれており、それらを使用してステップの実行をフィルターできます。
`${{ contains(github.event.pull_request.labels.*.name, 'hoge') }}`は、ラベルに`hoge`が含まれていれば`true`を返します。

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

## プルリクエストのタイトルでCIをスキップする

デフォルトの`pull_request`イベントは、アクティビティタイプが`opened`、`synchronize`、または`reopened`のときにトリガーされます。

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

## フォークリポジトリからのPRをスキップ

デフォルトでは、`pull_request`イベントはフォークリポジトリからもトリガーされます。しかし、フォークPRは`secrets`を読み取ることができず、PRチェックが失敗する可能性があります。
フォークからのジョブをスキップし、自分のPRまたはpushでのみ実行するには、`if`条件を使用します。

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

## ドラフトPR時にジョブをスキップ

プルリクエストがドラフトの場合、ジョブとステップをスキップできます。
残念ながら、GitHub Webhook v3イベントはドラフトPRタイプを提供しませんが、PRがドラフトの場合、`event.pull_request.draft`が`true`を返します。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
        with:
          persist-credentials: false

```

PRラベルで動作を制御できます。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
        with:
          persist-credentials: false

```

---

# 高度な機能

高度なテクニック。

## Dependabotによる自動Actionsバージョン更新

[Dependabot](https://docs.github.com/en/code-security/dependabot/working-with-dependabot/automating-dependabot-with-github-actions)を使用してGitHub Actionsのバージョンを自動的に更新できます。Dependabotはアクションを最新の状態に保つためのプルリクエストを作成し、手動または自動でマージできます。

GitHub Actions更新のためにDependabotを有効にするには、リポジトリに`.github/dependabot.yml`を追加します。

次はサンプルdependabot.yamlファイルです。

- GitHub Actions/NuGetを毎週更新しますが、パッチバージョン更新は無視します。
- また、14日間のクールダウン期間を設定しています。これは、前回の更新PRが作成されてから14日以内に同じ依存関係に対してDependabotが新しいPRを作成しないことを意味します。これは、一時的な依存関係の脆弱性によるセキュリティリスクを軽減するのに役立ちます。

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

**dependabot.yamlのカスタマイズ**

[dependabot.yamlファイルの設定オプション](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file)がいくつかあります。

**dependabotアクションでシークレットにアクセスする**

Dependabotイベントがワークフローをトリガーすると、ワークフローで利用できるシークレットはDependabotシークレットのみです。GitHub Actionsシークレットは利用できません。

> ref: https://docs.github.com/en/code-security/dependabot/working-with-dependabot/automating-dependabot-with-github-actions#accessing-secrets

そのため、Dependabotトリガーのワークフローではシークレットを使用しないことをお勧めします。シークレットが必要な場合は、Dependabotシークレットに同じシークレット名を追加してください。

## Build Artifacts

GitHub Actionsの[actions/upload-artifact](https://github.com/actions/upload-artifact)と[actions/download-artifact](https://github.com/actions/download-artifact)は、ジョブ間での成果物の処理を提供します。GitHub Actionsで成果物をアップロードおよびダウンロードできます。

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
      - uses: actions/upload-artifact@b7c566a772e6b6bfb58ed0dc250532a479d7789f # v6.0.0
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
      - uses: actions/download-artifact@37930b1c2abaa49bbe596cd826c3c89aef350131 # v7.0.0
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
      - uses: actions/upload-artifact@b7c566a772e6b6bfb58ed0dc250532a479d7789f # v6.0.0
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
      - uses: actions/download-artifact@37930b1c2abaa49bbe596cd826c3c89aef350131 # v7.0.0
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
      - uses: actions/upload-artifact@b7c566a772e6b6bfb58ed0dc250532a479d7789f # v6.0.0
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
      - uses: actions/download-artifact@37930b1c2abaa49bbe596cd826c3c89aef350131 # v7.0.0
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

**他のワークフローまたはリポジトリ**

`actions/upload-artifact`と`actions/download-artifact`を使用することで、同じリポジトリ内または異なるリポジトリ間でアーティファクトを共有できます。同じリポジトリからダウンロードする場合は、`actions/download-artifact`に`run-id`と`github-token`を指定します。`github-token`には`${{ github.token }}`を使用できます。

異なるリポジトリからダウンロードする場合は、`actions/download-artifact`に`repository`、`run-id`、`github-token`を指定します。`github-token`には、`actions: read`スコープを持つPATまたはGitHub Appトークンを使用する必要があります。

```yaml
# .github/workflows/artifacts-other-workflow.yaml

name: artifacts (other workflow)
on:
  workflow_dispatch:
    inputs:
      workflow-name:
        description: "Workflow name to download artifacts from"
        required: true
        default: "artifacts-targz.yaml"
      run-id:
        description: "Run ID to download artifacts from (optional)"
        required: false
        default: ""

jobs:
  download-directory:
    permissions:
      contents: read
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - name: List Run Ids of specified workflow
        run: gh run list -w "${WORKFLOW_NAME}" --status completed --limit 5
        env:
          WORKFLOW_NAME: ${{ inputs.workflow-name }}
          GH_REPO: ${{ github.repository }}
          GH_TOKEN: ${{ github.token }}
      - name: Get latest Run Id of specified workflow
        if: ${{ inputs.run-id == '' }}
        id: get-run-id
        run: |
          run_id=$(gh run list -w "${WORKFLOW_NAME}" --status completed --limit 1 --json databaseId --jq ".[].databaseId")
          echo "run_id=$run_id" | tee -a "$GITHUB_OUTPUT"
        env:
          WORKFLOW_NAME: ${{ inputs.workflow-name }}
          GH_REPO: ${{ github.repository }}
          GH_TOKEN: ${{ github.token }}
      - name: Get run details
        run: gh run view "${RUN_ID}"
        env:
          RUN_ID: ${{ inputs.run-id || steps.get-run-id.outputs.run_id }}
          GH_REPO: ${{ github.repository }}
          GH_TOKEN: ${{ github.token }}
      - uses: actions/download-artifact@37930b1c2abaa49bbe596cd826c3c89aef350131 # v7.0.0
        with:
          run-id: ${{ inputs.run-id || steps.get-run-id.outputs.run_id }}
          github-token: ${{ github.token }}
      - name: ls
        run: ls -lR

```


## 並行制御

GitHub Actionsには、ワークフローまたはジョブを同時に実行しないようにする並行制御機能があります。
これにより、順次ビルドパイプラインを実現できます。

### ワークフローレベルの並行制御

ワークフロー並行制御は、ワークフローを同時に実行しないようにしたい場合に便利です。長時間実行されるワークフローがあり、一度に1回だけ実行したい場合を想像してください。

`github.head_ref`などのビルドコンテキストを使用できます。これは、コミット、ブランチ、ワークフロー、またはその他のコンテキストに基づいて並行制御できることを意味します。

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

`cancel-in-progress: true`を指定すると、並列ビルドがキャンセルされます。

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

### ジョブレベルの並行制御

ジョブ並行制御は、ジョブを同時に実行しないようにしたい場合に便利です。デプロイメントジョブがあり、一度に1回だけ実行したい場合を想像してください。

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

`cancel-in-progress: true`を指定すると、並列ビルドがキャンセルされます。

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

## コンテナジョブ

GitHub Actionsには2種類のコンテナサポートがあります。1つはJob container、もう1つはService containerです。

**Job container**

GitHub Actionsは`ubuntu-latest`、`windows-latest`、`macos-latest`などの選択されたOSランナー上で実行されます。しかし、特定のコンテナイメージでジョブを実行したい場合があります。GitHub Actionsは`jobs.<job_id>.container`オプションでコンテナ上でのジョブ実行をサポートしています。次の例は、`golang:1.25`コンテナでジョブを実行し、Goプログラムを実行する方法を示しています。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
        with:
          persist-credentials: false
      - uses: actions/setup-go@7a3fe6cf4cb3a834922a1244abfce67bcef6a0c5 # v6.2.0
        with:
          go-version: "1.25"
      - name: Show Go version
        run: go version
      - name: Run Go program
        run: go run main.go
        working-directory: ./src/go-db

```

## Custom actions

カスタムアクションには2種類あります。Composite actionsとJavaScript actionsです。どちらも再利用可能なアクションロジックを作成するのに便利です。ワークフローロジックを再利用したい場合は、[Reusable workflow](#reusable-workflow)機能も使用できます。

- シェルコマンドを実行したいだけなら、Composite actionsが最も簡単な方法です。
- Node.jsで複雑なロジックを書きたい場合は、JavaScript actionsが適しています。

### Composite Actions

[Composite action](https://docs.github.com/en/actions/tutorials/create-actions/create-a-composite-action)は、複数のステップを1つのアクションで実行する一種のメタアクションです。Composite actionsではシェルスクリプトのステップを書くことができます。Composite actionsを作成するには、次の手順に従います。

アクションのyamlを`.github/actions/<ACTION_NAME>/action.yaml`に配置します。

```sh
$ mkdir -p .github/actions/composite-actions
$ cd .github/actions/composite-actions
$ touch action.yaml
```

action.yamlにComposite actionsを書きます。

- `inputs`: Composite actionsへの入力パラメーターを定義します。`type:`フィールドは使用できず、すべての入力は文字列型です。アクション入力を指定しても、入力値は通常のように環境変数`INPUT_{INPUTS_ID}`として格納されません。
- `outputs`: Composite actionsからの出力パラメーターを定義します。
- `runs.using: "composite"`: これがComposite actionを定義するためのキーポイントです。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

[JavaScript action](https://docs.github.com/en/actions/tutorials/create-actions/create-a-javascript-action)はNode.jsで書かれたカスタムアクションです。JavaScript actionで複雑なロジックを書くことができます。JavaScript actionsを作成するには、次の手順に従います。

> [!Note]
> ほとんどの場合、JavaScript actionsはTypeScriptで書かれ、その後JavaScriptにコンパイルされ、コンパイルされたJavaScriptファイルを`dist/`フォルダーに配置します。次の例では、簡略化のためにプレーンなJavaScriptを使用します。

アクションyamlを`.github/actions/<ACTION_NAME>/action.yaml`に、メインJavaScriptファイル`dist/index.js`を同じフォルダーに配置します。

```sh
$ mkdir -p .github/actions/javascript-actions
$ cd .github/actions/javascript-actions
$ touch action.yaml
$ touch dist/index.js
```

action.yamlにJavaScript actionsの定義を書きます。

- `inputs`: JavaScript actionsへの入力パラメーターを定義します。
- `outputs`: JavaScript actionsからの出力パラメーターを定義します。
- `runs.using: "node20"`: これがJavaScript actionを定義するためのキーポイントです。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

### ステップ間のデータ受け渡し

同じジョブ内のステップ間でデータを渡す方法はいくつかあります。

- step outputs
- environment variables
- files

### ジョブ間のデータ受け渡し

ジョブ間でデータを渡す方法はいくつかあります。

- job outputs and needs
- artifacts (files)


## 他のリポジトリのワークフローをディスパッチする

GitHubの`workflow_dispatch`イベントAPIを呼び出すことで、このリポジトリを他のリポジトリにディスパッチできます。
もはや`repository_dispatch`イベントAPIを使用する必要はありません。

**ターゲットリポジトリのワークフロー**

ターゲットリポジトリ`testtest`のワークフロー`test.yaml`です。

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

**ディスパッチャーワークフロー**

このリポジトリは[Workflow Dispatch Action](https://github.com/marketplace/actions/workflow-dispatch)アクションでイベントをディスパッチします。

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

## フォークユーザーのワークフロー変更防止

GitHubの脆弱性の1つはワークフローです。`secrets`を使用してワークフローでサービスを認証する場合、ワークフローの編集は要件とする必要があります。

最も簡単な方法は、`pull_request`ターゲットとパスフィルタを使用し、PRがフォークかどうかを検出することです。ファイル変更を防ぐ方法はいくつかあるかもしれません。`xalvarez/prevent-file-change-action`はステップ内で変更をガードできます。`dorny/paths-filter`またはその他を使用すると、変更を検出して希望する操作を実行する柔軟な方法となります。

> [!Warning]
> [セキュリティ脆弱性](https://www.stepsecurity.io/blog/harden-runner-detection-tj-actions-changed-files-action-is-compromised)への対応として`tj-actions/changed-files`の使用を中止してください

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

## git checkoutの高速化

[actions/checkout](https://github.com/actions)は[shallow-clone](https://git-scm.com/docs/shallow)と[sparse checkout](https://git-scm.com/docs/git-sparse-checkout)の両方をサポートしており、モノレポジトリに非常に便利です。通常、モノレポジトリには大量のファイルとフォルダが含まれているため、通常のgit clone/checkoutは長時間と大きなディスク容量を必要とする可能性があります。git checkoutを高速化したい場合は、`shallow-clone`と`sparse checkout`の両方を有効にしてください。

- `shallow-clone` (デフォルトで有効): コミット履歴の深さを制限することで、より高速なクローンを提供します。
- `sparse checkout` (2023年6月以降追加): チェックアウトするファイルとフォルダを制限することで、より高速なチェックアウトを提供します。

<details><summary>Click to show explanation of shallow clone and sparse checkout</summary>

**Shallow cloneとは**

Shallow cloneは`git clone`で`--depth=<N>`パラメーターを使用してコミット履歴を切り詰めます。通常、--depth=1は最新のコミットのみを気にすることを意味します。これにより、取得する必要があるデータの量が大幅に減少し、クローンが高速化され、shallow履歴のストレージが少なくなります。

![Shallow clone](./images/shallow-clone.png)

> ref: https://github.blog/2020-12-21-get-up-to-speed-with-partial-clone-and-shallow-clone/

**Sparse checkoutとは**

Sparse checkoutは`git clone`の前に`git sparse-checkout set <PATH>`を使用して、チェックアウトするファイルとフォルダーを制限します。これにより、取得する必要があるデータの量が大幅に減少し、チェックアウトが高速化され、制限されたパスのストレージが少なくなります。

![Sparse checkout](./images/sparse-checkout.png)

> ref: https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/

Sparse checkoutには2つのモードがあります。`git sparse-checkout`と`git sparse-checkout --cone`です。`sparse-checkout-cone-mode`オプションで`cone`を指定するかしないかを選択できます。では、`cone`と`cone`ではない場合の違いは何でしょうか? 通常、`sparse-checkout-cone-mode: true`は`sparse-checkout-cone-mode: false`よりも高速です。しかし、`cone`モードにはいくつかの制限があり、特定のフォルダーを除外することができません。そのため、どちらのモードが良いか選択する必要があります。

- `sparse checkout: src` & `sparse-checkout-cone-mode: true`、`src`フォルダーとルートファイルをチェックアウト。
- `sparse checkout: src/*` & `sparse-checkout-cone-mode: false`、`src`フォルダーのみをチェックアウト。
- `sparse checkout: !src` & `sparse-checkout-cone-mode: true`、フォルダー除外では`sparse-checkout-cone-mode: true`を使用できません。
- `sparse checkout: !src/*` & `sparse-checkout-cone-mode: false`、`src`フォルダーをチェックアウトから除外できますが、チェックアウトしたいフォルダーを指定する必要があります。

</details>

### Sparse checkout

Sparse checkoutを使用するには、`actions/checkout`アクションに`sparse-checkout`オプションを指定するだけです。次の例は`src/`フォルダーとルートファイルのみをチェックアウトします。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

### Sparse checkoutでチェックアウトするファイルを指定する

Sparse checkoutを使用して、チェックアウトするファイル/フォルダーを指定するには、`actions/checkout`アクションに`sparse-checkout`オプションを指定するだけです。次の例は`src/*`フォルダーのみをチェックアウトします。`!`除外パターンを使用するために`sparse-checkout-cone-mode: false`でconeモードを無効化します。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

結果、選択された`src`フォルダーとルートファイルがチェックアウトされます。

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

### Sparse checkoutでパスを除外する

Sparse checkoutを使用して、チェックアウトから特定のファイル/フォルダーを除外するには、`actions/checkout`アクションに`sparse-checkout`オプションを指定するだけです。次の例は`src/*`フォルダーを除外します。`!`除外パターンを使用するために`sparse-checkout-cone-mode: false`でconeモードを無効化します。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

結果、`src`フォルダーが除外され、それ以外のすべてのファイルがチェックアウトされます。

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

ジョブサマリーを追加したい場合は、[GITHUB_STEP_SUMMARY](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#adding-a-job-summary)を使用します。ジョブサマリーは、ジョブが終了した後に重要な情報を表示するのに便利です。ジョブページの下部でJob Summaryを見ることができます。

```yaml
# .github/workflows/github-step-summary.yaml

name: gitHub step summary
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

2つの選択肢があります:

1. Git CLIを使用して、マージコミットの1行目と3行目を取得する。
2. アクションを使用してマージコミットからPR情報を取得する。

以下は[jwalton/gh-find-current-pr](https://github.com/jwalton/gh-find-current-pr)を使用してマージコミットからPR情報を取得します。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

GitHub Actionsでは、複数のワークフローやリポジトリ間で共通のワークフローロジックを共有するために[Reusable workflows](https://docs.github.com/en/actions/how-tos/reuse-automations/reuse-workflows)を作成できます。同じリポジトリからのローカルワークフロー、パブリックリポジトリのワークフロー、または同じOrganizationからのプライベートリポジトリのワークフローを呼び出すことができます。Reusable workflowを作成するには、次の手順に従います。

### 制限事項

Reusable workflowsを呼び出す場合、いくつかの制限があります:

1. プライベートリポジトリは同じリポジトリのReusable workflowを呼び出せますが、他のプライベートリポジトリのワークフローは呼び出せません。
2. 呼び出し元は`with`入力に${{ env.FOO }}を使用できません。

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

3. 呼び出されるワークフローは`.github/workflows/`に配置する必要があります。そうでない場合、呼び出し元はパブリックワークフローを呼び出していると見なされます。

   ```bash
   $ ls -l ./.github/workflows/
   ```

4. 呼び出される側は呼び出し元の環境変数を参照できません。

   ```yaml
   env:
     FOO: foo # Reusable workflow callee cannot refer this env.
   jobs:
     bad:
       runs-on: ubuntu-latest
       steps:
         uses: ./.github/workflows/dummy.yaml
   ```

### Reusable workflowの基本

Reusable workflowのyamlファイルを`.github/workflows/<WORKFLOW_NAME>.yaml`に配置します。

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

name: (R) reusable workflow called
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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

### 同じリポジトリで再利用可能なワークフローを呼び出す

同じリポジトリで再利用可能なワークフローを呼び出すには、`uses: ./.github/workflows/xxxx.yaml`を使用します。

> [!TIP]
> workflow_dispatchからworkflow_callに`boolean`タイプの入力を渡したい場合は、`fromJson(inputs.YOUR_BOOLEAN_PARAMETER)`を使用します。
詳細は[fromJsonによる型変換](#fromJsonによる型変換)を参照してください。

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

### パブリックリポジトリで再利用可能なワークフローを呼び出す

パブリックリポジトリで再利用可能なワークフローを呼び出すには、`uses: GITHUB_OWNER/REPOSITORY/.github/workflows/xxxx.yaml@<ref>`を使用します。

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

### ネストされた再利用可能なワークフロー

再利用可能なワークフローはネスト呼び出しをサポートします。呼び出されたワークフローは別の再利用可能なワークフローを呼び出すことができます。

```yaml
# .github/workflows/_reusable-workflow-nest.yaml

name: (R) reusable workflow nest
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

## ワークフローコマンド

GitHub Actionsはワークフローランナーと対話するための[ワークフローコマンド](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-commands)をサポートしています。ワークフローコマンドを使用して、出力パラメータを設定したり、出力ログにデバッグメッセージを追加したり、その他のタスクを実行できます。

ほとんどのワークフローコマンドは特定の形式でechoコマンドを使用し、その他はファイルに書き込むことで呼び出されます。

```sh
echo "::workflow-command parameter1={data},parameter2={data}::{command value}"
```

GitHub Actionsを作成するためにJavaScriptまたはTypeScriptを使用している場合は、[@actions/core](https://github.com/actions/toolkit)を使用できます。

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

## YAMLアンカー

> [!WARNING]
> 複雑なアンカー構造の使用はお勧めしません。yamlが読みにくくなる可能性があるためです。代わりに、再利用可能なワークフロー、Composite Actions、JavaScript Actionsを使用して共通ロジックを共有してください。

GitHub Actionsワークフローyamlで重複を減らすために[YAMLアンカー](https://docs.github.com/ja/actions/reference/workflows-and-actions/reusing-workflow-configurations#yaml-anchors-and-aliases)を使用できます。`&anchor_name`でアンカーを定義し、`*anchor_name`でアンカーを参照します。YAMLマージキー`<<: *anchor_name`はまだサポートされていないことに注意してください。

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

`actions/checkout`を使用すると、デフォルトではチェックアウト後にgitリモートURLをトークン認証付きで保持します。これは通常の場合には必要なく、セキュリティ上の問題を引き起こす可能性があります。そのため、`persist-credentials: false`を設定して無効化する必要があります。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

## Personal Access Tokenの代わりにGitHub App Token

GitHub Actionsは組み込みトークン`GITHUB_TOKEN`を提供しており、ほとんどのアクションはPersonal Access Token (PAT)の代わりにこれを使用できます。しかし、特定のリソースにアクセスするためにPATが必要なアクションもあります。そのような場合、より優れたセキュリティのためにPATの代わりにGitHub App Tokenの使用を検討してください。組み込みの`GITHUB_TOKEN`の代わりにGitHub App Tokenが必要な状況は次のとおりです。

- プルリクエスト作成時にワークフローをトリガーする。(組み込みトークンで作成されたPRはワークフローをトリガーしない)
- 同じorganization/ownerであっても別のプライベートリポジトリにアクセスする。

GitHub Appの作成方法とGitHub Appでの認証方法については[公式手順](https://docs.github.com/en/enterprise-cloud@latest/apps/creating-github-apps/authenticating-with-a-github-app/making-authenticated-api-requests-with-a-github-app-in-a-github-actions-workflow)を参照してください。

次の例は、[actions/create-github-app-token](https://github.com/actions/create-github-app-token)アクションを介してGitHub App Tokenを使用しています。

```yaml
# .github/workflows/github-app-token.yaml

name: github app token
on:
  pull_request:
    branches: [main]
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  app-token:
    if: ${{ github.actor == github.repository_owner }} # because referencing secrets, restrict to owner.
    permissions:
      contents: read # no pull request permission
    runs-on: ubuntu-24.04
    timeout-minutes: 3
    steps:
      - uses: actions/create-github-app-token@29824e69f54612133e76f7eaac726eef6c875baf # v2.2.1
        id: app-token
        with:
          app-id: ${{ secrets.SYNCED_ACTIONS_BOT_APPID }}
          private-key: ${{ secrets.SYNCED_ACTIONS_BOT_PRIVATE_KEY }}
          permission-pull-requests: read # grant read access to pull requests
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
        with:
          persist-credentials: false
      - name: List open PRs
        run: gh pr list --state open --limit 5
        env:
          GH_TOKEN: ${{ steps.app-token.outputs.token }} # GitHub App token permission to read pull requests
          GH_REPO: ${{ github.repository }}

```

## コンテキスト経由のインジェクション攻撃

信頼できないデータが使用される場合、GitHub Actionsコンテキストはインジェクション攻撃に脆弱になる可能性があります。たとえば、シェルコマンドで`${{ github.event.head_commit.message }}`を直接使用する場合、攻撃者はシェルコマンドを含むコミットメッセージを作成し、任意のコード実行につながる可能性があります。

このリスクを軽減するために、信頼できないデータをシェルコマンドまたはスクリプトに直接埋め込まないようにしてください。代わりに、[中間環境変数を使用](https://docs.github.com/en/actions/reference/security/secure-use#use-an-action-instead-of-an-inline-script)してください。

[ghalint](https://github.com/suzuki-shunsuke/ghalint)、[zizmor](https://github.com/woodruffw/zizmor)などでコンテキスト経由の潜在的なインジェクション攻撃を検出できます。詳細は[GitHub Actionsワークフローのリント](#github-actionsワークフローのリント)を参照してください。

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

## ワークフロー内のアクションを最新に保つ

[Dependabot](https://docs.github.com/en/actions/reference/security/secure-use#using-dependabot-version-updates-to-keep-actions-up-to-date)またはRenovateは、ワークフローで使用されているGitHub Actionsの更新を自動的にチェックできます。GitHub ActionsのDependabotを有効にするには、`.github/dependabot.yaml`ファイルを作成します。

GitHub ActionsのDependabotを設定するためのティップス:

- `cooldown.default-days: 14`のようなクールダウン期間を使用して、新バージョンがリリースされた直後の更新を避けます。これにより、新バージョンの問題を監視する時間が得られます。
- `ignore.dependency-name[].update-types`を使用して、適用する更新の種類を制御します(例: パッチバージョン更新を避けたい場合は`version-update:semver-patch`)。

## GitHub Actionsワークフローのリント

[actionlint](https://github.com/rhysd/actionlint)、[ghalint](https://github.com/suzuki-shunsuke/ghalint)、[zizmor](https://github.com/woodruffw/zizmor)を使用してGitHub Actions yamlをリントできます。自動PRレビューが必要ない場合は、スケジュールでこれらのリンターを実行すれば十分かもしれません。

リンターは以下をチェックします。

* actionlint: GitHub Actionsワークフローyamlの構文と構造をチェック。
* ghalint: actions/checkoutが`persist-credentials: false`を設定しているか、再利用可能なワークフローの`secrets: inherit`をチェック。
* zizmor: GitHub Actionのセキュリティ脆弱性をチェック。

> ティップス: Aquaの使用方法については[AquaでのGitHub Actionsツール管理](#aquaでのgithub-actionsツール管理)を参照してください。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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
        run: docker run -t --env "GH_TOKEN=${GH_TOKEN}" -v .:/github ghcr.io/zizmorcore/zizmor:1.18.0 /github --min-severity medium --format github
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}

```

## 外部プロバイダーへのアクセスのためのOIDC接続

2024年以降、多くのクラウドプロバイダーやプログラミング言語のパッケージレジストリはGitHub Actionsワークフローを認証するためにOIDC (OpenID Connect)をサポートしています。OIDCを使用すると、APIキーやトークンなどの長期間有効な資格情報をリポジトリシークレットに保存することなく、ワークフローが外部リソースに安全にアクセスできます。

GitHub ActionsワークフローでOIDCを使用するには、`permissions`に`id-token: write`を含める必要があります。各レジストリまたはクラウドプロバイダーは、OIDCトークンをリクエストするための異なるアクションと異なる`audience`値を持つ場合があります。詳細については、各プロバイダーのドキュメントを参照してください。GitHubは[OIDCドキュメント](https://docs.github.com/en/actions/concepts/security/openid-connect)も提供しています。

以下はAWSリソースにアクセスするためにOIDCを使用する例です。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

2025年に新しく作成されたリポジトリのGitHub Actionsトークン`github.token`の権限は、デフォルトで`readonly`に設定されています。ただし、古いリポジトリを所有している場合、アクショントークンはまだ`write`権限を持っている可能性があります。セキュリティを強化するため、各ワークフローに必要な最小限の権限を明示的に設定することをお勧めします。リポジトリのデフォルト権限は、リポジトリ設定の「Actions」>「General」>「Workflow permissions」で確認できます。

![](./images/workflow-permissions.png)

GitHub Actionsは、各ジョブまたはワークフローの権限を指定することをサポートしています。ワークフローレベルまたはジョブレベルで`permissions:`を設定できます。ジョブレベルの権限はワークフローレベルの権限を上書きし、`job.<job_name>.permissions`で設定できます。`permissions: {}`ですべての権限をオフにすることができます。

一般的に、書き込みアクセスを必要としないワークフローには`contents: read`権限を設定することが良い習慣です。これにより、ワークフローのセキュリティ脆弱性の潜在的な影響が最小限に抑えられます。コードをチェックアウトしてビルドするだけであれば、おそらく`contents: read`権限のみが必要です。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
        with:
          persist-credentials: false
      - uses: actions/setup-go@7a3fe6cf4cb3a834922a1244abfce67bcef6a0c5 # v6.2.0
        with:
          go-version: "1.25"
      - name: Build
        run: go build
        working-directory: ./src/go

```

次のようなワークフローレベルの権限を回避することもお勧めします。代わりに、必要に応じてジョブレベルの権限を設定します。

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

タグまたはバージョン番号の使用によりGitHub Actionsにいくつかの脆弱性が特定されています。これらのリスクを軽減するため、[常にアクションを特定のコミットSHAにピン留め](https://docs.github.com/en/actions/reference/security/secure-use#using-third-party-actions)してください。

- 特定のバージョンのアクションのコミットSHAを見つける方法はいくつかありますが、[suzuki-shunsuke/pinact](https://github.com/suzuki-shunsuke/pinact)の使用をお勧めします。
- DependabotとRenovateの両方とも、特定のコミットSHAにピン留めされていてもアクションを最新の状態に保つのに役立ちます。

<details><summary>pinactの使い方</summary>

たとえば、次のようなアクションバージョンを使用する代わりに:

```
uses: actions/checkout@v5
```

pinactを実行してコミットSHAを取得します。

```sh
$ pinact run
```

すると、アクションは次のように特定のコミットSHAにピン留めされます:

```
uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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

## Actionsランナー情報

ホストされたランナー情報を見たい場合は、以下のサンプルを参照してください。

```yaml
# .github/workflows/action-runner-info.yaml

name: action runner info
on:
  workflow_dispatch:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
  schedule:
    - cron: "0 0 * * 0"

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

## プルリクエスト(PR)がフォークかどうかを検出する

これを実現する方法はいくつかあります。最もシンプルで理解しやすいのは`fork`ブール値です。

1. `fork`ブール値を確認する。

```
# Fork
if: ${{ github.event.pull_request.head.repo.fork }}

# Not Fork
if: ${{ ! github.event.pull_request.head.repo.fork }}
```

2. `full_name`がリポジトリと一致するかを確認する。

```
# Fork
if: ${{ github.event.pull_request.head.repo.full_name != 'org/repo' }}

# Not Fork
if: ${{ github.event.pull_request.head.repo.full_name == 'org/repo' }}
```

3. ラベルがオーナーと一致するかを確認する。組織メンバーのコミットラベルはオーナーと一致します。

```
# Fork
if: ${{ ! startsWith(github.event.pull_request.head.label, format('{0}:', github.repository_owner)) }}

# Not Fork
if: ${{ startsWith(github.event.pull_request.head.label, format('{0}:', github.repository_owner)) }}
```

## ダウンロードされたリモートアクションをデバッグする

指定されたリモートアクションは`/home/runner/work/_actions/{Owner}/{Repository}/{Ref}/{RepositoryStructures}`フォルダーにダウンロードされます。フォルダーを一覧表示することで、ダウンロードされたアクションの内容を確認できます。これは、リモートアクションが内部でどのように動作するかを確認したい場合に便利です。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
        with:
          persist-credentials: false
      # wow, remote action will be download under `/home/runner/work/_actions/{Owner}/{Repository}/{Ref}/{RepositoryStructures}`
      - name: debug
        run: ls -R /home/runner/work/_actions/actions/checkout/v4
      - name: debug by workspace
        run: ls -R ${{ github.workspace }}/../../_actions/actions/checkout/v4

```

## 式での文字列連結

文字列を連結して`if`条件で使用する方法に戸惑うかもしれません。次の例は、`format()`を使用して文字列を連結し、`if`条件で使用する方法を示しています。

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


## ブランチを取得する

`github.ref`コンテキストはブランチ名を返しますが、refで直接参照するのは安全ではありません。envを通じて使用することをお勧めします。

- pull_request: `${{ github.event.pull_request.head.ref }}`
- push その他: `${{ github.ref }}`

```yaml
# .github/workflows/_reusable-dump-context.yaml#L20-L22

runs-on: ${{ matrix.runs-on }}
timeout-minutes: 5
steps:
```

## タグを取得する

タグでプッシュをトリガーする場合、2つの選択肢があります:

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

## ワークフロー名を取得する

```yaml
${{ github.workflow }}
```

## ワークフローURLを取得する

```yaml
${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}
```

## ジョブURLを取得する

```yaml
${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}/job/${{ job.check_run_id }}
```


## GitHub Actionsのコミットアイコン

GitHub Actionsアイコンとしてコミットするには、次のGit設定を使用します。

```bash
git config user.name github-actions[bot]
git config user.email 41898282+github-actions[bot]@users.noreply.github.com
```

## ダウンロードされたリモートアクションのパス

ジョブでリモートアクションまたはリモートワークフローを使用する場合、それらは`/home/runner/work/_actions/{OWNER}/{REPOSITORY}/{REF}`フォルダーにダウンロードされます。たとえば、`actions/checkout@v4`は`/home/runner/work/_actions/actions/checkout/v4`にダウンロードされます。

このパスは、アクションを超えてファイルにアクセスしたり使用したりする場合に便利です。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
        with:
          persist-credentials: false
      - name: Downloaded actions from the marketplace
        run: ls -l /home/runner/work/_actions
      - name: See actions download path
        run: ls -l /home/runner/work/_actions/actions/checkout/
      - name: See actions download contents
        run: ls -lR /home/runner/work/_actions/actions/checkout/8e8c483db84b4bee98b60c0593521ed34d9990e8
      - name: Cat action's src/main.ts
        run: cat /home/runner/work/_actions/actions/checkout/8e8c483db84b4bee98b60c0593521ed34d9990e8/src/main.ts

```

## 古いIssueとPRの自動クローズ

[actions/stale](https://github.com/actions/stale)を使用して、古いIssueとPRを自動的にクローズできます。このアクションは、一定期間活動がなかったIssueとPRを古いものとしてマークし、その後さらに一定期間が経過するとクローズします。古いIssueまたはPRに更新/コメントがあると、古いラベルが削除され、タイマーがリセットされます。

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

## GitHubワークフロー実行のテレメトリー

GitHub Actionsの[runforesight/workflow-telemetry-action](https://github.com/runforesight/workflow-telemetry-action)はワークフローのテレメトリーを提供します。テレメトリーは、どのステップが実行時間、CPU、メモリ、ネットワークI/Oを多く消費しているかを示します。デフォルト設定では、テレメトリー結果をPRコメントとJOB Summaryに投稿します。


テレメトリーを有効にするには、ジョブの最初のステップに`runforesight/workflow-telemetry-action@v1`を設定します。すると、アクションはそれ以降のステップのテレメトリーを収集します。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
        with:
          persist-credentials: false
      - uses: actions/setup-dotnet@baa11fbfe1d6520db94683bd5c7a3818018e4309 # v5.1.0
        with:
          dotnet-version: 10.0.x
      - name: dotnet build
        run: dotnet build ./src/dotnet -c Debug
      - name: dotnet test
        run: dotnet test ./src/dotnet -c Debug --logger GitHubActions --logger "console;verbosity=normal"
      - name: dotnet publish
        run: dotnet publish ./src/dotnet/ -c Debug

```

テレメトリーは[Job Summary](https://github.com/guitarrapc/githubactions-lab/actions/runs/6266182534)に投稿されます。

![GitHub Workflow Telemetry in GitHub Step Summary](./images/workflow-telemetry-action-githubstepsummary.png)

また、ワークフローが`pull_request`トリガーで実行された場合、デフォルトまたは`comment_on_pr: true`を設定することで[PRコメント](https://github.com/guitarrapc/githubactions-lab/pull/109)を有効にできます。

![GitHub Workflow Telemetry PR Comment](./images/workflow-telemetry-action-prcomment.png)

## AquaでGitHub Actionsのツール管理

[Aqua](https://aquaproj.github.io/)はツールマネージャーで、GitHub Actionsに便利です。AquaはGitHub Actionsワークフローで複数のツールをインストールおよび管理できます。Aquaは`aqua.yaml`ファイルを使用して、インストールするツールとバージョンを定義します。`aqua install`コマンドを呼び出すだけで、`aqua.yaml`に定義されたすべてのツールがインストールされるため、各ツールを1つずつインストールする必要がありません。

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
      - uses: actions/checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8 # v6.0.1
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
        run: docker run -t --env "GH_TOKEN=${GH_TOKEN}" -v .:/github ghcr.io/zizmorcore/zizmor:1.18.0 /github --min-severity medium --format github
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}

```

## fromJsonを使用した型変換

文字列を別の型に変換したい場合があります。
workflow_dispatchでブール入力`is-valid`を使用し、それをworkflow_callにブール値として渡したい場合を考えてみましょう。

`github.event.inputs`コンテキストはすべての値を`string`として扱うため、`github.event.inputs.is-valid`はもはやブール値ではありません。
`fromJson`式は、文字列からブール値に型を変換するためのトリックです。

```yaml
${{ github.event.inputs.foobar == "true" }} # true. type is string
${{ fromJson(github.event.inputs.foobar) == true }} # true. string convert to boolean
```

別の方法は、`inputs.foobar`コンテキストを使用することです。`inputs`は型情報を持ち、それをそのまま他のワークフロー呼び出しに渡します。

```yaml
${{ inputs.foobar == 'true' }} # false. type is not string
${{ inputs.foobar == true }} # true. type is boolean
```


## GitHub Actionsのスケジュールワークフロー一覧を取得したい

次のスクリプトでスケジュールされたワークフローの一覧を取得できます。[gh](https://github.com/cli/cli#installation)、[jq](https://github.com/jqlang/jq)、[yq](https://github.com/mikefarah/yq)がインストールされていることを確認してください。

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
> `on: [array]`の使用は避けてください。エラーメッセージ`jq: error (at <stdin>:87): Cannot index array with string "schedule"`が表示されます。代わりに、以下のように`on: object`を使用してください。
> ```
> on:
>   pull_request:
> ```

以下はスクリプトの実行結果です。

| Workflow | File Name | Schedule (UTC) | Last Commit by |
| ---- | ---- | ---- | ---- |
| action runner info | .github/workflows/action-runner-info.yaml | 0 0 * * 0 | guitarrapc |
| actionlint | .github/workflows/actionlint.yaml | 0 0 * * * | guitarrapc |
| auto dump context | .github/workflows/auto-dump-context.yaml | 0 0 * * 0 | guitarrapc |
| context github | .github/workflows/context-github.yaml | 0 0 * * 1 | guitarrapc |
| dotnet lint | .github/workflows/dotnet-lint.yaml | 0 1 * * 1 | guitarrapc |
| dump context | .github/workflows/dump-context.yaml | 0 0 * * 1 | guitarrapc |
| schedule job | .github/workflows/schedule-job.yaml | 0 0 * * 1 | guitarrapc |
| stale | .github/workflows/stale.yaml | 0 0 * * * | guitarrapc |
