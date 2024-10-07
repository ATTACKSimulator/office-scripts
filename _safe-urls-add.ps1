. "./utils/prompt.ps1"
. "./utils/download.ps1"
. "./utils/connect.ps1"
. "./utils/safe-urls.ps1"

prompt -message "This script will add ATTACK Simulator domains to the safe urls list. A login prompt will appear shortly."
connect
$landingDomains = downloadLandingDomains

addSafeUrls -urls $landingDomains

Write-Host "Done. Please wait 10 minutes for settings to be propagated." -ForegroundColor green