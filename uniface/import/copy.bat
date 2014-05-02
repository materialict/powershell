REM copy the files to the correct path
echo off

REM init 
set rootfolder=D:\projects\uniface

IF [%rootfolder]==[] echo Value Missing

REM copy the controller and the unifaceController to the root folder of your projects
copy controller.bat %rootfolder% /y
copy unifaceController.ps1 %rootfolder% /y

REM copy the export and import files to the project folders
copy *port.ps1 %rootfolder%\atlas /y
copy *port.ps1 %rootfolder%\crm /y
copy *port.ps1 %rootfolder%\password /y
copy *port.ps1 %rootfolder%\project /y
copy *port.ps1 %rootfolder%\register /y
copy *port.ps1 %rootfolder%\shs /y
copy *port.ps1 %rootfolder%\temp /y
copy *port.ps1 %rootfolder%\test /y
copy *port.ps1 %rootfolder%\uarchitect /y
copy *port.ps1 %rootfolder%\unifacedoc_10 /y
copy *port.ps1 %rootfolder%\user /y

copy export.ps1 %rootfolder%\video /y

