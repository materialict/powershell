$projectFolder	= ""
$projectName	= ""

# select the version 
do {
	try {
		$userInput = $true
		Clear-host
		Write-Host
		Write-Host "1. Version 3.0"
		Write-Host
		[int]$enteredValue = Read-host "Select a value"
	} catch {
		$userInput = $false
	}
} # end do 
until (($enteredValue -eq 1) -and $userInput)
if ($enteredValue == 1){
	$joomlaVersion = 3.0
}

# select the type 
do {
	try {
		$userInput = $true
		Clear-host
		Write-Host
		Write-Host "1. Components "
		Write-Host "2. modules "
		Write-Host
		[int]$enteredValue = Read-host "Select a value"

	} catch {
		$userInput = $false
	}
} # end do 
until (($enteredValue -eq 1) -and $userInput)
if ($enteredValue -eq 1){
	$projectType = "components"
}


# get the project name
# select the type 
do {
	try {
		$userInput = $true
		Clear-host
		[int]$projectName = Read-host "Enter the project name"
	} catch {
		$userInput = $false
	}
} # end do 
#until (($projectName -ne $null -or $projectName -ne "") -and $userInput)
until (!{isnullorempty($projectName)} -and $userInput)

# create the folder structure
if (!{Test-Path C:\Scripts\Archive}){
	
} else {
	Write-host "Folder already exist... exiting."
	$host.Exit()
}

