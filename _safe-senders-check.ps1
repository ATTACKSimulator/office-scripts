. "./utils/prompt.ps1"
. "./utils/connect.ps1"
. "./utils/safe-senders.ps1"

prompt -message "This script will check an account's safe senders. A login prompt will appear shortly."
connect

checkSafeSenders