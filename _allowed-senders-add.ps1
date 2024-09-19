. "./utils/prompt.ps1"
. "./utils/download-domains.ps1"
. "./utils/connect.ps1"
. "./utils/allowed-senders.ps1"

prompt -message "This script will add ATTACK Simulator domains to the default spam filter policy. A login prompt will appear shortly."
$domains = downloadDomains
connect
addAllowedSenders -domains $domains