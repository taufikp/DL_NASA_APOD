# Configuration
$apiKey = "DEMO_KEY"
$apiUrl = "https://api.nasa.gov/planetary/apod?api_key=$apiKey"
$saveFolder = "$env:USERPROFILE\Pictures\NASA_APOD"
$today = Get-Date -Format "yyyy-MM-dd"

# Create folder if not exists
if (-not (Test-Path $saveFolder)) {
    New-Item -ItemType Directory -Path $saveFolder | Out-Null
}

# Get APOD JSON
$response = Invoke-RestMethod -Uri $apiUrl

# Check if the media is an image
if ($response.media_type -eq "image") {
    $imageUrl = $response.hdurl
    if (-not $imageUrl) {
        $imageUrl = $response.url
    }

    # Set filename
    $fileName = "$today.jpg"
    $filePath = Join-Path $saveFolder $fileName

    # Download image
    Invoke-WebRequest -Uri $imageUrl -OutFile $filePath

    Write-Output "Image downloaded to: $filePath"
} else {
    Write-Output "Today's APOD is not an image. It's a video: $($response.url)"
}
