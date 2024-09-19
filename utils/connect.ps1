function connect {
    Install-Module -Name ExchangeOnlineManagement

    Import-Module ExchangeOnlineManagement

    Connect-ExchangeOnline
}