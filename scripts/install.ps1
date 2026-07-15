# Install DiagStack Cursor skills (dsc-a, dsc-b) to user global skills folder.
param(
    [string]$TargetRoot = "$env:USERPROFILE\.cursor\skills"
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path $PSScriptRoot -Parent

function Install-Skill([string]$Name) {
    $SkillSrc = Join-Path $RepoRoot "skills\$Name"
    $SkillDst = Join-Path $TargetRoot $Name
    if (-not (Test-Path $SkillSrc)) {
        Write-Error "Skill source not found: $SkillSrc"
    }
    if (Test-Path $SkillDst) {
        Remove-Item -Recurse -Force $SkillDst
    }
    Copy-Item -Recurse -Force $SkillSrc $SkillDst
    Write-Host "Installed: $SkillDst"
}

New-Item -ItemType Directory -Force -Path $TargetRoot | Out-Null
Install-Skill "dsc-a"
Install-Skill "dsc-b"

$Legacy = Join-Path $TargetRoot "diagstack-c-comment-style"
if (Test-Path $Legacy) {
    Remove-Item -Recurse -Force $Legacy
    Write-Host "Removed legacy: $Legacy"
}

Write-Host "Restart Cursor or start a new chat."
Write-Host "Call short names: dsc-a (comments only) | dsc-b (comments + MISRA)"
