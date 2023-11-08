param(
  [string]$Ref
)

echo "GIT_TAG_SCRIPT=$($Ref -replace 'refs/heads/','')" >> $env:GITHUB_ENV
echo "git-tag=$($Ref -replace 'refs/heads/','')" >> $env:GITHUB_OUTPUT
