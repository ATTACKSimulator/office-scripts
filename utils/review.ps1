. "./utils/prompt.ps1"

function review {
    param (
        [string[]]$emailDomains,
        [string[]]$landingDomains,
        [string[]]$ips
    )

    Write-Host "The script will add the following settings:" -ForegroundColor Blue
    Write-Host ""
    Write-Host " - Allowed Senders ($($emailDomains.Length + $landingDomains.Length)): $($emailDomains + $landingDomains)" -ForegroundColor Blue
    Write-Host " - Transport Rule: Add a transport rule to allow emails from ATTACK Simulator" -ForegroundColor Blue
    Write-Host " - Safe Senders ($($emailDomains.Length + $landingDomains.Length)): $($emailDomains + $landingDomains)" -ForegroundColor Blue
    Write-Host " - Safe URLs ($($landingDomains.Length)): $($landingDomains)" -ForegroundColor Blue
    Write-Host " - Defender: Add the following IPs to the IP Allow List ($($ips.Length)): $($ips)" -ForegroundColor Blue
    Write-Host " - Defender: Add the following email domains to the Allow List ($($emailDomains.Length)): $($emailDomains)" -ForegroundColor Blue
    Write-Host " - Defender: Add the following landing domains to the Allow List ($($landingDomains.Length)) $($landingDomains)" -ForegroundColor Blue
    Write-Host ""
    prompt -message "Please review the settings and confirm"
}