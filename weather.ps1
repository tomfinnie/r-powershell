

function global:Get-Weather
{
    param
    (
        [Parameter(Position=0, Mandatory=$false, ValueFromPipelineByPropertyName=$true)][Alias('latitude')]$lat,
        [Parameter(Position=1, Mandatory=$false, ValueFromPipelineByPropertyName=$true)][Alias('longitude')]$long,
        [Parameter(Position=2, Mandatory=$false, ValueFromPipelineByPropertyName=$true)][Alias('city')]$cityName
    )
    begin{$webclient = New-Object System.Net.webclient}
    process
    {
        if ($lat -ne $null -and $long -ne $null)
        {
            $url = "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&mode=xml&units=metric"
        }
        else
        {
            $url = "http://api.openweathermap.org/data/2.5/weather?q=$cityName&mode=xml&units=metric"
        }
        try
        {
            [xml]$xmlData = $webclient.downloadstring($url)
            $w = $xmlData.current
            $outputData = New-Object -TypeName PSObject -Property `
            @{
                city=$w.city.name
                country=$w.city.country
                latitude=$w.city.coord.lat
                longitude=$w.city.coord.lon
                sunrise=[datetime]$w.city.sun.rise
                sunset=[datetime]$w.city.sun.set
                temperature=$w.temperature.value
                maxTemp=$w.temperature.max
                minTemp=$w.temperature.min
                humidity=$w.humidity.value
                pressure=$w.pressure.value
                windSpeed=$w.wind.speed.value
                windDirection=$w.wind.direction.value
                cloudState=$w.clouds.name
                observationtime=[datetime]$w.lastupdate.value
            }
            $OutputData
        }
        catch
        {
            Write-Error "Location Not Found"
        }  
        
    }
    end{}
}

