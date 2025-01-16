. "./utils/prompt.ps1"
. "./utils/connect.ps1"
. "./utils/transport-rule.ps1"

prompt -message "This script will remove the transport rule for ATTACK Simulator. A login prompt will appear shortly."
connect

removeTransportRule