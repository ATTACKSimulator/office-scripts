function prompt {
    param(
        [string]$message
    )
    Write-Host $message
    Write-Host "[?] Do you want to continue? (Y/n)" -ForegroundColor Magenta
    $response = Read-Host
    if ($response -ne 'Y' -and $response -ne 'y' -and $response -ne '') {
        Write-Host "Script execution stopped." -ForegroundColor Red
        exit
    }
}