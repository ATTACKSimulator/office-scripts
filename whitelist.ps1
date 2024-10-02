. "./utils/prompt.ps1"
. "./utils/download.ps1"
. "./utils/connect.ps1"
. "./utils/allowed-senders.ps1"
. "./utils/transport-rule.ps1"
. "./utils/safe-senders.ps1"
. "./utils/defender.ps1"

prompt -message "This script will whitelist ATTACK Simulator in Office 365. This script combines the following scripts: _transport-rule-add.ps1, _safe-senders-add.ps1, and _allowed-senders-add.ps1. A login prompt will appear shortly."

$ips = downloadIps
$emailDomains = downloadEmailDomains
$landingDomains = downloadLandingDomains

connect

try {
    addAllowedSenders -domains ($emailDomains + $landingDomains)
    addTransportRule
    addSafeSenders -domains ($emailDomains + $landingDomains)
    addDefender -ips $ips -emailDomains $emailDomains -landingDomains $landingDomains
} catch {
    Write-Host $_ -ForegroundColor red
    # show the file path and line number where the error occurred
    Write-Host $_.InvocationInfo.PositionMessage -ForegroundColor red
    Write-Host "An error occurred. Please try again." -ForegroundColor red
}