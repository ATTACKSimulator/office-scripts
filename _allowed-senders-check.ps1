. "./utils/prompt.ps1"
. "./utils/download.ps1"
. "./utils/connect.ps1"
. "./utils/allowed-senders.ps1"

prompt -message "This script will show all allowed sender domains from the default spam filter policy. A login prompt will appear shortly."
$emailDomains = downloadEmailDomains
$landingDomains = downloadLandingDomains

connect
checkAllowedSenders -domains ($emailDomains + $landingDomains)