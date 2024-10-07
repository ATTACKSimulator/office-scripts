. "./utils/prompt.ps1"
. "./utils/download.ps1"
. "./utils/connect.ps1"
. "./utils/safe-urls.ps1"

prompt -message "This script will remove ATTACK Simulator domains to the safe urls list. A login prompt will appear shortly."
connect
$landingDomains = downloadLandingDomains

removeSafeUrls -urls $landingDomains
