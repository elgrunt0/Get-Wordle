$URI = 'https://www.powerlanguage.co.uk/wordle/'
$www = Invoke-WebRequest -Uri $URI
# Get the javascript
$js = ($www).Scripts.src[-1]
$script = Invoke-WebRequest -URI ($URI + $js)

# Get worldlist and split into array
$pattern = '(?<=(var La=\[))(\w|\n|\r|[",])+?(?=(\]))'
$array = ([regex]::Matches($script, $pattern).value).split(',')

# We know today's game is #221 (Click the gear icon) so we can manually use (get-date).AddDays(-221) to find when day 0 was and set that as a constant.
$day0 = Get-Date '19 June 2021'
$datediff = (New-TimeSpan -Start $day0 -End (Get-Date)).Days
$todaysWordle = ($array[$datediff])

$todaysWordle.ToUpper()
