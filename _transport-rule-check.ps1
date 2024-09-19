. "./utils/prompt.ps1"
. "./utils/connect.ps1"
. "./utils/transport-rule.ps1"

prompt -message "This script will check if the transport rule for ATTACK Simulator exists. A login prompt will appear shortly."
connect
checkTransportRule