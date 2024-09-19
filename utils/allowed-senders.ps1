function addAllowedSenders {
    #define the domains param
    param(
        [string[]]$domains
    )   

        # Define the spam filter policy name and the allowed domains
    $spamFilterPolicy = "default" # or the name of your specific policy

    # Add the domains to the Allowed Senders and Domains list
    Write-Host "Adding domains: $domains"
    Set-HostedContentFilterPolicy -Identity $spamFilterPolicy -AllowedSenderDomains @{Add=$domains}
}

function removeAllowedSenders {
    #define the domains param
    param(
        [string[]]$domains
    )   

    # Define the spam filter policy name and the allowed domains
    $spamFilterPolicy = "default" # or the name of your specific policy

    # Add the domains to the Allowed Senders and Domains list
    Write-Host "Removing domains: $domains"
    Set-HostedContentFilterPolicy -Identity $spamFilterPolicy -AllowedSenderDomains @{Remove=$domains}
}

function checkAllowedSenders {
    #define the domains param
    param(
        [string[]]$domains
    )   

    $spamFilterPolicy = "Default"  # or the name of your custom policy

    # Retrieve the allowed sender domains
    $allowedDomains = (Get-HostedContentFilterPolicy -Identity $spamFilterPolicy | Select-Object -ExpandProperty AllowedSenderDomains) -split "`n"

    # Compare domains from endpoint with allowed domains
    $notAllowed = $domains | Where-Object { $_ -notin $allowedDomains }

    # Display results
    if ($notAllowed.Count -eq 0 -and $missingFromEndpoint.Count -eq 0) {
        Write-Host "All domains from the endpoint are already in the allowed list."
    } else {
        Write-Host "Domains from the endpoint not in the allowed list:"
        $notAllowed | ForEach-Object { Write-Host $_ }
    }
}