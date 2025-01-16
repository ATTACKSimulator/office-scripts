. "./utils/prompt.ps1"
. "./utils/data.ps1"
. "./utils/connect.ps1"
. "./utils/allowed-senders.ps1"

prompt -message "This script will show all allowed sender domains from the default spam filter policy. A login prompt will appear shortly."

$emailDomains = emailDomains
$landingDomains = landingDomains

connect
checkAllowedSenders -domains ($emailDomains + $landingDomains)