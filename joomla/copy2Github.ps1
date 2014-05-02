# init 
$source	= "D:\sync\projects\joomla\3.0"
$target	= "D:\GitHub\joomla\3.0\components"
$projects=@('sportswriter', 'sportsimage', 'sportsvideo', 'sportsarticle', 'sportsgrouping')

# display a selection of projects 
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
	$folder = "com_$project"	

	Write-Host "Checking folder... $target\$folder"
	if (!(Test-Path $target\$folder)){
		Write-Host "Creating folder..."
		new-item $target\$folder -itemtype directory
	}

	Write-Host "Copying files..."
	## force overwrites the files without prompting for an answer 
	## recurse copies the content of subfolders
	Copy-Item $source\components\$folder\* $target\$folder\ -force -recurse	
}