function validateDomains {
    param(
        [string[]]$domains
    )

    $valid = $true

    foreach ($domain in $domains) {
        if ($domain -notmatch "^[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-z]{2,}$") {
            $valid = $false
            Write-Host "Invalid domain: $domain" -ForegroundColor Red
        }
    }

    return $valid
}

# Prompt to add custom domains separated by commas
function customDomains {
    param(
        [string]$message
    )

    Write-Host $message
    Write-Host "Please enter the custom domains separated by commas."
    $response = Read-Host
    $response = $response -split ','

    #trim the whitespace
    $response = $response | ForEach-Object { $_.Trim() }


    # Validate the domains
    if (validateDomains -domains $response) {
        Write-Host "Custom domains added successfully." -ForegroundColor Green
    } else {
        Write-Host "Please try again." -ForegroundColor Red
        return customDomains -message $message
    }

    return $response
}