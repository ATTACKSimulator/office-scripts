function addAllowedSenders {
    #define the domains param
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$domains
    )   

    $defaultPolicy = Get-HostedContentFilterPolicy -Identity Default
    if ($defaultPolicy) {
        # Update the existing default policy
        Set-HostedContentFilterPolicy -Identity $spamFilterPolicy -AllowedSenderDomains @{Add=$domains}
        Write-Host "Updated the default Antispam Inbound Policy with the new allowed domains." -ForegroundColor green
    } else {
        throw "No default Antispam Inbound Policy found."
    }
}

function removeAllowedSenders {
    #define the domains param
    param(
        [Parameter(Mandatory=$true)]
        [string[]]$domains
    )   

    defaultPolicy = Get-HostedContentFilterPolicy -Identity Default
    if ($defaultPolicy) {
        # Remove the domains to the Allowed Senders and Domains list
        Write-Host "Removing domains: $domains"
        Set-HostedContentFilterPolicy -Identity Default -AllowedSenderDomains @{Remove=$domains}
    } else {
        Write-Host "No default Antispam Inbound Policy found." -ForegroundColor red
    }
}

function checkDomainsInSpecificPolicy {
    param (
        [Parameter(Mandatory=$true)]
        [object]$policy,
        [Parameter(Mandatory=$true)]
        [string[]]$domains
    )
    
    # Normalize the allowed sender domains (convert to lowercase)
    $normalizedAllowedDomains = $policy.AllowedSenderDomains | ForEach-Object { 
        if ($_ -is [string]) {
            $_.ToLower()
        } elseif ($_.Domain) {
            $_.Domain.ToLower()
        } else {
            Write-Warning "Unexpected data type in AllowedSenderDomains" -ForegroundColor red
            $_
        }
    }

    # Check if the email domains are added to the policy
    $missingDomains = $domains | Where-Object { $_ -notin $normalizedAllowedDomains }

    if ($missingDomains) {
        Write-Host "The following email domains are missing from the Antispam Inbound Policy:" -ForegroundColor yellow
        $missingDomains | ForEach-Object { Write-Host $_ }
    } else {
        Write-Host "All required domains are added to the Antispam Inbound Policy." -ForegroundColor green
    }
}

function checkAllowedSenders {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$domains
    )

    $defaultPolicy = Get-HostedContentFilterPolicy -Identity Default
    if ($defaultPolicy) {
        checkDomainsInSpecificPolicy -policy $defaultPolicy -domains $domains
    } else {
        throw "No default Antispam Inbound Policy found."
    }
}