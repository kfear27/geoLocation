#!ps
#$ErrorActionPreference = 'SilentlyContinue';
Add-Type -AssemblyName System.Device
$GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher
$GeoWatcher.Start()
$i = 0;
while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied') -and ($i -lt 50)) {
    Start-Sleep -Milliseconds 100;
    $i++;
}
if (($GeoWatcher.Position.Location.Latitude -ge 0) -or ($GeoWatcher.Position.Location.Latitude -le 0)) {
    $Latitude = $GeoWatcher.Position.Location.Latitude
    $Longitude = $GeoWatcher.Position.Location.Longitude
    $Result = "$($Latitude),$($Longitude)"
}
else {
    $jsonip = Invoke-WebRequest http://ipinfo.io/json -UseBasicParsing
    $ipinfo = Convertfrom-JSON $jsonip.Content
    $Result = $ipinfo.loc
}
Write-Host "$($Result)"

