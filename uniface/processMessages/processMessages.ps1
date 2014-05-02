# init 
# Remove all the existing objects 
Write-Host "Deleting previously generated files!"
Remove-Item *.exp
# get the working diretory
$working_directory = Get-Location
Write-Host $working_directory
# create the path to the Excel file
$excel_file = $working_directory.tostring() + "\Messages.xlsx"
Write-Host "Excel file: $excel_file"

# create a new Excel object 
Write-Host "Starting Excel"
$xl = New-Object -comobject Excel.Application 

# show the object 
Write-Host "Show the document"
#$xl.visible = $true
$xl.visible = $false

# open the file with messages
Write-Host "Open the workbook"

#$wb = $xl.Workbooks.open("D:\Dennis\GitHub\uniface\u9604\libraries\messages\work\Messages.xlsx") 
$wb = $xl.Workbooks.open($excel_file) 

Write-Host "Worksheet access"
$ws = $wb.WorkSheets.item("Messages") 

# set the pointer 
$counter = 3

# run from top to bottom 
while ($ws.cells.item($counter,1).Text -ne ""){
	$value = $ws.Cells.Item($counter,2).Text
	Write-Host "Processing... $value"
	
	$nmlibrary   	= $ws.cells.item($counter,1).Text
	$nmmessage   	= $ws.cells.item($counter,2).Text
	$ftdescription 	= $ws.cells.item($counter,3).Text
	$nmvalue_usa	= $ws.cells.item($counter,4).Text
	$nmvalue_nl  	= $ws.cells.item($counter,5).Text
	$nmvalue_f	= $ws.cells.item($counter,6).Text
	$nmvalue_d	= $ws.cells.item($counter,7).Text
	
	# create the filename 
	$nmfile 	= $($nmlibrary.ToLower() + "." + $nmmessage.ToLower() + ".exp")

	# create the content 
	$header = "<?xml version='1.0' encoding='UTF-8' ?>`r`n"
	$header += "<!-- Created by UNIFACE - (C) Compuware Corporation -->`r`n"
	$header += "<!DOCTYPE UNIFACE PUBLIC `"UNIFACE.DTD`" `"UNIFACE.DTD`">`r`n"
	$header += "<UNIFACE release=`"9.6`" xmlengine=`"2.0`">`r`n"
# put in the libary stuff
	$header += "<TABLE>`r`n"
	$header += "<DSC name=`"ULIBR`" model=`"DICT`" system=`"S`" pseudo =`"73`" level=`"1`" noupdate=`"0`"`r`n"
	$header += " rbk=`"0`" ffsql=`"0`" transnr=`"0`" segsize=`"0`" ufocc=`"0`" charset=`".U`">`r`n"
	$header += "<FLD name=`"ULIBRARY`" seqno=`"1`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"16`"`r`n"
	$header += " pointer=`"0`" inum=`"1`" ufocc=`"0`" mandatory=`"yes`" idxnum=`"1`" idxsnr=`"101`" />`r`n"
	$header += "<FLD name=`"UDESCR`" seqno=`"2`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"25`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UTIMESTAMP`" seqno=`"3`" type=`"E`" level=`"2`" pack=`"0`" scale=`"0`" length=`"15`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "</DSC>`r`n"
	$header += "<OCC>`r`n"
	$header += "<DAT name=`"ULIBRARY`">$nmlibrary</DAT>`r`n"
	$header += "<DAT name=`"UTIMESTAMP`">2014-04-01T11:11:23.68</DAT>`r`n"
	$header += "</OCC>`r`n"
	$header += "</TABLE>`r`n"
# put in the message
	$header += "<TABLE>`r`n"
	$header += "<DSC name=`"USOURCE`" model=`"DICT`" system=`"S`" pseudo =`"73`" level=`"1`" noupdate=`"0`"`r`n"
	$header += " rbk=`"0`" ffsql=`"0`" transnr=`"0`" segsize=`"0`" ufocc=`"500`" charset=`".U`">`"`r`n"
	$header += "<FLD name=`"UTIMESTAMP`" seqno=`"1`" type=`"E`" level=`"2`" pack=`"0`" scale=`"0`" length=`"15`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UCOMPSTAMP`" seqno=`"2`" type=`"E`" level=`"2`" pack=`"0`" scale=`"0`" length=`"15`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"USTAT`" seqno=`"3`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"1`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"USUB`" seqno=`"4`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"1`"`r`n"
	$header += " pointer=`"0`" inum=`"2`" ufocc=`"0`" mandatory=`"yes`" idxnum=`"1,2`" idxsnr=`"101,1`" />`r`n"
	$header += "<FLD name=`"UVAR`" seqno=`"5`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"16`"`r`n"
	$header += " pointer=`"0`" inum=`"2`" ufocc=`"0`" mandatory=`"yes`" idxnum=`"1,2`" idxsnr=`"102,2`" />`r`n"
	$header += "<FLD name=`"ULABEL`" seqno=`"6`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"16`"`r`n"
	$header += " pointer=`"0`" inum=`"1`" ufocc=`"0`" mandatory=`"yes`" idxnum=`"1`" idxsnr=`"103`" />`r`n"
	$header += "<FLD name=`"ULAN`" seqno=`"7`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"3`"`r`n"
	$header += " pointer=`"0`" inum=`"1`" ufocc=`"0`" mandatory=`"yes`" idxnum=`"1`" idxsnr=`"104`" />`r`n"
	$header += "<FLD name=`"MSGTYPE`" seqno=`"8`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"1`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UVERS`" seqno=`"9`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"12`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UDESCR`" seqno=`"10`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"25`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UVPOS`" seqno=`"11`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"6`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UHPOS`" seqno=`"12`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"6`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UVSIZ`" seqno=`"13`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"6`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UHSIZ`" seqno=`"14`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"6`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"AUTHORIZ`" seqno=`"15`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"1`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UCLASS`" seqno=`"16`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"1`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"LOCREF`" seqno=`"17`" type=`"S`" level=`"2`" pack=`"0`" scale=`"0`" length=`"1`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UCONFIRM`" seqno=`"18`" type=`"B`" level=`"2`" pack=`"0`" scale=`"0`" length=`"1`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UAUDIO`" seqno=`"19`" type=`"N`" level=`"2`" pack=`"10`" scale=`"0`" length=`"1`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" />`r`n"
	$header += "<FLD name=`"UCOMMENT`" seqno=`"20`" type=`"S`" level=`"2`" pack=`"141`" scale=`"0`" length=`"0`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" varinfo=`",0,0,0,,1,0,1,\1D,0,0,0,,`" />`r`n"
	$header += "<FLD name=`"UTEXT`" seqno=`"21`" type=`"S`" level=`"2`" pack=`"141`" scale=`"0`" length=`"0`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" varinfo=`",1,0,1,\1E,0,0,0,,0,0,0,,`" />`r`n"
	$header += "<FLD name=`"UWLEVEL`" seqno=`"22`" type=`"S`" level=`"2`" pack=`"141`" scale=`"0`" length=`"0`"`r`n"
	$header += " pointer=`"0`" inum=`"0`" ufocc=`"0`" varinfo=`",1,0,2,\1F\C1,0,0,0,,0,0,0,,`" />`r`n"
	$header += "</DSC>`r`n"

	# USA is allways filled 
	if ($nmvalue_usa -ne ""){
		$record = "<OCC>`r`n"
		$record += "<DAT name=`"UTIMESTAMP`">2014-02-16T09:45:01.47</DAT>`r`n"
		$record += "<DAT name=`"USUB`">M</DAT>`r`n"
		$record += "<DAT name=`"UVAR`">$nmlibrary</DAT>`r`n"
		$record += "<DAT name=`"ULABEL`">$nmmessage</DAT>`r`n"
		$record += "<DAT name=`"ULAN`">USA</DAT>`r`n"
		$record += "<DAT name=`"MSGTYPE`">M</DAT>`r`n"
		$record += "<DAT name=`"UDESCR`">$ftdescription</DAT>`r`n"
		$record += "<DAT name=`"UCONFIRM`">F</DAT>`r`n"
		$record += "<DAT name=`"UAUDIO`">0</DAT>`r`n"
		$record += "<DAT name=`"UTEXT`">$nmvalue_usa</DAT>`r`n"
		$record += "</OCC>`r`n"
	}
	if ($nmvalue_nl -ne ""){
		$record += "<OCC>`r`n"
		$record += "<DAT name=`"UTIMESTAMP`">2014-02-16T09:45:01.47</DAT>`r`n"
		$record += "<DAT name=`"USUB`">M</DAT>`r`n"
		$record += "<DAT name=`"UVAR`">$nmlibrary</DAT>`r`n"
		$record += "<DAT name=`"ULABEL`">$nmmessage</DAT>`r`n"
		$record += "<DAT name=`"ULAN`">NL</DAT>`r`n"
		$record += "<DAT name=`"MSGTYPE`">M</DAT>`r`n"
		$record += "<DAT name=`"UDESCR`">$ftdescription</DAT>`r`n"
		$record += "<DAT name=`"UCONFIRM`">F</DAT>`r`n"
		$record += "<DAT name=`"UAUDIO`">0</DAT>`r`n"
		$record += "<DAT name=`"UTEXT`">$nmvalue_nl</DAT>`r`n"
		$record += "</OCC>`r`n"
	}
	if ($nmvalue_f -ne ""){
		$record += "<OCC>`r`n"
		$record += "<DAT name=`"UTIMESTAMP`">2014-02-16T09:45:01.47</DAT>`r`n"
		$record += "<DAT name=`"USUB`">M</DAT>`r`n"
		$record += "<DAT name=`"UVAR`">$nmlibrary</DAT>`r`n"
		$record += "<DAT name=`"ULABEL`">$nmmessage</DAT>`r`n"
		$record += "<DAT name=`"ULAN`">F</DAT>`r`n"
		$record += "<DAT name=`"MSGTYPE`">M</DAT>`r`n"
		$record += "<DAT name=`"UDESCR`">$ftdescription</DAT>`r`n"
		$record += "<DAT name=`"UCONFIRM`">F</DAT>`r`n"
		$record += "<DAT name=`"UAUDIO`">0</DAT>`r`n"
		$record += "<DAT name=`"UTEXT`">$nmvalue_f</DAT>`r`n"
		$record += "</OCC>`r`n"
	}

	if ($nmvalue_d -ne ""){
		$record += "<OCC>`r`n"
		$record += "<DAT name=`"UTIMESTAMP`">2014-02-16T09:45:01.47</DAT>`r`n"
		$record += "<DAT name=`"USUB`">M</DAT>`r`n"
		$record += "<DAT name=`"UVAR`">$nmlibrary</DAT>`r`n"
		$record += "<DAT name=`"ULABEL`">$nmmessage</DAT>`r`n"
		$record += "<DAT name=`"ULAN`">D</DAT>`r`n"
		$record += "<DAT name=`"MSGTYPE`">M</DAT>`r`n"
		$record += "<DAT name=`"UDESCR`">$ftdescription</DAT>`r`n"
		$record += "<DAT name=`"UCONFIRM`">F</DAT>`r`n"
		$record += "<DAT name=`"UAUDIO`">0</DAT>`r`n"
		$record += "<DAT name=`"UTEXT`">$nmvalue_d</DAT>`r`n"
		$record += "</OCC>`r`n"
	}
	
	$footer = "</TABLE>`r`n" 
	$footer += "</UNIFACE>"

	# dump it
	$($header + "`r`n" + $record + "`r`n" + $footer) | out-file $nmfile
	
	#Next 
	$counter++ 
}

## clean up
Write-Host "Closing"
$wb.Close()
$xl.Quit()
exit
