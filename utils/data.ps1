. "./utils/custom.ps1"
. "./utils/download.ps1"

function emailDomains {
    # Promp the user if they want to add custom email domains or use the default list
    Write-Host "[?] Would you like to add custom email domains? (y/N)" -ForegroundColor Magenta
    
    $response = Read-Host
    if ($response -eq "y") {
        $emailDomains = customDomains -message "Please type your custom email domains."
    } else {
        $emailDomains = downloadEmailDomains
    }

    return $emailDomains
}

function landingDomains {
    # Prompt the user if they want to add custom landing domains or use the default list
    Write-Host "[?] Would you like to add custom landing domains? (y/N)" -ForegroundColor Magenta
    $response = Read-Host

    if ($response -eq "y") {
        $landingDomains = customDomains -message "Please type your custom landing pages domains."
    } else {
        $landingDomains = downloadLandingDomains
    }

    return $landingDomains
}