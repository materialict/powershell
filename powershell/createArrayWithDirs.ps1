# fill a directory string 
$projectFolder = "D:\sync\projects\joomla\3.0"

# get the folders in that directory and put them in an array
$projects = @(Get-ChildItem -Path $projectFolder | ?{ $_.PSIsContainer })

# create a option list 
do {
	try {
		$userInput = $true
		Clear-host
		for ($i=0; $i -lt $projects.length ; $i++) {
		        write-host ("$i. {0}" -f $projects[$i])
		}
		Write-Host
		[int]$enteredValue = Read-host "Select a value"
	} catch {
		$userInput = $false
	}
} # end do 
until (($enteredValue -ge 0 -and $enteredValue -lt $projects.length) -and $userInput)
