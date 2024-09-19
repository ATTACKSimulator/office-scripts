function downloadDomains {
    Write-Host "Downloading the list of domains from ATTACK Simulator..."
    # Define the URL of the endpoint
    $url = "https://app.attacksimulator.com/whitelist/domains"  # Replace with your actual endpoint URL

    # Download the content from the URL
    $response = Invoke-WebRequest -Uri $url

    # Split the response content into individual lines (domains)
    $domains = $response.Content -split "`n"

    return $domains
}