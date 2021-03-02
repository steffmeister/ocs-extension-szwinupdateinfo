' Plugin for OCS Inventory NG 2.x
' Script : Windows Update Info
' Version : 1.0
' Date : 04/10/2020
' Authors : Stefan ZIDAR
'----------------------------------------------------------
' OS checked [X] on	32b	64b	(Professionnal edition)
'	Windows XP		[ ]
'	Windows Vista	[ ]	[ ]
'	Windows 7		[ ]	[ ]
'	Windows 8.1		[ ]	[ ]	
'	Windows 10		[ ]	[X]
'	Windows 2k8R2		[ ]
'	Windows 2k12R2		[ ]
'	Windows 2k16		[ ]
' ---------------------------------------------------------
' NOTE : No checked on Windows 8
' ---------------------------------------------------------
Option Explicit
On Error Resume Next

'====================================================

dim objShell, objExecObject, strText

Set objShell = WScript.CreateObject("WScript.Shell")
Set objExecObject = objShell.Exec("wmic qfe list full")
dim lastUpdateDate
dim currentUpdateDate
Do While Not objExecObject.StdOut.AtEndOfStream
    strText = objExecObject.StdOut.ReadLine()
	if (instr(1, strText, "InstalledOn=")) then
		
		currentUpdateDate = mid(strText, Len("InstalledOn=")+1)
		'wscript.echo currentUpdateDate + "-" + lastUpdateDate
		
		if (datediff("d", lastUpdateDate, currentUpdateDate) > 1) then
			lastUpdateDate = currentUpdateDate
		end if
		
		
	end if
    
Loop

wscript.echo "<SZWINUPDATEINFO><LASTUPDATE>" + lastUpdateDate + "</LASTUPDATE></SZWINUPDATEINFO>"