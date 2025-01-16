function downloadData {
    param(
        [string]$url
    )
    
    $response = Invoke-WebRequest -Uri $url
    $data = $response.Content -split "`n"

    Write-Host "Data downloaded successfully." -ForegroundColor Green
    return $data
}

function downloadEmailDomains {
    Write-Host "Downloading the list of domains from ATTACK Simulator..."
    return downloadData "https://app.attacksimulator.com/whitelist/email-domains"
}

function downloadIps {
    Write-Host "Downloading the list of IP addresses from ATTACK Simulator..."
    return downloadData "https://app.attacksimulator.com/whitelist/ips"
}

function downloadLandingDomains {
    Write-Host "Downloading the list of landing domains from ATTACK Simulator..."
    return downloadData "https://app.attacksimulator.com/whitelist/landing-domains"
}

