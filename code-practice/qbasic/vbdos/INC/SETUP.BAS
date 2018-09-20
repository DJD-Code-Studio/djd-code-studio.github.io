' ------------------------------------------------------------------------
' Visual Basic for MS-DOS Setup Toolkit
'
' SETUP.BAS - startup file for Setup program.
'
' The Setup Toolkit is designed to be modified by you to
' create Setup programs for your applications.  The toolkit
' is provided in source code form and with only minor
' modifications, you can change the text that is displayed
' to the user and the files that are installed.  With more
' work, you can add custom features to the Setup Toolkit.
'
' To change messages and files to install, simply modify the
' values found in the InitSetup procedure in SETUP.BAS.
'
' The default Visual Basic library (VBDOS.LIB) and
' Quick library (VBDOS.QLB) are required to create
' and run your Setup program.  Use the /L command-line
' switch to use VBDOS.QLB in the programming environment.
'
' Copyright (C) 1982-1992 Microsoft Corporation
'
' You have a royalty-free right to use, modify, reproduce
' and distribute the sample applications and toolkits provided with
' Visual Basic for MS-DOS (and/or any modified version)
' in any way you find useful, provided that you agree that
' Microsoft has no warranty, obligations or liability for
' any of the sample applications or toolkits.
' ------------------------------------------------------------------------

' Include files containing declarations for called procedures
'$INCLUDE: 'VBDOS.BI'

OPTION BASE 1

' Setup toolkit forms.
'$FORM frmMessage
'$FORM frmPath
'$FORM frmOption
'$FORM frmStatus

' Constant definitions.
CONST FALSE = 0
CONST TRUE = NOT FALSE
CONST LEFT_JUSTIFY = 0
CONST RIGHT_JUSTIFY = 1
CONST CENTERED = 2


TYPE TheFilesArray
	FileName AS STRING * 12
	InstallOption AS INTEGER
	Disk AS INTEGER
END TYPE

' Procedure declarations.
DECLARE SUB CenterForm (x AS FORM)
DECLARE FUNCTION CopyFile (BYVAL SourcePath AS STRING, BYVAL DestinationPath AS STRING, BYVAL FileName AS STRING) AS INTEGER
DECLARE FUNCTION CreatePath (BYVAL DestPath$) AS INTEGER
DECLARE FUNCTION FileExists (path$) AS INTEGER
DECLARE FUNCTION GetDiskSpaceFree (Drive AS STRING) AS LONG
DECLARE FUNCTION GetDrivesAllocUnit (Drive AS STRING) AS LONG
DECLARE FUNCTION GetFileSize (source$) AS LONG
DECLARE SUB InitSetup ()
DECLARE FUNCTION IsValidPath (DestPath$, BYVAL DefaultDrive$) AS INTEGER
DECLARE FUNCTION PromptForNextDisk (wDiskNum AS INTEGER, FileToLookFor$) AS INTEGER
DECLARE FUNCTION SetFileDateTime (SourceFile AS STRING, DestinationFile AS STRING) AS INTEGER
DECLARE SUB Setup ()
DECLARE SUB ShowMessageDialog (MessageText$, MessageAlignment%, outButton$, fUseTwoButtons%)
DECLARE SUB ShowOptionDialog (title$, NumOptions%, OptionName() AS STRING, HelpTxt$, outButton$)
DECLARE SUB ShowPathDialog (title$, caption1$, caption2$, DefaultDrive$, defaultDir$, SourcePath$, outButton$)
DECLARE SUB ShowStatusDialog (title$, totalBytes AS LONG)
DECLARE SUB UpdateStatus (FileLen AS LONG)


DIM SHARED DestPath$                    ' User supplied destination path.
DIM SHARED DefaultDrive$                ' Default destination drive.
DIM SHARED SourcePath$                  ' User supplied source path.
DIM SHARED TotalBytesNeeded  AS LONG    ' The number of bytes that all of your files will use.
DIM SHARED Choice() AS INTEGER          ' Dim this array, it will be REDIM'ed later.
DIM SHARED OptionName() AS STRING       ' Dim this array, it will be REDIM'ed later.
DIM SHARED DialogCaption$               ' This is the caption displayed in the Title of all the dialogs (forms).
DIM SHARED DefaultDestDrive$            ' This is the default destination drive where files will be copied to.
DIM SHARED DefaultDestDir$              ' This is the default destination drive where files will be copied to.
DIM SHARED NumOptions%                  ' This is if you would like to allow a user to install part of your application.
DIM SHARED NumOfDisks%                  ' Number of Disks that your setup application expects.
DIM SHARED NumOfFiles%                  ' Number of Files that will be installed.
DIM SHARED IntroMessage$                ' This is the message used in the opening/welcome screen.
DIM SHARED IntroMessageAlignment%       ' The alignment of the text in the intro screen.
DIM SHARED AppName$                     ' The name of this program.
DIM SHARED ExitMessage$                 ' This is the message used in the exit/closing screen.
DIM SHARED ExitMessageAlignment%        ' The alignment of the text in the exit screen.
DIM SHARED HelpTxt$                     ' Help text for Option screen.
DIM SHARED InstallFiles() AS TheFilesArray  ' List of files to install.


