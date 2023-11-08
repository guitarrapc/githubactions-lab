param(
  [string]$Ref
)

echo "BRANCH_SCRIPT=$Ref" >> $env:GITHUB_ENV
echo "branch=$Ref" >> $env:GITHUB_OUTPUT
