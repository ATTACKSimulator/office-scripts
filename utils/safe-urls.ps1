function addSafeUrls {
    param(
        [string[]]$urls
    )

    foreach ($url in $urls) {
        $firstUrl = $url + "/*"
        Write-Host "Adding $firstUrl to the safe urls list." -ForegroundColor green
        New-TenantAllowBlockListItems -Allow -ListType Url -ListSubType AdvancedDelivery -Entries $firstUrl -NoExpiration
        $secondUrl = "*." + $url + "/*"
        Write-Host "Adding $secondUrl to the safe urls list." -ForegroundColor green
        New-TenantAllowBlockListItems -Allow -ListType Url -ListSubType AdvancedDelivery -Entries $secondUrl -NoExpiration
    }
}

function removeSafeUrls {
    param(
        [string[]] $urls
    )

    foreach ($url in $urls) {
        $firstUrl = $url + "/*"
        Write-Host "Removing $firstUrl to the safe urls list." -ForegroundColor green
        Remove-TenantAllowBlockListItems -ListType Url -ListSubType AdvancedDelivery -Entries $firstUrl
        $secondUrl = "*." + $url + "/*"
        Write-Host "Removing $secondUrl to the safe urls list." -ForegroundColor green
        Remove-TenantAllowBlockListItems -ListType Url -ListSubType AdvancedDelivery -Entries $secondUrl
    }
}

function checkSafeUrls {
    param(
        [string[]] $urls
    )

    $safeUrls = Get-TenantAllowBlockListItems -ListType Url -ListSubType AdvancedDelivery -Allow | Select-Object -ExpandProperty Value

    Write-Host "The following urls are in the safe urls list:"
    foreach ($url in $urls) {
        $firstUrl = $url + "/*"
        $secondUrl = "*." + $url + "/*"
        if ($safeUrls -contains $firstUrl) {
            Write-Host "$firstUrl" -ForegroundColor green
        } else {
            Write-Host "$firstUrl" -ForegroundColor red
        }
        if ($safeUrls -contains $secondUrl) {
            Write-Host "$secondUrl" -ForegroundColor green
        } else {
            Write-Host "$secondUrl" -ForegroundColor red
        }
    }
}