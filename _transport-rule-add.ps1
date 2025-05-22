. "./utils/prompt.ps1"
. "./utils/connect.ps1"
. "./utils/download.ps1"
. "./utils/transport-rule.ps1"

$ips = downloadIps

prompt -message "This script will add a transport rule to handle emails from ATTACK Simulator. A login prompt will appear shortly."
connect

addTransportRule -ips $ips