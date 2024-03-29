function Get-RandomIP
{
    [string]$ip = get-random -max 255
    1..3 | % `
    {
        $ip += "."
        $ip += get-random -max 255
    }
    $outputData = New-Object -TypeName PSObject -Property @{ipAddress=$ip}
    Write-Output $outputData
}