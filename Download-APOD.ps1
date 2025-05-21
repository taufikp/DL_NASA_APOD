# Configuration
$apiKey = "DEMO_KEY"
$apiUrl = "https://api.nasa.gov/planetary/apod?api_key=$apiKey"
#$saveFolder = "$env:USERPROFILE\Pictures\NASA_APOD"
$saveFolder = "c:\scripts\NASA_APOD\Pictures"
$logFolder = "c:\scripts\NASA_APOD\logs"
$today = Get-Date -Format "yyyy-MM-dd"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logFile = Join-Path $logFolder "APOD_$today.log"

# Create folder if not exists
if (-not (Test-Path $saveFolder)) {
    New-Item -ItemType Directory -Path $saveFolder | Out-Null
}
if (-not (Test-Path $logFolder)) {
    New-Item -ItemType Directory -Path $logFolder | Out-Null
}

# Logging function
function Write-Log {
    param ([string]$message)
    $entry = "[$timestamp] $message"
    Add-Content -Path $logFile -Value $entry
}

Write-Log "=== Starting APOD download script ==="

try {
    # Get APOD JSON
    Write-Log "Requesting data from NASA APOD API..."
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
        Write-Log "Downloading image from: $imageUrl"
        Invoke-WebRequest -Uri $imageUrl -OutFile $filePath
        Write-Log "Image saved to: $filePath"
    } else {
        Write-Log "Today's APOD is not an image. It's a video: $($response.url)"
    }
} catch {
    Write-Log "ERROR: $($_.Exception.Message)"
}

Write-Log "=== Script finished === `r`n"