. "./utils/prompt.ps1"
. "./utils/download.ps1"
. "./utils/data.ps1"
. "./utils/connect.ps1"
. "./utils/prompt.ps1"
. "./utils/review.ps1"
. "./utils/allowed-senders.ps1"
. "./utils/transport-rule.ps1"
. "./utils/safe-senders.ps1"
. "./utils/safe-urls.ps1"
. "./utils/defender.ps1"

prompt -message "This script will whitelist ATTACK Simulator in Office 365. This script combines the following scripts: _transport-rule-add.ps1, _safe-senders-add.ps1, _safe-urls-add.ps1, _allowed-senders-add.ps1 and _defender-add.ps1. A login prompt will appear shortly."

$ips = downloadIps
$emailDomains = emailDomains
$landingDomains = landingDomains

review -emailDomains $emailDomains -landingDomains $landingDomains -ips $ips

connect

try {
    addAllowedSenders -domains ($emailDomains + $landingDomains)
    addTransportRule
    addSafeSenders -domains ($emailDomains + $landingDomains)
    addSafeUrls -urls $landingDomains
    addDefender -ips $ips -emailDomains $emailDomains -landingDomains $landingDomains

    Write-Host "Done. Please wait 10 minutes for settings to be propagated." -ForegroundColor green
} catch {
    Write-Host $_ -ForegroundColor red
    # show the file path and line number where the error occurred
    Write-Host $_.InvocationInfo.PositionMessage -ForegroundColor red
    Write-Host "An error occurred. Please try again." -ForegroundColor red
}

