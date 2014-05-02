# ==============================================================================================
# 
# NAME: unifacecontroller.PS1
# 
# DESCRIPTION: Control the eactions of importing and exporting objects over several projects
# 
# COMMENT:
#
# VERSION HISTORY:
#
#     VERSION  DATE        	WHO               	DESCRIPTION
#     0.1      2013-03-26	Dennis E.J. Vorst 	Initial version
# 
# ==============================================================================================
## receive the parameters 
param($action, $filename)

$root_folder = $filename

### start getProjectFolder ###
# put the argument string into a variable 
# now turn it into a folder object
Convert-Path -LiteralPath $root_folder 

#get the folder name 
$destination = Split-Path -Path $root_folder -Parent
$foldername = Split-Path -Path $destination -Leaf

While ($foldername -eq "components" -or $foldername -eq "models" -or $foldername -eq "libraries" -or $foldername -eq "export" -or $foldername -eq "fieldlayout" -or $foldername -eq "templates" -or $foldername -eq "fieldsyntax" -or $foldername -eq "fieldinterface" -or $foldername -eq "fieldtemplate" -or $foldername -eq "formats" -or $foldername -eq "global_constants" -or $foldername -eq "global_procs" -or $foldername -eq "global_vars" -or $foldername -eq "glyphs" -or $foldername -eq "helptexts" -or $foldername -eq "include_procs" -or $foldername -eq "menus" -or $foldername -eq "messages" -or $foldername -eq "panels"  -or $foldername -eq "entities"){
	# go up one parent 
	$destination = Split-Path -Path $destination -Parent

	#get the folder name 
	$foldername = Split-Path -Path $destination -Leaf
}

write-Host "foldername	: $foldername"

$project_name = $foldername
###### start getProjectDetails ######

switch ($project_name)
{
	"project" {
		$executable 	= "D:\uniface\uniface9401\common\bin\idf.exe"
		$administration	= "D:\projects\uniface\project"					
	}
### code your project here 
##	"<myProjectname>" {
##		$executable 	= "<path to my>\idf.exe"
##		$administration	= "<path to the *.asn and *.ini file. They must be in the same folder>"
##	}

	default {
		Write-Host "No properties found for project $project_name. You need to edit the unifaceController.ps1 file" 
		exit
	}
}

###### end getProjectDetails ######
### end getProjectFolder ###


### Operation ###
write-Host "destination		: $destination"
Write-Host "executable		: $executable"
write-Host "administration	: $administration"
write-Host "filename 		: ${filename}"

switch ($action)
{
		"EXPORTALL"{
			# strip the filename 
			$output = Split-Path -Path $filename -Parent
			
			# use the root folder to create a list of all directories 
			$files = Get-ChildItem $output\*.* -include *.exp

			# do the export for each file
			foreach ($filename in $files){
				write-Host "filename : $filename"
				invoke-expression "$destination\export.ps1  $filename $executable $administration $destination"
			
			}
		}
		"IMPORT" {
			Write-Host "Importing $filename"
			# variable path - works
			invoke-expression "$destination\import.ps1  $filename $executable $administration $destination"

		}
		"EXPORT" {
			Write-Host "Exporting $filename"			
			# variable path - works
			invoke-expression "$destination\export.ps1  $filename $executable $administration $destination"
		}	
}
exit 