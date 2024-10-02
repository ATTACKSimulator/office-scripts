function connect {
    # check if the module is already installed
    if (-not (Get-Module -Name ExchangeOnlineManagement -ListAvailable)) {
        Write-Host "The module ExchangeOnlineManagement is not installed. Installing it now." -ForegroundColor yellow
        # install the module
        Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber
    } 

    Import-Module ExchangeOnlineManagement

    Connect-ExchangeOnline
}