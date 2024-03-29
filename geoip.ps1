function global:Get-GeoIP
{
    param([Parameter(Position=0, Mandatory=$false, ValueFromPipelineByPropertyName=$true)][Alias('ipAddress')]$ip)
    
    $webclient = New-Object System.Net.webclient
    $providerRoot = "http://freegeoip.net/xml/"
    [xml]$geoData = $webclient.downloadstring($providerRoot+$ip)
    Write-Output $geoData.response
}

