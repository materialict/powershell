$projects=@("sportswriter", "sportsimage", "sportsvideo", "sportsarticle", "sportsgrouping")

do {
	try {
		$userInput = $true
		Clear-host
		for ($i=0; $i -lt $projects.length ; $i++) {
		        write-host ("$i. {0}" -f $projects[$i])
		}
		write-host "$i. Process all"
		Write-Host
		[int]$enteredValue = Read-host "Select a value"
	} catch {
		$userInput = $false
	}
} # end do 
until (($enteredValue -ge 0 -and $enteredValue -le $projects.length) -and $userInput)

# 
if ($enteredValue -eq $projects.length){
	$projects = $projects
} else {
	$projects = $projects[$enteredValue]
}

#process the selection
foreach ($project in $projects){
	Write-Host "Processing $project" 
}