. "./utils/prompt.ps1"
. "./utils/download.ps1"
. "./utils/connect.ps1"
. "./utils/allowed-senders.ps1"

prompt -message "This script will add ATTACK Simulator domains to the default spam filter policy. A login prompt will appear shortly."
$emailDomains = downloadEmailDomains
$landingDomains = downloadLandingDomains

connect
addAllowedSenders -domains ($emailDomains + $landingDomains)