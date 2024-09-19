function addTransportRule {
    param (
        [string]$ruleName = "ATTACK Simulator",
        [string]$headerName = "x-ats-simulation",
        [string]$headerValue = "true",
        [string]$priority = "0",
        [string]$mode = "Enforce",
        [string]$comments = "Rule to handle emails from ATTACK Simulator"
    )
   
    $rule = Get-TransportRule -Identity $ruleName -ErrorAction SilentlyContinue
    if ($rule -eq $null) {
        Write-Host "Creating the transport rule '$ruleName'..."
        New-TransportRule -Name $ruleName `
        -HeaderMatchesMessageHeader $headerName -HeaderMatchesPatterns $headerValue `
        -SetSCL "-1" `
        -SetHeaderName "X-MS-Exchange-Organization-SkipSafeLinksProcessing" -SetHeaderValue "1" `
        -Priority $priority `
        -Mode $mode `
        -Comments $comments
        Write-Host "The transport rule '$ruleName' has been created."
    } else {
        Write-Host "The transport rule '$ruleName' already exists."
    }
}

function checkTransportRule {
    param (
        [string]$ruleName = "ATTACK Simulator"
    )

    $rule = Get-TransportRule -Identity $ruleName -ErrorAction SilentlyContinue
    if ($rule -eq $null) {
        Write-Host "The transport rule '$ruleName' does not exist."
    } else {
        Write-Host "The transport rule '$ruleName' exists."

        # Display the transport rule details
        $rule | Format-List
    }
}

function removeTransportRule {
    param (
        [string]$ruleName = "ATTACK Simulator"
    )

    $rule = Get-TransportRule -Identity $ruleName -ErrorAction SilentlyContinue
    if ($rule -eq $null) {
        Write-Host "The transport rule '$ruleName' does not exist."
    } else {
        Write-Host "Removing the transport rule '$ruleName'..."
        Remove-TransportRule -Identity $ruleName -Confirm:$false
        Write-Host "The transport rule '$ruleName' has been removed."
    }
}