' Create your own Setup program by changing
' initialization information in this procedure.
CALL InitSetup


' Perform setup.
CALL Setup


END

' Positions a form just above center on the screen.
'
SUB CenterForm (x AS FORM)
  
	Screen.Mousepointer = 11
	x.top = (Screen.height * .85) / 2 - x.height / 2
	x.Left = Screen.Width / 2 - x.Width / 2
	Screen.Mousepointer = 0

END SUB

' Copies file Filename from SourcePath to DestinationPath.
'
' Returns FALSE if an error occurs, otherwise returns TRUE.
'
FUNCTION CopyFile (BYVAL SourcePath AS STRING, BYVAL DestinationPath AS STRING, BYVAL FileName AS STRING) AS INTEGER
	DIM Index AS INTEGER
	DIM FileLength AS LONG
	DIM LeftOver AS LONG
	DIM FileData AS STRING
	DIM NumBlocks AS LONG
	DIM x AS INTEGER

	Screen.Mousepointer = 11
	IF RIGHT$(SourcePath$, 1) <> "\" THEN
		SourcePath$ = SourcePath$ + "\"            'Add ending \ symbols to path variables
	END IF
	IF RIGHT$(DestinationPath$, 1) <> "\" THEN
		DestinationPath$ = DestinationPath$ + "\"   'Add ending \ symbols to path variables
	END IF
	
	'Update status dialog info
	'
	frmStatus.lblCopyFrom.Caption = "Source file: " + CHR$(10) + CHR$(13) + UCASE$(SourcePath$ + FileName$)
	frmStatus.lLblCopyFrom.REFRESH
	frmStatus.lblCopyTo.Caption = "Destination file: " + CHR$(10) + CHR$(13) + UCASE$(DestinationPath$ + FileName$)
	frmStatus.lblCopyTo.REFRESH

	IF NOT FileExists(SourcePath$ + FileName$) THEN
		MSGBOX ERROR$(75) + ": """ + SourcePath$ + FileName$ + """", 0, DialogCaption$
		GOTO ErrorCopy
	END IF
	
	ON LOCAL ERROR GOTO ErrorCopy


	'Copy the file
	'
	CONST BlockSize = 32768
	
	OPEN SourcePath$ + FileName$ FOR BINARY ACCESS READ AS #1

	OPEN DestinationPath$ + FileName$ FOR OUTPUT AS #2
	CLOSE #2

	OPEN DestinationPath$ + FileName$ FOR BINARY AS #2
	
	FileLength = LOF(1)
	
	NumBlocks = FileLength \ BlockSize
	LeftOver = FileLength MOD BlockSize
	
	FileData = STRING$(LeftOver, 32)
	
	GET #1, , FileData
	PUT #2, , FileData
	
	FileData = STRING$(BlockSize / 2, 32)

	FOR Index = 1 TO (NumBlocks * 2)
		GET #1, , FileData
		PUT #2, , FileData
	NEXT Index
	
	FileData = ""    ' Free up String Allocation
	CLOSE #1, #2
	UpdateStatus FileLength
	x = SetFileDateTime(SourcePath$ + FileName$, DestinationPath$ + FileName$)

SkipCopy:
	CopyFile = TRUE
ExitCopyFile:
	Screen.Mousepointer = 0
	EXIT FUNCTION
	
ErrorCopy:
	CopyFile = FALSE
	CLOSE
	Screen.Mousepointer = 0
	EXIT FUNCTION
END FUNCTION

' Create the path contained in DestPath$.
' First char must be drive letter, followed by
' a ":\" followed by the path, if any.
'
FUNCTION CreatePath (BYVAL DestPath$) AS INTEGER
	DIM BackPos AS INTEGER
	DIM ForePos AS INTEGER
	DIM temp$

	Screen.Mousepointer = 11

	IF RIGHT$(DestPath$, 1) <> "\" THEN
		DestPath$ = DestPath$ + "\"        'Add slash to end of path if not there already
	END IF
	  

	'Change to the root dir of the drive
	'
	ON ERROR RESUME NEXT
	CHDRIVE DestPath$
	IF ERR <> 0 THEN GOTO errorOut
	CHDIR "\"

	'Attempt to make each directory, then change to it
	'
	BackPos = 3
	ForePos = INSTR(4, DestPath$, "\")
	DO WHILE ForePos <> 0
		temp$ = MID$(DestPath$, BackPos + 1, ForePos - BackPos - 1)

		ERR = 0
		MKDIR temp$
		IF ERR <> 0 AND ERR <> 75 THEN GOTO errorOut

		ERR = 0
		CHDIR temp$
		IF ERR <> 0 THEN GOTO errorOut

		BackPos = ForePos
		ForePos = INSTR(BackPos + 1, DestPath$, "\")
	LOOP
		 
	CreatePath = TRUE
	Screen.Mousepointer = 0
	EXIT FUNCTION
		 
errorOut:
	Screen.Mousepointer = 0
	MSGBOX "Can't create destination directory.", 0, DialogCaption$
	CreatePath = FALSE
	
END FUNCTION

' Check for the existence of a file by attempting an OPEN.
'
FUNCTION FileExists (path$) AS INTEGER
	DIM x AS INTEGER

	x = FREEFILE

	ON ERROR RESUME NEXT
	OPEN path$ FOR INPUT AS x
	IF ERR = 0 THEN
		FileExists = TRUE
	ELSE
		FileExists = FALSE
	END IF
	CLOSE x

END FUNCTION

' Get free disk space for the specified drive.
'
' Note: CALL INTERRUPT is used to obtain free disk
' space which requires VBDOS.QLB (VBDOS.LIB) to
' be loaded.
'
FUNCTION GetDiskSpaceFree (Drive AS STRING) AS LONG
	DIM CurDrv$
	DIM regs AS RegType                    ' Define registers
	DIM SectorsInCluster AS LONG
	DIM BytesInSector AS LONG
	DIM ClustersInDrive AS LONG
	DIM ClustersAvailable AS LONG

	CurDrv$ = CURDIR$
	CHDRIVE Drive$

	' Get current drive info; set up input and do system call
	regs.ax = &H1900
	CALL INTERRUPT(&H21, regs, regs)
 
	' Convert drive info to readable form
	Drive$ = CHR$((regs.ax AND &HFF) + 65) + ":"
 
	' Get disk free space; set up input values and do system call
	regs.ax = &H3600
	regs.dx = ASC(UCASE$(Drive$)) - 64
	CALL INTERRUPT(&H21, regs, regs)
 
	' Decipher the results
	SectorsInCluster = regs.ax
	BytesInSector = regs.cx
	IF regs.dx >= 0 THEN
		ClustersInDrive = regs.dx
	ELSE
		ClustersInDrive = regs.dx + 65536
	END IF
	IF regs.bx >= 0 THEN
		ClustersAvailable = regs.bx
	ELSE
		ClustersAvailable = regs.bx + 65536
	END IF
	GetDiskSpaceFree = ClustersAvailable * SectorsInCluster * BytesInSector
	CHDRIVE CurDrv$
END FUNCTION

' Get the disk Allocation unit for the current drive.
'
' Note: CALL INTERRUPT is used to obtain free disk
' space which requires VBDOS.QLB (VBDOS.LIB) to
' be loaded.
'
FUNCTION GetDrivesAllocUnit (Drive AS STRING) AS LONG
	DIM CurDrv$
	DIM regs AS RegType                    ' Define registers
	DIM SectorsInCluster AS LONG
	DIM BytesInSector AS LONG
	DIM ClustersInDrive AS LONG
	DIM ClustersAvailable AS LONG

	CurDrv$ = CURDIR$
	CHDRIVE Drive$

	' Get current drive info; set up input and do system call
	regs.ax = &H1900
	CALL INTERRUPT(&H21, regs, regs)

	' Convert drive info to readable form
	Drive$ = CHR$((regs.ax AND &HFF) + 65) + ":"

	' Get drive allocation unit; set up input values and do system call
	regs.ax = &H1C00
	regs.dx = ASC(UCASE$(Drive$)) - 64
	CALL INTERRUPT(&H21, regs, regs)

	' Decipher the results
	SectorsInCluster = regs.ax AND &HFF
	BytesInSector = regs.cx
	IF regs.dx >= 0 THEN
		ClustersInDrive = regs.dx
	ELSE
		ClustersInDrive = regs.dx + 65536
	END IF
	IF regs.bx >= 0 THEN
		ClustersAvailable = regs.bx
	ELSE
		ClustersAvailable = regs.bx + 65536
	END IF
	GetDrivesAllocUnit = SectorsInCluster * BytesInSector
	CHDRIVE CurDrv$
END FUNCTION

' Get the size of the Source$ file.
'
FUNCTION GetFileSize (source$) AS LONG
	DIM x AS INTEGER

	x = FREEFILE
	OPEN source$ FOR BINARY ACCESS READ AS x
	GetFileSize = LOF(x)
	CLOSE x
END FUNCTION

' Setup initialization routine.
' Defines setup messages and files to install.
'
SUB InitSetup ()

	'******************************************
	' Modify the colors, messages and files to
	' install listed here to create a Setup
	' program for your application.
	'******************************************


	' Name of the application to be installed.
	AppName$ = "Sample Program"
	DialogCaption$ = AppName$ + " Setup"               ' This is the caption displayed in the Title of all the dialogs (forms).

	' Setup colors and display characteristics.
	Screen.controlpanel(5) = 1      ' Set up default DESKTOP_BACKCOLOR.
	Screen.controlpanel(6) = 7      ' Set up default DESKTOP_FORECOLOR.
	Screen.controlpanel(7) = 176    ' Set up default DESKTOP_PATTERN as the block character.
	Screen.controlpanel(16) = 5     ' Set up default TITLEBAR_BACKCOLOR.
	Screen.controlpanel(17) = 15    ' Set up default TITLEBAR_FORECOLOR.


	' Introduction message.  Displayed before files are installed.
	IntroMessageAlignment% = LEFT_JUSTIFY   ' Alignment can be CENTERED, LEFT_JUSTIFY, or RIGHT_JUSTIFY.
	IntroMessage$ = "Setup program for '" + AppName$ + "'." + CHR$(13)
	IntroMessage$ = IntroMessage$ + CHR$(13)
	IntroMessage$ = IntroMessage$ + "The Setup Toolkit is designed to be modified by you to" + CHR$(13)
	IntroMessage$ = IntroMessage$ + "create Setup programs for your applications.  The toolkit" + CHR$(13)
	IntroMessage$ = IntroMessage$ + "is provided in source code form and with only minor" + CHR$(13)
	IntroMessage$ = IntroMessage$ + "modifications, you can change the text that is displayed" + CHR$(13)
	IntroMessage$ = IntroMessage$ + "to the user and the files that are installed.  With more" + CHR$(13)
	IntroMessage$ = IntroMessage$ + "work, you can add custom features to the Setup Toolkit." + CHR$(13)
	IntroMessage$ = IntroMessage$ + CHR$(13)
	IntroMessage$ = IntroMessage$ + "To change messages and files to install, simply modify the" + CHR$(13)
	IntroMessage$ = IntroMessage$ + "values found in the InitSetup procedure in SETUP.BAS."


	' Exit message.  Displayed after files are installed.
	ExitMessageAlignment% = LEFT_JUSTIFY    ' Alignment can be CENTERED, LEFT_JUSTIFY, or RIGHT_JUSTIFY.
	ExitMessage$ = AppName$ + " installation is complete."
	

	' Default destination for files to be installed.
	DefaultDestDrive$ = "C:"
	DefaultDestDir$ = "C:\TESTAPP"


	' Available disk space required to install your files (in bytes).
	TotalBytesNeeded = 49000


	' Number of install options.
	NumOptions% = 3
	REDIM OptionName(1 TO NumOptions%) AS STRING    ' Dimension array to hold option text.

	' Install option text displayed to use on options screen.
	OptionName(1) = "Install Setup Toolkit .BAS file"
	OptionName(2) = "Install Setup Toolkit .FRM files"
	OptionName(3) = "Install Setup Toolkit .MAK file"

	' Help text for install options.
	HelpTxt$ = "Select the program components you want to install."

	' Number of distribution disks.
	NumOfDisks% = 1

	' Total number of files to install.
	NumOfFiles% = 6

	' Files to install.
	' This array holds information needed to install files.
	' It is an array of a user-defined type that contains
	' the filename, the install option that the file is
	' associated with, and the disk the file is located on.
	' Files that are on disk 1 should be listed first with files
	' on disk 2 listed next and so on.

	' Note, the number of files to install listed here
	' should match value assigned to NumOfFiles% above.

	REDIM InstallFiles(NumOfFiles%) AS TheFilesArray

	InstallFiles(1).FileName = "Setup.bas"
	InstallFiles(1).InstallOption = 1
	InstallFiles(1).Disk = 1

	InstallFiles(2).FileName = "SetupMsg.frm"
	InstallFiles(2).InstallOption = 2
	InstallFiles(2).Disk = 1

	InstallFiles(3).FileName = "SetupOpt.frm"
	InstallFiles(3).InstallOption = 2
	InstallFiles(3).Disk = 1

	InstallFiles(4).FileName = "SetupPth.frm"
	InstallFiles(4).InstallOption = 2
	InstallFiles(4).Disk = 1

	InstallFiles(5).FileName = "SetupSts.frm"
	InstallFiles(5).InstallOption = 2
	InstallFiles(5).Disk = 1

	InstallFiles(6).FileName = "Setup.mak"
	InstallFiles(6).InstallOption = 3
	InstallFiles(6).Disk = 1

END SUB

' Determines if specified path is valid.
'
' If DestPath$ does not include a drive specification,
' DefaultDrive$ is used.
'
' When IsValidPath is finished, DestPath$ has the following
' format "X:\dir\dir\dir\"
'
' Returns TRUE if path is valid, otherwise returns FALSE.
'
FUNCTION IsValidPath (DestPath$, BYVAL DefaultDrive$) AS INTEGER
	DIM temp$
	DIM Drive$
	DIM LegalChar$
	DIM BackPos AS INTEGER
	DIM ForePos AS INTEGER
	DIM I AS INTEGER
	DIM PeriodPos AS INTEGER
	DIM Length AS INTEGER

	DestPath$ = RTRIM$(LTRIM$(DestPath$))       'Remove left and right spaces
	
	'Check Default Drive Parameter
	'
	IF RIGHT$(DefaultDrive$, 1) <> ":" OR LEN(DefaultDrive$) <> 2 THEN
		MSGBOX "Bad default drive parameter specified in IsValidPath Function.  You passed, """ + DefaultDrive$ + """.  Must be one drive letter and "":"" (i.e. ""C:"").", 0, DialogCaption$
		GOTO parseErr
	END IF
	

	IF LEFT$(DestPath$, 1) = "\" THEN
		DestPath$ = DefaultDrive$ + DestPath$    'Insert default drive if path begins with root backslash
	END IF
	
	ON ERROR RESUME NEXT
	temp$ = DIR$(DestPath$)
	IF ERR <> 0 THEN
		GOTO parseErr                             ' check for invalid characters
	END IF
	

	' Check for wildcard characters and spaces
	'
	IF (INSTR(DestPath$, "*") <> 0) GOTO parseErr
	IF (INSTR(DestPath$, "?") <> 0) GOTO parseErr
	IF (INSTR(DestPath$, " ") <> 0) GOTO parseErr
	 
	
	IF MID$(DestPath$, 2, 1) <> CHR$(58) THEN GOTO parseErr   'Make Sure colon is in second char position
	

	'Insert root backslash if needed
	'
	IF LEN(DestPath$) > 2 THEN
		IF RIGHT$(LEFT$(DestPath$, 3), 1) <> "\" THEN
			DestPath$ = LEFT$(DestPath$, 2) + "\" + RIGHT$(DestPath$, LEN(DestPath$) - 2)
		END IF
	END IF

	Drive$ = LEFT$(DestPath$, 1)
	CHDRIVE (Drive$)                                          ' Try to change to the dest drive
	IF ERR <> 0 THEN GOTO parseErr
	
	IF RIGHT$(DestPath$, 1) <> "\" THEN
		DestPath$ = DestPath$ + "\"                        'Add final \
	END IF
	

	'Root dir is a valid dir
	'
	IF LEN(DestPath$) = 3 THEN
		IF RIGHT$(DestPath$, 2) = ":\" THEN
			GOTO ParseOK
		END IF
	END IF
	

	IF INSTR(DestPath$, "\\") <> 0 THEN GOTO parseErr          'Check for repeated Slash
	
	'Check for illegal directory names
	'
	LegalChar$ = "!#$%&'()-0123456789@ABCDEFGHIJKLMNOPQRSTUVWXYZ^_`{}~."
	BackPos = 3
	ForePos = INSTR(4, DestPath$, "\")
	DO
		temp$ = MID$(DestPath$, BackPos + 1, ForePos - BackPos - 1)
	
		'Test for illegal characters
		'
		FOR I = 1 TO LEN(temp$)
			IF INSTR(LegalChar$, UCASE$(MID$(temp$, I, 1))) = 0 THEN GOTO parseErr
		NEXT I

		'Check combinations of periods and lengths
		'
		PeriodPos = INSTR(temp$, ".")
		Length = LEN(temp$)
		IF PeriodPos = 0 THEN
			IF Length > 8 THEN GOTO parseErr                         'Base too long
		ELSE
		   IF PeriodPos > 9 THEN GOTO parseErr                      'Base too long
		   IF Length > PeriodPos + 3 THEN GOTO parseErr             'Extension too long
		   IF INSTR(PeriodPos + 1, temp$, ".") <> 0 THEN GOTO parseErr'Two periods not allowed
		END IF
			 
		BackPos = ForePos
		ForePos = INSTR(BackPos + 1, DestPath$, "\")
	LOOP UNTIL ForePos = 0

ParseOK:
	IsValidPath = TRUE
	EXIT FUNCTION

parseErr:
	IsValidPath = FALSE
END FUNCTION

' Prompt for the next disk.
' Use the FileToLookFor$ argument to verify that the
' proper disk (disk number wDiskNum) was inserted.
'
FUNCTION PromptForNextDisk (wDiskNum AS INTEGER, FileToLookFor$) AS INTEGER
	DIM Ready AS INTEGER
	DIM temp$
	DIM x AS INTEGER

	Ready = FALSE
	ON ERROR RESUME NEXT
	temp$ = DIR$(FileToLookFor$)                    'Test for file
	
	'If not found, start loop
	'
	IF ERR <> 0 OR LEN(temp$) = 0 THEN
		WHILE NOT Ready
			BEEP
			x = MSGBOX("Please insert disk #" + FORMAT$(wDiskNum%), 1, DialogCaption$)   'Put up msg box
			IF x = 2 THEN
				'-------------------------------
				'User hit cancel, abort the copy
				'-------------------------------
				PromptForNextDisk = FALSE
				GOTO ExitProc
			ELSE
				'----------------------------------------
				'User hits OK, try to find the file again
				'----------------------------------------
				temp$ = DIR$(FileToLookFor$)
				IF ERR = 0 AND LEN(temp$) <> 0 THEN
					PromptForNextDisk = TRUE
					Ready = TRUE
				END IF
			END IF
		WEND
	ELSE
		PromptForNextDisk = TRUE
	END IF

ExitProc:

END FUNCTION

' Set SourceFile's Date and Time to match
' DestinationFile's Date and Time
'
' Note: CALL INTERRUPTX is used to obtain free disk
' space which requires VBDOS.QLB (VBDOS.LIB) to
' be loaded.
'
FUNCTION SetFileDateTime (SourceFile AS STRING, DestinationFile AS STRING) AS INTEGER
	DIM regs1 AS RegTypeX                    ' Define registers
	DIM regs2 AS RegTypeX                    ' Define registers
	DIM fh1%, fh2%
	DIM Result%

	' Get SourceFile date and time
	fh1% = FREEFILE
	OPEN SourceFile FOR INPUT AS fh1%        ' Open file and get handle

	regs1.ax = &H5700
	regs1.bx = FILEATTR(fh1%, 2)
	CALL INTERRUPTX(&H21, regs1, regs1)   ' Get date and time information
	Result% = regs1.flags AND 1
	
	CLOSE fh1%                                ' Close file

	' Get DestinationFile date and time
	fh2% = FREEFILE
	OPEN DestinationFile FOR INPUT AS fh2%    ' Open file and get handle

	regs2.ax = &H5701
	regs2.bx = FILEATTR(fh2%, 2)
	regs2.cx = regs1.cx
	regs2.dx = regs1.dx
	CALL INTERRUPTX(&H21, regs2, regs2)   ' Set date and time information
	Result% = regs2.flags AND 1

	CLOSE fh2%                                ' Close file

	SetFileDateTime = -1
END FUNCTION

' Control procedure for the setup process.
'
SUB Setup ()

	DIM DestSpaceFree AS LONG                    ' Dim disk space variable as Long Integer.
	DIM DefaultSrcDrive$                         ' This is the default source drive where files will be copied from.
	DIM DefaultSrcDir$                           ' This is the default source directory where files will be copied from.
	DIM outButton$                               ' outButton$ is a global variable used to detect if the user is cancelling Setup.
	DIM caption1$                                ' Used by ShowPathDialog
	DIM caption2$                                ' Used by ShowPathDialog
	DIM DestDrive$                               ' Destination drive letter
	DIM SourceDrive$                             ' Source drive letter
	DIM DestAllocUnit AS LONG                    ' Destination drive's allocation unit size, or the minimum disk space that a file will use.
	DIM I%, J%, K%                               ' Loop counters.
	DIM Message$                                 ' Message for errors.
	DIM FileToFind$                              ' The file to look for on the next disk.

	'----------------------------------------------------
	' Set Destination variables with default values
	'----------------------------------------------------
	DefaultSrcDrive$ = LEFT$(CURDIR$, 2)         ' This is the default source drive where files will be copied from.
	DefaultSrcDir$ = CURDIR$                     ' This is the default source directory where files will be copied from.

	'------------------------------------------------------
	' Show opening screen with specified text and alignment
	'------------------------------------------------------
	ShowMessageDialog IntroMessage$, IntroMessageAlignment%, outButton$, TRUE

	IF outButton$ = "exit" THEN GOTO ErrorSetup

	'----------------------------------------------------
	' Get Source path
	'----------------------------------------------------
GetSourcePath:
	caption1$ = "Specify source directory containing the " + AppName$ + " files."
	caption2$ = "Source:"

	ShowPathDialog DialogCaption$, caption1$, caption2$, DefaultSrcDrive$, DefaultSrcDir$, SourcePath$, outButton$

	IF outButton$ = "exit" THEN GOTO ErrorSetup

	'------------------------------
	' Check that SourcePath$ exists
	'------------------------------
	ON ERROR RESUME NEXT
	IF LEN(SourcePath$) > 3 AND RIGHT$(SourcePath$, 1) = "\" THEN
		SourcePath$ = LEFT$(SourcePath$, LEN(SourcePath$) - 1)
	END IF
	CHDRIVE (SourcePath$)
	CHDIR (SourcePath$)
	IF ERR <> 0 THEN
		MSGBOX ERROR$(ERR) + ": " + SourcePath$, 0, DialogCaption$
		ERR = 0
		GOTO GetSourcePath
	END IF
	ON ERROR GOTO 0

	IF RIGHT$(SourcePath$, 1) <> "\" THEN
		SourcePath$ = SourcePath$ + "\"
	END IF

	'--------------------
	' Get Destination Path
	'--------------------
	caption1$ = "Specify destination directory for " + AppName$ + ".  The directory will be created if it does not exist."
	caption2$ = "Destination:"

	ShowPathDialog DialogCaption$, caption1$, caption2$, DefaultDestDrive$, DefaultDestDir$, DestPath$, outButton$

	IF outButton$ = "exit" THEN GOTO ErrorSetup


	'---------------------------------
	'Get Drive Letters of directories
	'---------------------------------
	DestDrive$ = UCASE$(LEFT$(DestPath$, 1))
	SourceDrive$ = UCASE$(LEFT$(SourcePath$, 1))

	'---------------------------------
	'Compute free disk space variable
	'---------------------------------
	DestSpaceFree = GetDiskSpaceFree(DestDrive$)

	'---------------------------------
	'Compute disk allocation unit size
	'---------------------------------
	DestAllocUnit = GetDrivesAllocUnit(DestDrive$)

	'-----------------------------------------
	'Check for enough disk space.
	'-----------------------------------------
	IF DestSpaceFree < TotalBytesNeeded THEN
		MSGBOX "There is not enough disk space on drive " + DestDrive$ + CHR$(13) + "An additional " + FORMAT$(TotalBytesNeeded - DestSpaceFree) + " bytes are needed.", 0, DialogCaption$
		GOTO ErrorSetup
	END IF


	'----------------------------
	'Create destination directory
	'----------------------------
	IF NOT CreatePath(DestPath$) THEN GOTO ErrorSetup


	'-------------------------------------------------------------
	' Sample Option Dialog.  This code and dialog is useful if you
	' would like to give the user the option of installing certain
	' features or sections of your product.  The Option dialog will
	' size itself depending on the number of  options.  If you use
	' the Option dialog, then you will not need to use the copy file
	' section below.
	'--------------------------------------------------------------
	IF NumOptions% <> 0 THEN
		REDIM Choice(1 TO NumOptions%) AS INTEGER

		ShowOptionDialog DialogCaption$, NumOptions%, OptionName(), HelpTxt$, outButton$

		IF outButton$ = "exit" THEN
			GOTO ErrorSetup
		END IF
	END IF

	'-----------------------------------------------------------
	' Show Status Dialog -- This stays up while copying files
	' It is required by the CopyFile routine
	'-----------------------------------------------------------
	ShowStatusDialog DialogCaption$, TotalBytesNeeded


	'-----------------------------------------------------------
	' Copy files, using the PROMPTFORNEXTDISK when you need to have the
	' user insert the next diskette.  See the appropriate procedure
	' to understand their arguments.
	'-----------------------------------------------------------
	FOR I% = 1 TO NumOfDisks%                            ' Loop thru for each disk.
		FOR J% = 1 TO NumOptions%                        ' Loop thru for each Option section.
		IF Choice(J%) <> 0 THEN
			FOR K% = 1 TO NumOfFiles%                    ' Loop thru for each file.
				IF InstallFiles(K%).InstallOption = J% AND InstallFiles(K%).Disk = I% THEN ' If the file pointed to in the array belongs to the current Option section, then copy that file.
					IF NOT CopyFile(SourcePath$, DestPath$, InstallFiles(K%).FileName) THEN
					  ShowMessageDialog "Could not copy file " + InstallFiles(K%).FileName, LEFT_JUSTIFY, outButton$, TRUE
					  IF outButton$ = "exit" THEN GOTO ErrorSetup
					END IF
				END IF
			NEXT K%
		END IF
		NEXT J%
		
		IF NumOfDisks% > 1 THEN                          ' If more than one disk has been specifed, then prompt for next disk.
			FileToFind$ = ""
			FOR K% = 1 TO NumOfFiles%
				IF InstallFiles(K%).Disk = I% + 1 THEN
					FileToFind$ = InstallFiles(K%).FileName
					EXIT FOR
				END IF
			NEXT K%
			IF FileToFind$ <> "" THEN
				IF NOT PromptForNextDisk(I% + 1, SourcePath$ + FileToFind$) THEN GOTO ErrorSetup
			END IF
		END IF
	NEXT I%

	'--------------------------------------------------
	'File Copying is over, so unload the status dialog
	'--------------------------------------------------
	UpdateStatus TotalBytesNeeded
	UNLOAD frmStatus


	'------------------
	'Show Final message
	'------------------
	'------------------------------------------------------
	' Show closing screen with specified text and alignment
	'------------------------------------------------------
	ShowMessageDialog ExitMessage$, ExitMessageAlignment%, outButton$, FALSE

	GOTO ExitNow:

ErrorSetup:
	MSGBOX AppName$ + " is not properly installed on your system." + CHR$(13) + "Run setup again to install " + AppName$ + ".", 0, DialogCaption$

ExitNow:
	SYSTEM

END SUB

' Display setup messages to the user.
'
SUB ShowMessageDialog (MessageText$, MessageAlignment%, outButton$, fUseTwoButtons%)
	LOAD frmMessage

	frmMessage.Caption = DialogCaption$
	frmMessage.LblMessage.Caption = MessageText$
	frmMessage.LblMessage.Alignment = MessageAlignment%
	frmMessage.LblMessage.height = frmMessage.TEXTHEIGHT(frmMessage.LblMessage.Caption)
	frmMessage.LblMessage.Width = frmMessage.TEXTWIDTH(frmMessage.LblMessage.Caption)
	frmMessage.LblMessage.Left = 2
	frmMessage.LblMessage.top = 1

	frmMessage.Width = frmMessage.LblMessage.Width + 8
	frmMessage.height = frmMessage.LblMessage.height + 7

	IF fUseTwoButtons% THEN
		frmMessage.CmdContinue.top = frmMessage.ScaleHeight - 3
		frmMessage.CmdContinue.Left = (frmMessage.ScaleWidth - (frmMessage.CmdContinue.Width + frmMessage.CmdExit.Width + 3)) / 2
		frmMessage.CmdContinue.Cancel = TRUE

		frmMessage.CmdExit.top = frmMessage.ScaleHeight - 3
		frmMessage.CmdExit.Left = frmMessage.CmdContinue.Left + frmMessage.CmdContinue.Width + 2
	ELSE
		frmMessage.CmdContinue.top = frmMessage.ScaleHeight - 3
		frmMessage.CmdContinue.Left = (frmMessage.ScaleWidth - (frmMessage.CmdContinue.Width)) / 2
		frmMessage.CmdContinue.Cancel = TRUE
	END IF
	CenterForm frmMessage

	frmMessage.SHOW 1

	outButton$ = frmMessage.LblMessage.tag
	UNLOAD frmMessage
END SUB

' Display setup options to the user.
'
SUB ShowOptionDialog (title$, NumOptions%, OptionName() AS STRING, HelpTxt$, outButton$)
	DIM x AS INTEGER
	DIM MaxTxtWidth AS INTEGER
	DIM Tmp%

	Screen.Mousepointer = 11
	LOAD frmOption
	frmOption.Caption = title$
	frmOption.tag = HelpTxt$
	MaxTxtWidth = 0
	FOR x = 1 TO NumOptions%
		IF x <> 1 THEN LOAD frmOption.ChkOption(x)
		frmOption.ChkOption(x).Visible = TRUE
		frmOption.ChkOption(x).Caption = OptionName(x)
		frmOption.ChkOption(x).Width = frmOption.TEXTWIDTH(frmOption.ChkOption(x).Caption) + 4  ' The 4 is padding for the checkbox
		IF frmOption.ChkOption(x).Width > MaxTxtWidth THEN MaxTxtWidth = frmOption.ChkOption(x).Width
		IF x <> 1 THEN
			frmOption.ChkOption(x).top = frmOption.ChkOption(x - 1).top + frmOption.ChkOption(x - 1).height
			frmOption.height = frmOption.height + frmOption.ChkOption(x).height
		END IF
	NEXT x
	IF MaxTxtWidth > 70 THEN MaxTxtWidth = 70
	IF MaxTxtWidth > frmOption.Width THEN
		frmOption.Width = MaxTxtWidth + 8
		frmOption.CmdContinue.Left = (frmOption.Width - frmOption.CmdContinue.Width * 3 - 4) / 2
		frmOption.CmdExit.Left = frmOption.CmdContinue.Left + frmOption.CmdContinue.Width + 2
		frmOption.CmdHelp.Left = frmOption.CmdExit.Left + frmOption.CmdExit.Width + 2
	END IF
	frmOption.CmdContinue.top = frmOption.height - (frmOption.CmdContinue.height + 2)
	frmOption.CmdExit.top = frmOption.CmdContinue.top
	frmOption.CmdHelp.top = frmOption.CmdContinue.top

	Screen.Mousepointer = 0

	frmOption.ChkOption(0).tabindex = 0
	CenterForm frmOption

	frmOption.SHOW 1

	FOR x = 1 TO NumOptions%
		IF frmOption.ChkOption(x).Value THEN
			Choice(x) = TRUE
		ELSE
			Choice(x) = FALSE
		END IF
	NEXT x
	outButton$ = frmOption.LblMessage.tag
	UNLOAD frmOption
END SUB

' Display path dialog to user.
'
SUB ShowPathDialog (title$, caption1$, caption2$, DefaultDrive$, defaultDir$, SourcePath$, outButton$)
	Screen.Mousepointer = 11
	LOAD frmPath
	frmPath.Caption = title$
	frmPath.LblMessage.Caption = caption1$
	frmPath.LblPrompt.Caption = caption2$
	frmPath.LblInDrive.tag = DefaultDrive$
	frmPath.TxtPath.text = defaultDir$
	frmPath.TxtPath.Selstart = 0
	frmPath.TxtPath.Sellength = LEN(defaultDir$)
	CenterForm frmPath
	Screen.Mousepointer = 0

	frmPath.SHOW 1

	SourcePath$ = frmPath.LblOutPath.tag
	outButton$ = frmPath.LblMessage.tag
	UNLOAD frmPath
END SUB

' Display setup status to user.
'
SUB ShowStatusDialog (title$, totalBytes AS LONG)
	LOAD frmStatus
	frmStatus.Caption = title$
	frmStatus.LblTotal.tag = STR$(totalBytes)
	CenterForm frmStatus
	frmStatus.SHOW
END SUB

' Update the status bar on setup status form (frmStatus).
'
SUB UpdateStatus (FileLen AS LONG)
	STATIC Position
	DIM estTotal AS LONG
	DIM poslen%
	CONST Pic1Width = 33
	DIM tempstr$
	DIM fillstr$

	ON LOCAL ERROR GOTO UpdateStatusErr

	estTotal = VAL(frmStatus.LblTotal.tag)
	IF estTotal = FALSE THEN
		estTotal = 10000000
	END IF

	Position = Position + (Pic1Width * CSNG((FileLen) / estTotal))
	IF Position > Pic1Width THEN
		Position = Pic1Width
	END IF
	
	frmStatus.PicStatus.CLS

	poslen% = LEN(STR$(INT(Position)))
	tempstr$ = STRING$(Position, CHR$(219))
	IF LEN(tempstr$) < frmStatus.PicStatus.Width THEN
		fillstr$ = STRING$(frmStatus.PicStatus.Width - LEN(tempstr$), CHR$(0))
		tempstr$ = tempstr$ + fillstr$
	END IF
	
	' When the status reaches the label, set the
	' Labels' backcolor to match the picture's
	' forecolor
	'
	IF Position > 14 THEN
		frmStatus.LblPercent.BackColor = frmStatus.PicStatus.ForeColor
	END IF

	frmStatus.LblPercent.Caption = LTRIM$(STR$(INT((Position / Pic1Width) * 100))) + "%"
	frmStatus.LblPercent.REFRESH

	frmStatus.PicStatus.PRINT tempstr$
	frmStatus.PicStatus.REFRESH

UpdateStatusErr:
	EXIT SUB
END SUB

