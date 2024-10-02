function addIpsToConnectionFilterPolicy {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$ips
    )

    $defaultPolicy = Get-HostedConnectionFilterPolicy -Identity Default
    if ($defaultPolicy) {
        # Update the existing default policy
        Set-HostedConnectionFilterPolicy -Identity Default -IPAllowList ($defaultPolicy.IPAllowList + $ips | Select-Object -Unique)
        Write-Host "Updated the default Connection Filter Policy with the new allowed IPs." -ForegroundColor green
    } else {
        Write-Host "No default Connection Filter Policy found." -ForegroundColor red
    }
}

function removeIpsFromConnectionFilterPolicy {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$ips
    )

    $defaultPolicy = Get-HostedConnectionFilterPolicy -Identity Default
    if ($defaultPolicy) {
        # Update the existing default policy
        Set-HostedConnectionFilterPolicy -Identity Default -IPAllowList ($defaultPolicy.IPAllowList | Where-Object { $_ -notin $ips })
        Write-Host "Removed the ATTACK Simulator IPs from the default Connection Filter Policy." -ForegroundColor green
    } else {
        Write-Host "No default Connection Filter Policy found." -ForegroundColor red
    }
}

function checkIpsInConnectionFilterPolicy {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$ips
    )

    $defaultPolicy = Get-HostedConnectionFilterPolicy -Identity Default
    if ($defaultPolicy) {
        # Check if the IP addresses are added to the policy
        $missingIps = $ips | Where-Object { $_ -notin $defaultPolicy.IPAllowList }

        if ($missingIps) {
            Write-Host "The following IP addresses are missing from the Connection Filter Policy:" -ForegroundColor yellow
            $missingIps | ForEach-Object { Write-Host $_ }
        } else {
            Write-Host "All IP addresses are added to the Connection Filter Policy." -ForegroundColor green
        }
    } else {
        Write-Host "No default Connection Filter Policy found." -ForegroundColor red
    }
}

function checkSimulationData {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$existing,
        [Parameter(Mandatory=$true)]
        [string[]]$expected
    )
    
    $toAdd = $expected | Where-Object { $_ -notin $existing }
    $toRemove = $existing | Where-Object { $_ -notin $expected }

    return $toAdd, $toRemove
}

function addAdvancedDeliverySettings {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$emailDomains,
        [Parameter(Mandatory=$true)]
        [string[]]$ips
    )

    $SimulationSenderDomains = $emailDomains | ForEach-Object { "ats.$_" }

    # Check if the simulation already exists
    $existingSimulation = Get-ExoPhishSimOverrideRule

    if ($existingSimulation) {
        Write-Host "Existing simulation found. Updating..."

        $ipsToAdd, $ipsToRemove = checkSimulationData -existing $existingSimulation.SenderIpRanges -expected $ips
        $domainsToAdd, $domainsToRemove = checkSimulationData -existing $existingSimulation.Domains -expected $SimulationSenderDomains

        if ($ipsToAdd.Count -eq 0 -and $ipsToRemove.Count -eq 0 -and $domainsToAdd.Count -eq 0 -and $domainsToRemove.Count -eq 0) {
            Write-Host "No changes detected. Skipping..." -ForegroundColor green
            return
        }

        Set-ExoPhishSimOverrideRule -Identity $existingSimulation.Identity -AddSenderIpRanges $ipsToAdd -RemoveSenderIpRanges $ipsToRemove -AddDomains $domainsToAdd -RemoveDomains $domainsToRemove
        Write-Host "Added $($ipsToAdd.Count) new IPs and $($domainsToAdd.Count) new domains to the Third Party Phishing Simulation configuration." -ForegroundColor green
        Write-Host "Removed $($ipsToRemove.Count) IPs and $($domainsToRemove.Count) domains from the Third Party Phishing Simulation configuration." -ForegroundColor green
        Write-Host "Successfully updated the Third Party Phishing Simulation configuration." -ForegroundColor green
    } else {
        Write-Host "No existing simulation found. Creating new configuration..." -ForegroundColor yellow

        # Add the new simulation configuration
        New-ExoPhishSimOverrideRule -Policy PhishSimOverridePolicy -SenderIpRanges $ips -Domains $SimulationSenderDomains

        Write-Host "Successfully added new Third Party Phishing Simulation configuration." -ForegroundColor green
    }
}

