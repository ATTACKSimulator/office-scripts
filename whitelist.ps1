. "./utils/prompt.ps1"
. "./utils/download-domains.ps1"
. "./utils/connect.ps1"
. "./utils/allowed-senders.ps1"
. "./utils/transport-rule.ps1"
. "./utils/safe-senders.ps1"

prompt -message "This script will whitelist ATTACK Simulator in Office 365. This script combines the following scripts: _transport-rule-add.ps1, _safe-senders-add.ps1, and _allowed-senders-add.ps1. A login prompt will appear shortly."
$domains = downloadDomains
connect

addAllowedSenders -domains $domains
addTransportRule
addSafeSenders -domains $domains