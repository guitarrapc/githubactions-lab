param(
  [string]$Ref
)

echo "BRANCH_SCRIPT=$Ref" | Tee-Object -Append -FilePath $env:GITHUB_ENV
echo "branch=$Ref" | Tee-Object -Append -FilePath $env:GITHUB_OUTPUT
