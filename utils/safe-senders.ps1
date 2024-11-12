function Add-AtPrefix {
    param(
        [string[]]$domains
    )

    $domains = $domains | ForEach-Object {
        if ($_ -notmatch "^@") {
            "@" + $_
        } else {
            $_
        }
    }

    return $domains
}

function addSafeSenders {
    param(
        [string[]]$domains
    )

    $domains = $domains + (Add-AtPrefix -domains $domains)

    $mailboxes = Get-Mailbox
    foreach ($mailbox in $mailboxes) {
        Set-MailboxJunkEmailConfiguration -Identity $mailbox.Identity -TrustedSendersAndDomains @{Add=$domains}
        Write-Host "The following domains have been added to the safe senders list for $($mailbox.Identity): $($domains -join ', ') \n" -ForegroundColor green
    }
}

function checkSafeSenders {
    Write-Host "Type an email address to check if it has the correct safe senders configuration."
    $email = Read-Host "Email address (or press enter to use a random one from your account)"

    # If the user didn't provide an email address, use a random one from the account that is a real mailbox
    if ($email -eq "") {
        $email = Get-Mailbox | Select-Object -First 1 -ExpandProperty PrimarySmtpAddress
        Write-Host "Using email address: $email"   
    }

    # Check if the email address is valid
    if ($email -notmatch "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") {
        Write-Host "Invalid email address. Please try again."
        exit
    }

    Write-Host "The safe sender configuration for $email is:"
    (Get-MailboxJunkEmailConfiguration -Identity $email).TrustedSendersAndDomains
    Write-Host "The safe sender configuration for $email."
}

function removeSafeSenders {
    param(
        [string[]]$domains
    )

    $domains = $domains + (Add-AtPrefix -domains $domains)

    $mailboxes = Get-Mailbox
    foreach ($mailbox in $mailboxes) {
        Set-MailboxJunkEmailConfiguration -Identity $mailbox.Identity -TrustedSendersAndDomains @{Remove=$domains}
        Write-Host "The following domains have been removed from the safe senders list for $($mailbox.Identity): $($domains -join ', ') \n" -ForegroundColor green
    }
}
