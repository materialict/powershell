# ==============================================================================================
# 
# NAME: EXPORT.PS1
# 
# DESCRIPTION: export a uniface component or model to the github folder 
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
#Write-Host "Arguments: $args"

#### Please do not make any modifications beyond this point ###
#### processing ####
# get the arguments 
$uniface_file	= $args[0]
$executable 	= $args[1]
$administration = $args[2]
$destination	= $args[3]

#Write-Host "### Settings ###"
Write-Host "Exporting: 		: $uniface_file"
##Write-Host "uniface_file	: $uniface_file"
#Write-Host "executable		: $executable"
#Write-Host "administration	: $administration"
#Write-Host "destination	: $destination"

# if empty quit
if (!$uniface_file){
	Write-Host "Object name is empty"
} else {

	# seperate path and filename 
	$file 		= Get-ChildItem $args[0]
	$working_dir 	= $file.DirectoryName
	$uniface_object = $file.Name.toUpper()
	
	# strip the extention .xml or .exp
	$length 	= $uniface_object.length
	$uniface_object = $uniface_object.Substring(0,$length-4)
	
	# look for a . in the $uniface_object 
	$start = $uniface_object.IndexOf('.')
	if ($start -ge 0){
		Write-Host "Exporting $uniface_object data"
		$appl_model 	= $uniface_object.Substring(0,$start) 
		$uniface_object	= $uniface_object.Substring($start + 1) 
	} 
	
	### Start Processing ###
	if ($working_dir.EndsWith("data")){
		
		# export the data
		Write-Host "Exporting data from $uniface_object data"
		& $executable /adm=$administration /cpy sys:$uniface_object.$appl_model xml:$uniface_file | Out-Null
		
	} elseif ($working_dir.EndsWith("libraries")){
		# libraries 
	
		# export the library and wait for the job to finish 
		Write-Host "Export ULIBR    - Library"
		& $executable /adm=$administration /cpy /whr="ULIBRARY=$uniface_object" IDF:ULIBR.DICT XML:$uniface_file | Out-Null
	
		# export the conceptual table and wait for the job to finish
		Write-Host "Export USOURCE	- Sources Global Procs"
		& $executable /adm=$administration /cpy /apf /whr="UVAR=$uniface_object;USUB=P" IDF:USOURCE.DICT XML:$uniface_file | Out-Null

		# export the global variables and wait for the job to finish
		Write-Host "Export UGREGS	- Global Variables"
		& $executable /adm=$administration /cpy /apf /whr="U_FORMLIB=$uniface_object" IDF:UGREGS.DICT XML:$uniface_file | Out-Null
	
		# export the conceptual table and wait for the job to finish
		Write-Host "Export USOURCE	- Sources Include Procs"
		& $executable /adm=$administration /cpy /apf /whr="UVAR=$uniface_object;USUB=I" IDF:USOURCE.DICT XML:$uniface_file | Out-Null
	
		# export the conceptual table and wait for the job to finish 
		Write-Host "Export USOURCE	- Sources Labels and Messages"
		& $executable /adm=$administration /cpy /apf /whr="UVAR=$uniface_object;USUB=M" IDF:USOURCE.DICT XML:$uniface_file | Out-Null
	
		# export the glyphs and wait for the job to finish 
		Write-Host "Export UGLYPH	- Images"
		& $executable /adm=$administration /cpy /apf /whr="UCVAR=$uniface_object" IDF:UGLYPH.DICT XML:$uniface_file | Out-Null
	
		# export the USMENU and wait for the job to finish 
		Write-Host "Export USMENU	- Menus"
		& $executable /adm=$administration /cpy /apf /whr="UVAR=$uniface_object" IDF:USMENU.DICT XML:$uniface_file | Out-Null
	
		# export the USITEM and wait for the job to finish 
		Write-Host "Export USITEM	- Menu items"
		& $executable /adm=$administration /cpy /apf /whr="UVAR=$uniface_object" IDF:USITEM.DICT XML:$uniface_file | Out-Null
	
		# export the UFORMAT and wait for the job to finish 
		Write-Host "Export UFORMAT	- Format"
		& $executable /adm=$administration /cpy /apf /whr="UVAR=$uniface_object" IDF:UFORMAT.DICT XML:$uniface_file | Out-Null
	
	} elseif ($working_dir.EndsWith("models")){
		# application models 
	
		# export the conceptual schema and wait for the job to finish 
		Write-Host "Export UCSCH    - Conceptual Schema"
		& $executable /adm=$administration /cpy /whr="U_VLAB=$uniface_object" IDF:UCSCH.DICT XML:$uniface_file | Out-Null
	
		# export the conceptual table and wait for the job to finish 
		Write-Host "Export UCTABLE	- Conceptual Table"
		& $executable /adm=$administration /cpy /apf /whr="U_VLAB=$uniface_object" IDF:UCTABLE.DICT XML:$uniface_file | Out-Null
	
		# export the conceptual entity and wait for the job to finish 
		Write-Host "Export UCGROUP  - Conceptual Entities"
		& $executable /adm=$administration /cpy /apf /whr="U_VLAB=$uniface_object" IDF:UCGROUP.DICT XML:$uniface_file | Out-Null
	
		# export the conceptual fields and wait for the job to finish 
		Write-Host "Export UCFIELD	- Conceptual Fields"
		& $executable /adm=$administration /cpy /apf /whr="U_VLAB=$uniface_object" IDF:UCFIELD.DICT XML:$uniface_file | Out-Null
	
		# export the conceptual keys and wait for the job to finish 
		Write-Host "Export UCKEY	- Conceptual Keys"
		& $executable /adm=$administration /cpy /apf /whr="U_VLAB=$uniface_object" IDF:UCKEY.DICT XML:$uniface_file | Out-Null
	
		# export the conceptual relationships and wait for the job to finish 
		Write-Host "Export UCRELSH	- Conceptual Table"
		& $executable /adm=$administration /cpy /apf /whr="U_VLAB=$uniface_object" IDF:UCRELSH.DICT XML:$uniface_file | Out-Null
	
		# export the conceptual document types and wait for the job to finish 
		Write-Host "Export UCRELSH	- Conceptual Table"
		& $executable /adm=$administration /cpy /apf /whr="UMODELNAME=$uniface_object" IDF:UCDTYP.DICT XML:$uniface_file | Out-Null

	} elseif ($working_dir.EndsWith("entities")){
		# application models 
	
		# export the conceptual schema and wait for the job to finish 
		Write-Host "Export UCGROUP	- Conceptual Entities"
		& $executable /adm=$administration /cpy /whr="U_VLAB=$appl_model;U_GLAB=$uniface_object" IDF:UCGROUP.DICT XML:$uniface_file | Out-Null

		# export the conceptual fields and wait for the job to finish 
		Write-Host "Export UCFIELD	- Conceptual Fields"
		& $executable /adm=$administration /cpy /apf /whr="U_VLAB=$appl_model;U_GLAB=$uniface_object" IDF:UCFIELD.DICT XML:$uniface_file | Out-Null
	
		# export the conceptual keys and wait for the job to finish 
		Write-Host "Export UCKEY	- Conceptual Keys"
		& $executable /adm=$administration /cpy /apf /whr="U_VLAB=$appl_model;U_GLAB=$uniface_object" IDF:UCKEY.DICT XML:$uniface_file | Out-Null
	
		# export the conceptual relationships and wait for the job to finish 
		Write-Host "Export UCRELSH	- Conceptual Table"
		& $executable /adm=$administration /cpy /apf /whr="U_VLAB=$appl_model;U_GLAB=$uniface_object" IDF:UCRELSH.DICT XML:$uniface_file | Out-Null
	
	} elseif ($working_dir.EndsWith("projects")){
		# components #
		# clean the form and wait for the job to finish
		Write-Host "Clean component"
		& $executable "/adm=$administration /cln $uniface_object" | Out-Null
	
		# export the form and wait for the job to finish
		Write-Host "Export UFORM   - Component Definition"
		& $executable /adm=$administration /cpy /whr="ULABEL=$uniface_object;UINHERIT=F;UTRANSACT=0" IDF:UFORM.DICT XML:$uniface_file | Out-Null
	
		# export the UXGROUP and wait for the job to finish
		Write-Host "Export UXGROUP - Component Entities"
		& $executable /adm=$administration /cpy /apf /whr="UFORM=$uniface_object" IDF:UXGROUP.DICT XML:$uniface_file | Out-Null
	
		# export the UXFIELD and wait for the job to finish
		Write-Host "Export UXFIELD - Component Fields"
		& $executable /adm=$administration /cpy /apf /whr="UFORM=$uniface_object" IDF:UXFIELD.DICT XML:$uniface_file | Out-Null
	
		# export the UXREGS and wait for the job to finish
		Write-Host "Export UXREGS  - Component Variables"
		& $executable /adm=$administration /cpy /apf /whr="U_FORMLIB=$uniface_object" IDF:UXREGS.DICT XML:$uniface_file | Out-Null
	
	} elseif ($working_dir.EndsWith("templates")){
		# export the UGFIF and wait for the job to finish
		Write-Host "Export UGFIF  - Field Interface Templates"
		& $executable /adm=$administration /cpy /whr="U_MLAB=>=MIS_A&<=MIS_Z" IDF:UGFIF.DICT XML:$uniface_file | Out-Null
	
		# export the UGFSYN and wait for the job to finish
		Write-Host "Export UGFSYN - Field Syntax Templates"
		& $executable /adm=$administration /cpy /apf /whr="U_MLAB=>=MIS_A&<=MIS_Z" IDF:UGFSYN.DICT XML:$uniface_file | Out-Null
	
		# export the UGFLAY and wait for the job to finish
		Write-Host "Export UGFLAY - Field Layout Templates"
		& $executable /adm=$administration /cpy /apf /whr="U_MLAB=>=MIS_A&<=MIS_Z" IDF:UGFLAY.DICT XML:$uniface_file | Out-Null
	
	} elseif ($working_dir.EndsWith("components")){
		# export the UFORM library but with a twist UINHERIT=T in stead of F
	
		# clean the form and wait for the job to finish
		Write-Host "Clean component"
		& $executable /adm=$administration /cln $uniface_object | Out-Null

		# export the form and wait for the job to finish
		Write-Host "Export UFORM   - Component Definition"
		& $executable /adm=$administration /cpy /whr="ULABEL=$uniface_object" IDF:UFORM.DICT XML:$uniface_file | Out-Null
	
		# export the UXGROUP and wait for the job to finish
		Write-Host "Export UXGROUP - Component Entities"
		& $executable /adm=$administration /cpy /apf /whr="UFORM=$uniface_object" IDF:UXGROUP.DICT XML:$uniface_file | Out-Null
	
		# export the UXFIELD and wait for the job to finish
		Write-Host "Export UXFIELD - Component Fields"
		& $executable /adm=$administration /cpy /apf /whr="UFORM=$uniface_object" IDF:UXFIELD.DICT XML:$uniface_file | Out-Null
	
		# export the UXREGS and wait for the job to finish
		Write-Host "Export UXREGS  - Component Variables"
		& $executable /adm=$administration /cpy /apf /whr="U_FORMLIB=$uniface_object" IDF:UXREGS.DICT XML:$uniface_file | Out-Null
		
	### Library Objects ###		
	} elseif ($working_dir.EndsWith("include_procs")){
		# export the <tablename> 
		Write-Host "Export USOURCE	- Sources Include Procs"
		& $executable /adm=$administration /cpy /apf /whr="UVAR=$appl_model;ULABEL=$uniface_object;USUB=I" IDF:USOURCE.DICT XML:$uniface_file | Out-Null

	} elseif ($working_dir.EndsWith("global_procs")){
		# export the <tablename> 
		Write-Host "Export USOURCE	- Sources Global Procs"
		& $executable /adm=$administration /cpy /apf /whr="UVAR=$appl_model;ULABEL=$uniface_object;USUB=P" IDF:USOURCE.DICT XML:$uniface_file | Out-Null

	} elseif ($working_dir.EndsWith("messages")){
		# export the <tablename> 
		# export the conceptual table and wait for the job to finish 
		Write-Host "Export USOURCE	- Sources Labels and Messages"
		& $executable /adm=$administration /cpy /apf /whr="UVAR=$appl_model;ULABEL=$uniface_object;USUB=M" IDF:USOURCE.DICT XML:$uniface_file | Out-Null

	} elseif ($working_dir.EndsWith("global_vars")){
		# export the <tablename> 
		Write-Host "Export failed - No implementation for $working_dir"	
	} elseif ($working_dir.EndsWith("global_constants")){
		# export the <tablename> 
		Write-Host "Export failed - No implementation for $working_dir"	
	} elseif ($working_dir.EndsWith("glyphs")){
		# export the <tablename> 
		Write-Host "Export failed - No implementation for $working_dir"	
	} elseif ($working_dir.EndsWith("help_texts")){
		# export the <tablename> 
		Write-Host "Export failed - No implementation for $working_dir"	
	} elseif ($working_dir.EndsWith("panels")){
		# export the <tablename> 
		Write-Host "Export failed - No implementation for $working_dir"	
	} elseif ($working_dir.EndsWith("formats")){
		# export the <tablename> 
		Write-Host "Export failed - No implementation for $working_dir"	
	} elseif ($working_dir.EndsWith("menus")){
		# export the <tablename> 
		Write-Host "Export failed - No implementation for $working_dir"	

	### Templates ###		
	} elseif ($working_dir.EndsWith("fieldsyntax")){
		# export the UGFSYN 
		Write-Host "Export UGFSYN - Field Syntax Templates"
		& $executable /adm=$administration /cpy /whr="U_MLAB=$uniface_object" IDF:UGFSYN.DICT XML:$uniface_file | Out-Null
	} elseif ($working_dir.EndsWith("fieldlayout")){
		# export the UGFLAY
		Write-Host "Export UGFLAY - Field Layout Templates"
		& $executable /adm=$administration /cpy /whr="U_MLAB=$uniface_object" IDF:UGFLAY.DICT XML:$uniface_file | Out-Null
	} elseif ($working_dir.EndsWith("fieldinterface")){
		# export the UGFIF		
		Write-Host "Export UGFIF - Field Interface Templates"
		& $executable /adm=$administration /cpy /whr="U_MLAB=$uniface_object" IDF:UGFIF.DICT XML:$uniface_file | Out-Null
		
	} elseif ($working_dir.EndsWith("fieldtemplate")){
		# export the <tablename> 
		Write-Host "Export failed - No implementation for $working_dir"	

	} else {
		# unknown definition 
		Write-Host "Export failed - Unknown definition $working_dir"	
	}
	
	# remove the log file 
	Write-Host "Deleting log files from $working_dir!"
	Remove-Item $working_dir\*.log
	
	# show done and display the screen a little longer 
	Write-Host "Export done!"
#	Start-Sleep -s 5
}
exit
