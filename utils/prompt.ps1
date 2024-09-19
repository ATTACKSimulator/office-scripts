function prompt {
    param(
        [string]$message
    )
    Write-Host $message
    Write-Host "Do you want to continue? (Y/n)"
    $response = Read-Host
    if ($response -eq 'Y' -or $response -eq 'y' -or $response -eq '') {
        Write-Host "Continuing the script..."        
    } else {
        Write-Host "Script execution stopped."
        exit
    }
}