. "./utils/prompt.ps1"
. "./utils/download.ps1"
. "./utils/connect.ps1"
. "./utils/safe-senders.ps1"

prompt -message "This script will add ATTACK Simulator domains to the safe senders list. A login prompt will appear shortly."
connect
$emailDomains = downloadEmailDomains
$landingDomains = downloadLandingDomains

addSafeSenders -domains ($emailDomains + $landingDomains)