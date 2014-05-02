# ==============================================================================================
# 
# NAME: IMPORT.PS1
# 
# DESCRIPTION: import a uniface component or model to the github folder 
# 
# COMMENT:
#
# VERSION HISTORY:
#
#     VERSION  DATE        	WHO               	DESCRIPTION
#     0.1      2012-11-11	Dennis E.J. Vorst 	Initial version
# 
# ==============================================================================================
Write-Host ""
Write-Host "### Start EXPORT.PS1 ###"

#### Please do not make any modifications beyond this point ###
#### processing ####
# get the arguments 
$uniface_file	= $args[0]
$executable 	= $args[1]
$administration = $args[2]

Write-Host "### Settings ###"
Write-Host "Exporting: 		: $uniface_file"
Write-Host "executable		: $executable"
Write-Host "administration	: $administration"

#### check for empty values ####
if ($uniface_file -eq $Null){
	Write-Host "Filename is empty!!"
} else {
	# seperate path and filename 
	$file 		= Get-ChildItem $args[0]
	$working_dir 	= $file.DirectoryName
#	$uniface_object = $file.Name.toUpper()

	#### importing ####
	Write-Host "$executable $administration /imp $uniface_file"
	& $executable /adm=$administration /imp $uniface_file | Out-Null
}

# remove the log file 
Write-Host "Deleting log files from $working_dir!"
Remove-Item $working_dir\*.log

# show done and display the screen a little longer 
Write-Host "Import done!"