function removeAdvancedDeliverySettings {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$emailDomains,
        [Parameter(Mandatory=$true)]
        [string[]]$ips
    )

    # Check if the simulation already exists
    $existingSimulation = Get-ExoPhishSimOverrideRule

    if ($existingSimulation) {
        Remove-ExoPhishSimOverrideRule -Identity $existingSimulation.Identity -Confirm:$false
        Write-Host "Successfully removed the Third Party Phishing Simulation configuration." -ForegroundColor green
    } else {
        Write-Host "No existing simulation found." -ForegroundColor red
    }
}

function checkAdvancedDeliverySettings {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$emailDomains,
        [Parameter(Mandatory=$true)]
        [string[]]$ips
    )
    # Check if the simulation already exists
    $existingSimulation = Get-ExoPhishSimOverrideRule

    if ($existingSimulation) {
        # Generate simulation URLs from landing page domains
        $SimulationSenderDomains = $emailDomains | ForEach-Object { "ats.$_" }
        Write-Host "Existing simulation found. Checking for updates..."

        $domainsToAdd, $domainsToRemove = checkSimulationData -existing $existingSimulation.Domains -expected $SimulationSenderDomains
        if ($domainsToAdd) {
            Write-Host "We've found missing domains in the simulation configuration:" -ForegroundColor red
            $domainsToAdd | ForEach-Object { Write-Host $_ }
        } elseif ($domainsToRemove) {
            Write-Host "We've found extra domains in the simulation configuration:" -ForegroundColor red
            $domainsToRemove | ForEach-Object { Write-Host $_ }
        } else {
            Write-Host "All email domains are up to date." -ForegroundColor green
        }

        $ipsToAdd, $ipsToRemove = checkSimulationData -existing $existingSimulation.SenderIpRanges -expected $ips
        if ($ipsToAdd) {
            Write-Host "We've found missing IPs in the simulation configuration:" -ForegroundColor red
            $ipsToAdd | ForEach-Object { Write-Host $_ }
        } elseif ($ipsToRemove) {
            Write-Host "We've found extra IPs in the simulation configuration:" -ForegroundColor red
            $ipsToRemove | ForEach-Object { Write-Host $_ }
        } else {
            Write-Host "All IPs are up to date." -ForegroundColor green
        }

    } else {
        Write-Host "No existing simulation found." -ForegroundColor red
    }
}

function addDefender {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$ips,
        [Parameter(Mandatory=$true)]
        [string[]]$emailDomains,
        [Parameter(Mandatory=$true)]
        [string[]]$landingDomains
    )

    Write-Host "Adding ATTACK Simulator settings to Microsoft 365 Defender..."
    addIpsToConnectionFilterPolicy -ips $ips
    addAdvancedDeliverySettings -emailDomains $emailDomains -ips $ips
}

function removeDefender {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$ips,
        [Parameter(Mandatory=$true)]
        [string[]]$emailDomains,
        [Parameter(Mandatory=$true)]
        [string[]]$landingDomains
    )

    Write-Host "Removing ATTACK Simulator settings from Microsoft 365 Defender..."
    removeIpsFromConnectionFilterPolicy -ips $ips
    removeAdvancedDeliverySettings -emailDomains $emailDomains -ips $ips
}

function checkDefender {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$ips,
        [Parameter(Mandatory=$true)]
        [string[]]$emailDomains,
        [Parameter(Mandatory=$true)]
        [string[]]$landingDomains
    )

    Write-Host "Checking ATTACK Simulator settings in Microsoft 365 Defender..."
    checkIpsInConnectionFilterPolicy -ips $ips
    checkAdvancedDeliverySettings -emailDomains $emailDomains -ips $ips
}