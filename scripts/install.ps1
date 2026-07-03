# Install all Cursor skills from this repo to user global skills folder.
param(
    [string]$TargetRoot = "$env:USERPROFILE\.cursor\skills"
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path $PSScriptRoot -Parent
$SkillsSrc = Join-Path $RepoRoot "skills"

if (-not (Test-Path $SkillsSrc)) {
    Write-Error "Skills source not found: $SkillsSrc"
}

New-Item -ItemType Directory -Force -Path $TargetRoot | Out-Null

$installed = @()
Get-ChildItem -Path $SkillsSrc -Directory | ForEach-Object {
    $skillDst = Join-Path $TargetRoot $_.Name
    if (Test-Path $skillDst) {
        Remove-Item -Recurse -Force $skillDst
    }
    Copy-Item -Recurse -Force $_.FullName $skillDst
    $installed += $_.Name
}

Write-Host "Installed skills to ${TargetRoot}:"
foreach ($name in $installed) {
    Write-Host "  - $name"
}
Write-Host "Restart Cursor or start a new chat to use installed skills."
