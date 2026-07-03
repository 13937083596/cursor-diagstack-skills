# Install DiagStack Cursor skills to user global skills folder.
param(
    [string]$TargetRoot = "$env:USERPROFILE\.cursor\skills"
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path $PSScriptRoot -Parent
$SkillSrc = Join-Path $RepoRoot "skills\diagstack-c-comment-style"
$SkillDst = Join-Path $TargetRoot "diagstack-c-comment-style"

if (-not (Test-Path $SkillSrc)) {
    Write-Error "Skill source not found: $SkillSrc"
}

New-Item -ItemType Directory -Force -Path $TargetRoot | Out-Null
if (Test-Path $SkillDst) {
    Remove-Item -Recurse -Force $SkillDst
}
Copy-Item -Recurse -Force $SkillSrc $SkillDst

Write-Host "Installed: $SkillDst"
Write-Host "Restart Cursor or start a new chat to use diagstack-c-comment-style."
