function Install-PsUtils {
    $ModulePaths = @($env:PSModulePath -split ';')
    $ExpectedUserModulePath = Join-Path -Path ([Environment]::GetFolderPath('MyDocuments')) -ChildPath WindowsPowerShell\Modules
    $Destination = $ModulePaths | Where-Object { $_ -eq $ExpectedUserModulePath }
    if (-not $Destination) {
        $Destination = $ModulePaths | Select-Object -Index 0
    }
    $PsUtilsVersion = '1.4'
    $DownloadUrl = "https://github.com/willyd/PsUtils/archive/v$($PsUtilsVersion).zip"
    $DownloadDest = $Destination + "\PsUtilsv$($PsUtilsVersion).zip"
    Write-Host "Downloading PsUtils from $DownloadUrl"
    $client = (New-Object Net.WebClient)
    $client.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    $client.DownloadFile("$DownloadUrl", $DownloadDest)
    Add-Type -assembly "system.io.compression.filesystem"
    [io.compression.zipfile]::ExtractToDirectory($DownloadDest, $Destination)
    Move-Item ($Destination + "PsUtils-$($PsUtilsVersion)")  ($Destination + '\PsUtils')
}

Install-PsUtils