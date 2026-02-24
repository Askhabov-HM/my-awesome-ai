param(
  [Parameter(Mandatory = $true)]
  [string]$Version,

  [string]$Remote = "origin",
  [string]$Branch = "master"
)

$ErrorActionPreference = "Stop"

function Run-Git {
  param([string[]]$Args)
  & git @Args
  if ($LASTEXITCODE -ne 0) {
    throw "git $($Args -join ' ') failed"
  }
}

$repoRoot = (& git rev-parse --show-toplevel 2>$null)
if (-not $repoRoot) {
  throw "Current directory is not a git repository. Run this script from inside my-awesome-ai."
}

Set-Location $repoRoot

if ($Version -notmatch '^[0-9]+\.[0-9]+\.[0-9]+$') {
  throw "Version must be SemVer-like: X.Y.Z"
}

$tag = "v$Version"
$existingTag = (& git tag --list $tag)
if ($existingTag) {
  throw "Tag $tag already exists"
}

$status = (& git status --porcelain)
if (-not $status) {
  throw "No changes to release. Working tree is clean."
}

$lastSubject = (& git log -n 1 --pretty=%s)
$nextNumber = 1
if ($lastSubject -match '^#(\d+)') {
  $nextNumber = [int]$Matches[1] + 1
}

$commitSubject = "#$nextNumber chore(release): prepare $tag"

Run-Git @("add", "-A")
Run-Git @("commit", "-m", $commitSubject, "-m", "- bundle release changes for $tag")
Run-Git @("tag", "-a", $tag, "-m", "Release $tag")
Run-Git @("push", $Remote, $Branch)
Run-Git @("push", $Remote, $tag)

Write-Output "Release completed:"
Write-Output "- Commit: $commitSubject"
Write-Output "- Tag: $tag"
Write-Output "- Remote: $Remote/$Branch"
