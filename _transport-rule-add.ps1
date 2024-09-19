. "./utils/prompt.ps1"
. "./utils/connect.ps1"
. "./utils/transport-rule.ps1"

prompt -message "This script will add a transport rule to handle emails from ATTACK Simulator. A login prompt will appear shortly."
connect
addTransportRule