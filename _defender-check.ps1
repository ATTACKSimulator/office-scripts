. "./utils/prompt.ps1"
. "./utils/download.ps1"
. "./utils/connect.ps1"
. "./utils/defender.ps1"

prompt -message "This script will add ATTACK Simulator settings from Microsoft 365 Defender. A login prompt will appear shortly."
connect 

$ips = downloadIps
$emailDomains = downloadEmailDomains
$landingDomains = downloadLandingDomains

checkDefender -ips $ips -emailDomains $emailDomains -landingDomains $landingDomains