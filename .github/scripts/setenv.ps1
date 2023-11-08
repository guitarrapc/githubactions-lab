param(
  [string]$Ref
)

echo "BRANCH_SCRIPT=$($Ref -replace '.*/','')" >> $env:GITHUB_ENV
echo "branch=$($Ref -replace '.*/','')" >> $env:GITHUB_OUTPUT
