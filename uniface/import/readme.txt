Files
-----
cmd.bat			- Batch file that starts a dos command box
controller.bat		- Batch file that runs the unifacecontroller.ps1
copy.bat		- batch file that copies all the files to their correct location
create.bat		- Batch file that creates the export folders in your project folder 
export.ps1		- Powershell script that exports the Uniface object.
import.ps1		- Powershell script that imports the Uniface object
readme.txt		- This file
test.bat		- Batch file that tests the correct working of the controller script.
unifaceController.ps1	- Powershell script that is the main entry point (therefore controller) for your import and export commands
unifacEdit.reg		- Registry settings to allow you to edit your export files using a text editor from the context menu
unifaceExportFile.reg	- Registry settings for the export via the context menu
unifaceImportFile.reg	- Registry settings for the import via the context menu

processMessages.bat	- Starts the processMesages.ps1 file
processMessages.ps1	- Analyses the content of the Messages.xlsx and creates message export file per message
Messages.xslx		- Microsoft excel file with Uniface messages

Prerequisites 
-------------
These script are based on the assumption that you have one folder where all your Uniface projects reside. For instance 

Root <-- location for the unifacecontroller.ps1 and the controller.bat
  |
  --- Project 1 <-- import.ps1 and export.ps1 go here  
  |
  --- Project 2 <-- import.ps1 and export.ps1 go here (as well)
  | 
  --- etc.

Furthermore the projects are assumed to have identical structures for the export. 
Project 1
  |
  --- Components <-- Forms, services, reports etc.
  |
  --- Libraries <-- Libraries as one object. In future we may start exporting individual objects
  | 
  --- models	<-- application models as one object. There is no intention to split these. 


How it works
------------
- Copy the controller.bat and the unifacecontroller.ps1 to the root folder of all your Uniface projects (not the project folder but on level up). 
- Copy the import and export script files to the project roots (each project should have both scripts in its projects. 
- Edit the controller script to include the name of the project (foldername) and the paths to the uniface executable and the administration folder. This script doesnot yet allow the use of seperate IDF and ASN files. Both should be in the administration folder
- update the registry to include the export and import option in the context menu by doubleclicking the registry files

Setting the execution policy
----------------------------
In order for powershell scripts to work they need to be enabled in your Windows environment. 

- Setting the policy in powershell requires you to run powershell as an administrator (rightclick powershell in the menu and select run as administrator)
- In the console type: Set-ExecutionPolicy RemoteSigned
- This command will have sam security consequences. We rather prefer you use the command: Set-ExecutionPolicy AllSigned
- Because this is a free script we didnot contact verisign to get a certificate so you can run it as a trusted service. If you would like to create one please follow the instructions here: http://technet.microsoft.com/en-us/library/ee176949.aspx

Disclaimer
----------
The scripts in this folder are provided as is. Use of these scripts are at your own risk. Vorst-Informatisering will not take any responsibillity for damages brrought on to your system through the use of one of these scripts. 