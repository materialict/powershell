# init 
$wwwroot="D:\inetpub\wwwroot"
#$target="D:\sync\projects\joomla\3.0"
$joomlaFolder = "D:\sync\projects\joomla\3.0"
$joomlaTypes = @('components', 'modules', 'plugins', 'templates')

# display a selection of projects 
do {
	try {
		$userInput = $true
		Clear-host
		for ($i=0; $i -lt $joomlaTypes.length ; $i++) {
		        write-host ("$i. {0}" -f $joomlaTypes[$i])
		}
		Write-Host
		[int]$enteredValue = Read-host "Select a Joomla type"
	} catch {
		$userInput = $false
	}
} # end do 
until (($enteredValue -ge 0 -and $enteredValue -lt $joomlaTypes.length) -and $userInput)

$joomlaType 	= $joomlaTypes[$enteredValue]
$target 	= "$joomlaFolder\$joomlaType" 
$source		= "$wwwroot\$joomlaType"

# create an array with the projects in the folder 
write-host "Processing... {$joomlaFolder\$joomlaType}"
write-host "joomlaType... $joomlaType"

### create a list of projects ###
$projects = @(Get-ChildItem -Path $target | ?{ $_.PSIsContainer })

### modules ###
if ($joomlaType -eq "modules"){
	write-host "modules"

	# display a selection of projects 
	$enteredValue = -1
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
		
		Write-Host "source: $source\$project"
		Write-Host "target: $target\$project"

		
		Copy-Item $source\$project\* $target\$project\ -force -recurse
	}

}
	
### plugins ###
if ($joomlaType -eq "plugins"){
	write-host "plugins"
}

### templates ###
if ($joomlaType -eq "templates"){
	write-host "templates"
}

### components ###
if ($joomlaType -eq "components"){
	# $projects=@('sportswriter', 'sportsimage', 'sportsvideo', 'sportsarticle', 'sportsgrouping')
	# display a selection of projects 
	$enteredValue = -1
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

		## check if the folders exist
		$folder = $project
		Write-Host "Checking folder... $target\$folder"
		if (!(Test-Path $target\$folder)){
			Write-Host "Creating folder..."
			new-item $target\$folder -itemtype directory
		} else {
			Write-Host "Folder $target\$folder already exists."	
		}

		## administration part
		Write-Host "Checking folder... $target\$folder\admin"
		if (!(Test-Path $target\$folder\admin)){
			new-item $target\$folder\admin -itemtype directory
		} else {
			Write-Host "Folder $target\$folder\admin already exists."	
		}

		## site part
		Write-Host "Checking folder... $target\$folder\site"
		if (!(Test-Path $target\$folder\site)){
			new-item $target\$folder\site -itemtype directory
		} else {
			Write-Host "Folder $target\$folder\site already exists."	
		}

		## media part
		Write-Host "Checking folder... $target\$folder\site"
		if (!(Test-Path $target\$folder\media)){
			new-item $target\$folder\media -itemtype directory
		} else {
			Write-Host "Folder $target\$folder\site already exists."	
		}

		## copy the content
		## force overwrites the files without prompting for an answer 
		## recurse copies the content of subfolders
		Write-Host "Copying Admin files..."
		if (Test-Path $wwwroot\administrator\components\$folder){
			Copy-Item $wwwroot\administrator\components\$folder\* $target\$folder\admin\ -force -recurse
		}

		Write-Host "Copying Site  files..."
		if (Test-Path $wwwroot\components\$folder){
			Copy-Item $wwwroot\components\$folder\* $target\$folder\site\ -force -recurse
		}

		Write-Host "Copying Site  files..."
		if (Test-Path $wwwroot\media\$folder){
			Copy-Item $wwwroot\media\$folder\* $target\$folder\media\ -force -recurse
		}

		#### remove the com_ ###
		$projectFile = "$project".Substring(4)

		if (Test-Path $target\$folder\admin\$projectFile.*){
			Move-Item -path $target\$folder\admin\$projectFile.* -destination $target\$folder\ -force
		}		
		if (Test-Path $target\$folder\admin\script.php){
			Move-Item -path $target\$folder\admin\script.php -destination $target\$folder\ -force
		}	
	}
}