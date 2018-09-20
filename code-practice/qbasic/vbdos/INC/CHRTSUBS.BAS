' ------------------------------------------------------------------------
' Visual Basic for MS-DOS Presentation Graphics
' ToolKit Demo Program
'
' CHRTSUBS.BAS - Chart demo support module.
'
' Chart demo is a menu-driven, Multiple Document
' Interface (MDI) program that demonstrates how to
' use the Presentation Graphics Toolkit to create and modify
' charts. Refer to module-level comments in CHRTDEMO.FRM
' for more information about this sample program.
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

'$FORM frmChartType
'$FORM frmFontDlg
'$FORM frmChrtAttributes
'$FORM frmChrtdemo
'$FORM frmChrtData

DECLARE SUB ClearData ()
DECLARE SUB ClearFonts ()
DECLARE SUB GetBestMode ()
DECLARE SUB InitChart ()
DECLARE SUB InitColors ()
DECLARE SUB InitFonts ()
DECLARE SUB LoadDefaultData ()
DECLARE SUB SaveChart (ChartName$)

'$INCLUDE: 'chrtdemo.bi'
'$INCLUDE: 'cmndlg.bi'

CONST FALSE = 0
CONST TRUE = NOT FALSE

TYPE ChartDataType
	DataNeeded AS INTEGER
	DataIndex AS INTEGER
	TitleNeeded AS INTEGER
	Title AS STRING * 64
END TYPE

COMMON SHARED /ChartDataBlock/ saveFile$                        'chart file
COMMON SHARED /ChartDataBlock/ savePath$                        'chart file
COMMON SHARED /ChartDataBlock/ ChartData() AS ChartDataType


' Default Chart Data
'
DATA January, February, March, April, May, June, July, August, September, October, November, December
DATA 1991, 1992, 1993
DATA 120, 124, 140, 200, 330, 400, 410, 420, 430, 500, 510, 520
DATA 450, 430, 400, 410, 500, 512, 505, 525, 550, 520, 490, 510
DATA 520, 520, 515, 540, 535, 545, 550, 551, 559, 630, 555, 563
DATA BigTime Software Inc.
DATA Sales Records
DATA Sales in Millions
DATA Month

DEFINT A-Z
' Change chart type to that specified by ctype and
' allow user to change chart style via dialog.
SUB ChangeChartType (ctype)
	'Change type if user selected a different type
	IF CEnv.ChartType <> ctype THEN
		IF setNum > 0 THEN frmChrtdemo.Tag = "Changed"

		' Check selected chart type.
		FOR i = 0 TO 4
			frmChrtdemo.mnuGalleryOptions(i).Checked = FALSE
		NEXT
		CEnv.ChartType = ctype
		frmChrtdemo.mnuGalleryOptions(CEnv.ChartType - 1).Checked = TRUE
	END IF

	' Allow user to change chart style
	' Determine option button captions based on chart type.
	SELECT CASE CEnv.ChartType
		CASE cBar, cColumn
			frmChartType.optChoice1.Caption = "Adjacent"
			frmChartType.optChoice2.Caption = "Stacked"
		CASE cLine, cScatter
			frmChartType.optChoice1.Caption = "Lines"
			frmChartType.optChoice2.Caption = "No Lines"
		CASE cPie
			frmChartType.optChoice1.Caption = "Percentages"
			frmChartType.optChoice2.Caption = "No Percentages"
	END SELECT

	frmChartType.Tag = "Cancel"
	frmChartType.SHOW 1

	' If not canceled then set new chart style
	IF frmChartType.Tag <> "Cancel" THEN
		IF setNum > 0 THEN frmChrtdemo.Tag = "Changed"
		IF frmChartType.optChoice1.Value THEN
			CEnv.ChartStyle = 1
		ELSE
			CEnv.ChartStyle = 2
		END IF
	END IF

	UNLOAD frmChartType
END SUB

' Clears all chart data.
SUB ClearData ()
	' Clear categories
	FOR i = 1 TO cMaxValues
		Cat$(i) = ""
	NEXT i
	catLen = 0

	' Clear set names and values
	FOR i = 1 TO cMaxSets
		setName$(i) = ""
		setLen(i) = 0
		FOR j = 1 TO cMaxValues
			setVal!(j, i) = cMissingValue
		NEXT j
	NEXT i
	setNum = 0

	' Chart not changed
	frmChrtdemo.Tag = ""
END SUB

' Sets all chart font pointers to 1.  This is called
' each time new fonts are loaded to ensure that
' all chart fonts specify a meaningful font
SUB ClearFonts ()

	' Reset all font pointers if don't map to current fonts.
	IF CEnv.DataFont > numFonts THEN CEnv.DataFont = 1
	IF CEnv.MainTitle.TitleFont > numFonts THEN CEnv.MainTitle.TitleFont = 1
	IF CEnv.SubTitle.TitleFont > numFonts THEN CEnv.SubTitle.TitleFont = 1
	IF CEnv.XAxis.AxisTitle.TitleFont > numFonts THEN CEnv.XAxis.AxisTitle.TitleFont = 1
	IF CEnv.XAxis.TicFont > numFonts THEN CEnv.XAxis.TicFont = 1
	IF CEnv.YAxis.AxisTitle.TitleFont > numFonts THEN CEnv.YAxis.AxisTitle.TitleFont = 1
	IF CEnv.YAxis.TicFont > numFonts THEN CEnv.YAxis.TicFont = 1
	IF CEnv.Legend.TextFont > numFonts THEN CEnv.Legend.TextFont = 1

END SUB

'Creates a list of valid screen modes for use by charting functions
'and sets the initial screen mode to the highest resolution
'possible.  If no graphic screen modes are available then
'it causes the program to exit.
SUB GetBestMode ()
	' Trap screen mode errors.
	ON LOCAL ERROR GOTO badmode

	' Find best screen mode available.
	screenMode = 0
	FOR i = 12 TO 1 STEP -1
		valid = TRUE
		SCREEN i
		IF valid THEN
			screenMode = i
			EXIT FOR
		END IF
	NEXT i

	' Reset screen mode.
	SCREEN 0
	WIDTH 80, 25

EXIT SUB

badmode:
	valid = FALSE
	RESUME NEXT
END SUB

DEFSNG A-Z
' Sets up and shows the form frmChrtAttributes to
' display color information.
SUB GetColors ()
	REDIM ChartData(16) AS ChartDataType

	'Add Title names to lstItems
	frmChrtAttributes.lstItems.ADDITEM "Main Title", 0
	frmChrtAttributes.lstItems.ADDITEM "Sub Title", 1
	frmChrtAttributes.lstItems.ADDITEM "X Axis Title", 2
	frmChrtAttributes.lstItems.ADDITEM "Y Axis Title", 3
	frmChrtAttributes.lstItems.ADDITEM "Legend Text", 4
	frmChrtAttributes.lstItems.ADDITEM "X Axis Labels", 5
	frmChrtAttributes.lstItems.ADDITEM "Y Axis Labels", 6
	frmChrtAttributes.lstItems.ADDITEM "Chart Window", 7
	frmChrtAttributes.lstItems.ADDITEM "Chart Border", 8
	frmChrtAttributes.lstItems.ADDITEM "Data Window", 9
	frmChrtAttributes.lstItems.ADDITEM "Data Border", 10

	'Add Color names to lstData
	FOR i = 1 TO numColors
		frmChrtAttributes.lstData.ADDITEM colors$(i)
	NEXT

	'Set up Display
	frmChrtAttributes.Caption = "Chart Colors"
	frmChrtAttributes.lblitems.Visible = TRUE
	frmChrtAttributes.lblitems.Caption = "&Chart Element:"
	frmChrtAttributes.lstItems.ListIndex = 0
	frmChrtAttributes.lstData.Visible = TRUE
	frmChrtAttributes.lblData.Visible = TRUE
	frmChrtAttributes.lblData.Caption = "C&olor:"
	frmChrtAttributes.txtTitle.Visible = FALSE
	frmChrtAttributes.Width = 45
	frmChrtAttributes.cmdOK.Left = 10
	frmChrtAttributes.cmdCancel.Left = 22
	frmChrtAttributes.Left = (screen.Width - frmChrtAttributes.Width) / 2 - 1

	ChartData(0).DataIndex = CEnv.MainTitle.TitleColor
	ChartData(1).DataIndex = CEnv.SubTitle.TitleColor
	ChartData(2).DataIndex = CEnv.XAxis.AxisTitle.TitleColor
	ChartData(3).DataIndex = CEnv.YAxis.AxisTitle.TitleColor
	ChartData(4).DataIndex = CEnv.Legend.TextColor
	ChartData(5).DataIndex = CEnv.XAxis.AxisColor
	ChartData(6).DataIndex = CEnv.YAxis.AxisColor
	ChartData(7).DataIndex = CEnv.ChartWindow.Background
	ChartData(8).DataIndex = CEnv.ChartWindow.BorderColor
	ChartData(9).DataIndex = CEnv.DataWindow.Background
	ChartData(10).DataIndex = CEnv.DataWindow.BorderColor

	FOR i = 0 TO 10
		ChartData(i).TitleNeeded = FALSE
		ChartData(i).DataNeeded = TRUE
	NEXT

	frmChrtAttributes.lstData.ListIndex = ChartData(0).DataIndex

	frmChrtAttributes.Tag = "Cancel"
	frmChrtAttributes.SHOW 1

	'Evaluate Data
	IF frmChrtAttributes.Tag <> "Cancel" THEN
		CEnv.MainTitle.TitleColor = ChartData(0).DataIndex
		CEnv.SubTitle.TitleColor = ChartData(1).DataIndex
		CEnv.XAxis.AxisTitle.TitleColor = ChartData(2).DataIndex
		CEnv.YAxis.AxisTitle.TitleColor = ChartData(3).DataIndex
		CEnv.Legend.TextColor = ChartData(4).DataIndex
		CEnv.XAxis.AxisColor = ChartData(5).DataIndex
		CEnv.YAxis.AxisColor = ChartData(6).DataIndex
		CEnv.ChartWindow.Background = ChartData(7).DataIndex
		CEnv.ChartWindow.BorderColor = ChartData(8).DataIndex
		CEnv.DataWindow.Background = ChartData(9).DataIndex
		CEnv.DataWindow.BorderColor = ChartData(10).DataIndex
	END IF

	'Unload Form
	UNLOAD frmChrtAttributes
END SUB

' Sets up and shows the form frmChrtAttributes to
' display font information.
SUB GetFonts ()
	REDIM ChartData(16) AS ChartDataType

	'Add Title names to lstItems
	frmChrtAttributes.lstItems.ADDITEM "Main Title", 0
	frmChrtAttributes.lstItems.ADDITEM "Sub Title", 1
	frmChrtAttributes.lstItems.ADDITEM "X Axis Title", 2
	frmChrtAttributes.lstItems.ADDITEM "Y Axis Title", 3
	frmChrtAttributes.lstItems.ADDITEM "Legend Text", 4
	frmChrtAttributes.lstItems.ADDITEM "X Axis Labels", 5
	frmChrtAttributes.lstItems.ADDITEM "Y Axis Labels", 6
	
	'Add Font names to lstData
	FOR i = 1 TO numFonts
		frmChrtAttributes.lstData.ADDITEM fonts$(i)
	NEXT

	'Set up Display
	frmChrtAttributes.Caption = "Chart Fonts"
	frmChrtAttributes.lblitems.Visible = TRUE
	frmChrtAttributes.lblitems.Caption = "&Chart Element:"
	frmChrtAttributes.lstItems.ListIndex = 0
	frmChrtAttributes.lstData.Visible = TRUE
	frmChrtAttributes.lblData.Caption = "&Fonts:"
	frmChrtAttributes.lblData.Visible = TRUE
	frmChrtAttributes.txtTitle.Visible = FALSE
	frmChrtAttributes.Width = 45
	frmChrtAttributes.cmdOK.Left = 10
	frmChrtAttributes.cmdCancel.Left = 22
	frmChrtAttributes.Left = (screen.Width - frmChrtAttributes.Width) / 2 - 1

	ChartData(0).DataIndex = CEnv.MainTitle.TitleFont - 1
	ChartData(1).DataIndex = CEnv.SubTitle.TitleFont - 1
	ChartData(2).DataIndex = CEnv.XAxis.AxisTitle.TitleFont - 1
	ChartData(3).DataIndex = CEnv.YAxis.AxisTitle.TitleFont - 1
	ChartData(4).DataIndex = CEnv.Legend.TextFont - 1
	ChartData(5).DataIndex = CEnv.XAxis.TicFont - 1
	ChartData(6).DataIndex = CEnv.YAxis.TicFont - 1
	
	FOR i = 0 TO 6
		ChartData(i).TitleNeeded = FALSE
		ChartData(i).DataNeeded = TRUE
		IF (ChartData(i).DataIndex > numFonts) OR (ChartData(i).DataIndex < 0) THEN
			ChartData(i).DataIndex = numFonts - 1
		END IF
	NEXT
	frmChrtAttributes.lstData.ListIndex = ChartData(0).DataIndex
	
	frmChrtAttributes.Tag = "Cancel"
	frmChrtAttributes.SHOW 1

	'Evaluate Data
	IF frmChrtAttributes.Tag <> "Cancel" THEN
		CEnv.MainTitle.TitleFont = ChartData(0).DataIndex + 1
		CEnv.SubTitle.TitleFont = ChartData(1).DataIndex + 1
		CEnv.XAxis.AxisTitle.TitleFont = ChartData(2).DataIndex + 1
		CEnv.YAxis.AxisTitle.TitleFont = ChartData(3).DataIndex + 1
		CEnv.Legend.TextFont = ChartData(4).DataIndex + 1
		CEnv.XAxis.TicFont = ChartData(5).DataIndex + 1
		CEnv.YAxis.TicFont = ChartData(6).DataIndex + 1
	END IF

	'Unload Form
	UNLOAD frmChrtAttributes

END SUB

' Sets up and shows the form frmChrtAttributes to
' display Title information.
SUB GetTitles ()
	REDIM ChartData(16) AS ChartDataType

	'Add Title names to lstItems
	frmChrtAttributes.lstItems.ADDITEM "Main", 0
	frmChrtAttributes.lstItems.ADDITEM "Sub", 1
	frmChrtAttributes.lstItems.ADDITEM "X Axis", 2
	frmChrtAttributes.lstItems.ADDITEM "Y Axis", 3

	'Set up Display
	frmChrtAttributes.Caption = "Chart Titles"
	frmChrtAttributes.lblitems.Visible = TRUE
	frmChrtAttributes.lblitems.Caption = "&Title:"
	frmChrtAttributes.lstItems.ListIndex = 0
	frmChrtAttributes.lstData.Visible = FALSE
	frmChrtAttributes.lblData.Visible = TRUE
	frmChrtAttributes.lblData.Caption = "T&ext:"
	frmChrtAttributes.txtTitle.Visible = TRUE
	frmChrtAttributes.Left = (screen.Width - frmChrtAttributes.Width) / 2 - 1
	
	FOR i = 0 TO 3
		ChartData(i).TitleNeeded = TRUE
		ChartData(i).DataNeeded = FALSE
	NEXT
	ChartData(0).Title = CEnv.MainTitle.Title
	ChartData(1).Title = CEnv.SubTitle.Title
	ChartData(2).Title = CEnv.XAxis.AxisTitle.Title
	ChartData(3).Title = CEnv.YAxis.AxisTitle.Title
	frmChrtAttributes.txtTitle.Text = ChartData(0).Title

	frmChrtAttributes.Tag = "Cancel"
	frmChrtAttributes.SHOW 1

	'Evaluate Data
	IF frmChrtAttributes.Tag <> "Cancel" THEN
		CEnv.MainTitle.Title = ChartData(0).Title
		CEnv.SubTitle.Title = ChartData(1).Title
		CEnv.XAxis.AxisTitle.Title = ChartData(2).Title
		CEnv.YAxis.AxisTitle.Title = ChartData(3).Title
	END IF

	'Unload Form
	UNLOAD frmChrtAttributes
END SUB

DEFINT A-Z
' Initializes the chart.
'
SUB InitChart ()
	' Dimension chart data variables.
	REDIM colors$(1 TO MAXCOLORS)                     'valid colors$
	REDIM fonts$(1 TO MAXFONTS)
	REDIM Cat$(1 TO cMaxValues)                       'category names
	REDIM setName$(1 TO cMaxSets)                     'set names
	REDIM setLen(1 TO cMaxSets)   AS INTEGER          '# values per set
	REDIM setVal!(1 TO cMaxValues, 1 TO cMaxSets)     'actual values
	REDIM mode$(1 TO 13)                              'list of modes

	GetBestMode                             ' get best graphics screen mode

	' Exit if no graphics mode available
	IF screenMode = 0 THEN
		LOCATE 10, 10
		PRINT "Cannot run Quick Chart - No graphic screen modes available for charting."
		END
	END IF

	' Chart support comes from the Presentation Graphics
	' Tooklit.  To run this program you must use the supplied
	' library (CHART.LIB, CHARTA.LIB) and Quick library
	' (CHART.QLB).
	DefaultChart CEnv, cBar, cPlain         ' Get defaults for chart variable
	ClearData                               ' Clear all chart data
	frmChrtdemo.mnuGalleryOptions(0).Checked = TRUE ' Check default chart type on menu.

	InitColors                              ' Set up color list
	InitFonts                               ' Set up font lists

	LoadDefaultData
END SUB

' Creates color list based on screen mode
'
SUB InitColors ()

	' create list of displayable colors$ based on screen mode
	SELECT CASE screenMode
		CASE 1
			numColors = 4
			REDIM color$(numColors)
			colors$(1) = "Black"
			colors$(2) = "White"
			colors$(3) = "Bright Cyan"
			colors$(4) = "Bright Magenta"
		CASE 2, 3, 4, 11
			numColors = 2
			REDIM color$(numColors)
			colors$(1) = "Black"
			colors$(2) = "White"
		CASE 7, 8, 9, 12, 13
			numColors = 16
			REDIM color$(numColors)
			colors$(1) = "Black"
			colors$(2) = "High White"
			colors$(3) = "Blue"
			colors$(4) = "Green"
			colors$(5) = "Cyan"
			colors$(6) = "Red"
			colors$(7) = "Magenta"
			colors$(8) = "Brown"
			colors$(9) = "White"
			colors$(10) = "Gray"
			colors$(11) = "Bright Blue"
			colors$(12) = "Bright Green"
			colors$(13) = "Bright Cyan"
			colors$(14) = "Bright Red"
			colors$(15) = "Bright Magenta"
			colors$(16) = "Yellow"
		CASE 10
			numColors = 4
			REDIM color$(numColors)
			colors$(1) = "Off"
			colors$(2) = "On High"
			colors$(3) = "On Normal"
			colors$(4) = "Blink"
	END SELECT

	' reset chart color pointers to default values
	IF numColors < 16 THEN
		CEnv.ChartWindow.Background = 0
		CEnv.ChartWindow.BorderColor = 1
		CEnv.DataWindow.Background = 0
		CEnv.DataWindow.BorderColor = 1
		CEnv.MainTitle.TitleColor = 1
		CEnv.SubTitle.TitleColor = 1
		CEnv.XAxis.AxisColor = 1
		CEnv.XAxis.AxisTitle.TitleColor = 1
		CEnv.YAxis.AxisColor = 1
		CEnv.YAxis.AxisTitle.TitleColor = 1
		CEnv.Legend.TextColor = 1
		CEnv.Legend.LegendWindow.Background = 0
		CEnv.Legend.LegendWindow.BorderColor = 1
	END IF
END SUB

' Sets up default font and initializes font list.
'
SUB InitFonts ()
DIM FI AS FontInfo

	' reset
	UnRegisterFonts
	SetMaxFonts 1, 1

	' get default font
	DefaultFont Segment%, Offset%
	reg% = RegisterMemFont%(Segment%, Offset%)

	' load default font
	numFonts = LoadFont("n1")
 
	IF numFonts = 0 THEN numFonts = 1

	fonts$(numFonts) = "IBM 8 Point"

	UnRegisterFonts
END SUB

' Loads chart data and settings from the given file.
'
SUB LoadChart (ChartName$)
	ON LOCAL ERROR GOTO LoadError

	OPEN ChartName$ FOR INPUT AS #1
	INPUT #1, setNum%
	FOR i% = 1 TO setNum%
		LINE INPUT #1, setName$(i%)
	NEXT
	FOR i% = 1 TO 15
		LINE INPUT #1, Cat$(i%)
	NEXT
	LINE INPUT #1, CEnv.MainTitle.Title
	LINE INPUT #1, CEnv.SubTitle.Title
	LINE INPUT #1, CEnv.XAxis.AxisTitle.Title
	LINE INPUT #1, CEnv.YAxis.AxisTitle.Title

	INPUT #1, CEnv.MainTitle.TitleColor
	INPUT #1, CEnv.SubTitle.TitleColor
	INPUT #1, CEnv.XAxis.AxisTitle.TitleColor
	INPUT #1, CEnv.YAxis.AxisTitle.TitleColor
	INPUT #1, CEnv.Legend.TextColor
	INPUT #1, CEnv.XAxis.AxisColor
	INPUT #1, CEnv.YAxis.AxisColor
	INPUT #1, CEnv.ChartWindow.Background
	INPUT #1, CEnv.ChartWindow.BorderColor
	INPUT #1, CEnv.DataWindow.Background
	INPUT #1, CEnv.DataWindow.BorderColor

	INPUT #1, CEnv.MainTitle.TitleFont
	INPUT #1, CEnv.SubTitle.TitleFont
	INPUT #1, CEnv.XAxis.AxisTitle.TitleFont
	INPUT #1, CEnv.YAxis.AxisTitle.TitleFont
	INPUT #1, CEnv.Legend.TextFont
	INPUT #1, CEnv.XAxis.TicFont
	INPUT #1, CEnv.YAxis.TicFont


	FOR i% = 1 TO setNum%
		FOR j% = 1 TO 15
			INPUT #1, setVal!(j%, i%)
		NEXT
	NEXT
	CLOSE
	EXIT SUB

' Handle any file format errors
LoadError:
	MSGBOX ERROR$ + ". loading chart.", 0, "Quick Chart"
	InitChart
	LoadDefaultData

	CLOSE FileNum%                              ' close and exit
	EXIT SUB
RESUME NEXT


END SUB

DEFSNG A-Z
' Load Default data contained in Data statements in
' the module level code of this module.
SUB LoadDefaultData ()
	frmChrtdemo.Tag = ""

	RESTORE
	setNum% = 3
	FOR i% = 1 TO 12
		READ Cat$(i%)
	NEXT
	FOR i% = 13 TO 15
		Cat$(i%) = ""
	NEXT

	FOR i% = 1 TO 15
		FOR j% = 1 TO 15
			setVal!(i%, j%) = cMissingValue
		NEXT
		setLen%(i%) = 0
	NEXT

	FOR i% = 1 TO setNum%
		READ setName$(i%)
		setLen%(i%) = 12
	NEXT
	
	FOR i% = 1 TO setNum%
		FOR j% = 1 TO 12
			READ temp$
			setVal!(j%, i%) = VAL(temp$)
		NEXT
	NEXT

	READ CEnv.MainTitle.Title
	READ CEnv.SubTitle.Title
	READ CEnv.XAxis.AxisTitle.Title
	READ CEnv.YAxis.AxisTitle.Title


END SUB

DEFINT A-Z
' Exits the program after allowing the user a chance to
' save the current chart.
'
SUB Quit (abort%)
	IF frmChrtdemo.Tag = "Changed" THEN
		A$ = CHR$(13) + "Current chart has not been saved.  Save now?"
		status = MSGBOX(A$, 3, "Quick Chart")

		' save chart
		IF status = 6 THEN
			IF saveFile$ = "" THEN
				CALL FileSave(saveFile$, savePath$, "Sample.cht", "Save Chart As", 0, 7, 0, Canceled)
			END IF
			IF Canceled <> -1 THEN
				IF RIGHT$(savePath$, 1) <> "\" THEN t$ = "\"
				CALL SaveChart(savePath$ + t$ + saveFile$)
			ELSE
				status = 2
			END IF
		END IF
	ELSE
		status = 6
	END IF

	' quit if operation has not been canceled.
	IF status <> 2 THEN
		screen.HIDE
		END
	ELSE
		abort% = -1
	END IF
END SUB

' Saves chart information.
SUB SaveChart (ChartName$)
	ON LOCAL ERROR GOTO saveError

	OPEN ChartName$ FOR OUTPUT AS #1
	PRINT #1, setNum%
	FOR i% = 1 TO setNum%
		PRINT #1, setName$(i%)
	NEXT
	FOR i% = 1 TO 15
		PRINT #1, Cat$(i%)
	NEXT
	PRINT #1, CEnv.MainTitle.Title
	PRINT #1, CEnv.SubTitle.Title
	PRINT #1, CEnv.XAxis.AxisTitle.Title
	PRINT #1, CEnv.YAxis.AxisTitle.Title

	PRINT #1, CEnv.MainTitle.TitleColor
	PRINT #1, CEnv.SubTitle.TitleColor
	PRINT #1, CEnv.XAxis.AxisTitle.TitleColor
	PRINT #1, CEnv.YAxis.AxisTitle.TitleColor
	PRINT #1, CEnv.Legend.TextColor
	PRINT #1, CEnv.XAxis.AxisColor
	PRINT #1, CEnv.YAxis.AxisColor
	PRINT #1, CEnv.ChartWindow.Background
	PRINT #1, CEnv.ChartWindow.BorderColor
	PRINT #1, CEnv.DataWindow.Background
	PRINT #1, CEnv.DataWindow.BorderColor

	PRINT #1, CEnv.MainTitle.TitleFont
	PRINT #1, CEnv.SubTitle.TitleFont
	PRINT #1, CEnv.XAxis.AxisTitle.TitleFont
	PRINT #1, CEnv.YAxis.AxisTitle.TitleFont
	PRINT #1, CEnv.Legend.TextFont
	PRINT #1, CEnv.XAxis.TicFont
	PRINT #1, CEnv.YAxis.TicFont

	FOR i% = 1 TO setNum%
		FOR j% = 1 TO 15
			PRINT #1, setVal!(j%, i%)
		NEXT
	NEXT
	CLOSE
	frmChrtdemo.Tag = ""
	EXIT SUB

' handle any file format errors
saveError:

	MSGBOX ERROR$ + ".  Cannot save " + ChartName$, 0, "Quick Chart"
	CLOSE
	IF DIR$(ChartName$) <> "" THEN KILL (ChartName$)
	EXIT SUB

END SUB

' Displays the chart
'
SUB ViewChart ()

	' When a chart is drawn, data is moved from the 2-dimensional array
	' into arrays suitable for the charting library routines.  The
	' following arrays are used directly in calls to the charting routines:
	DIM ValX1!(1 TO cMaxValues)                    ' Passed to Chart routine
	DIM ValY1!(1 TO cMaxValues)
	DIM ValX2!(1 TO cMaxValues, 1 TO cMaxSeries)   ' Passed to ChartMS routine
	DIM ValY2!(1 TO cMaxValues, 1 TO cMaxSeries)
	DIM explode(1 TO cMaxValues)  AS INTEGER       ' Explode pie chart pieces

	FOR j% = 1 TO 15
		IF setName$(j%) <> "" THEN
			setNum = j%
		END IF
		FOR i% = 1 TO 15
			IF setVal!(i%, j%) = cMissingValue THEN
				setLen(j%) = i% - 1
				EXIT FOR
			ELSEIF i% = 15 THEN
				setLen(j%) = i%
				EXIT FOR
			END IF
		NEXT
	NEXT

	' find the longest series
	maxLen% = 0
	FOR i% = 1 TO setNum
		IF setLen(i%) > maxLen% THEN maxLen% = setLen(i%)
	NEXT i%

	' Set up the proper screen mode (exit if not valid)
	screen.HIDE
	ChartScreen screenMode
	IF ChartErr = cBadScreen THEN
		MSGBOX "Invalid screen mode. Can't display chart.", 0, "Quick Chart"
		EXIT SUB
	END IF

	' Process depending on chart type
	SELECT CASE CEnv.ChartType
		CASE cBar, cColumn, cLine, cPie:
		' If the chart is a single series one or a pie chart:
		IF setNum = 1 OR CEnv.ChartType = cPie THEN

			' Transfer data into a single dimension array:
			FOR i% = 1 TO maxLen%
				ValX1!(i%) = setVal!(i%, 1)
			NEXT i%

			IF CEnv.ChartType = cPie THEN
				' determine which pieces to explode
				FOR i% = 1 TO maxLen%
					IF setVal!(i%, 2) <> 0 THEN
						explode(i%) = 1
					ELSE
						explode(i%) = 0
					END IF
				NEXT i%

				' display pie chart
				ChartPie CEnv, Cat$(), ValX1!(), explode(), maxLen%
			ELSE
				Chart CEnv, Cat$(), ValX1!(), maxLen%
			END IF

		 ' If multiple series, then data is OK so just call routine:
		 ELSE
			ChartMS CEnv, Cat$(), setVal!(), maxLen%, 1, setNum, setName$()
		 END IF

	  CASE cScatter:
		 ' Make sure there's enough data sets:
		 IF setNum = 1 THEN
			SCREEN 0
			WIDTH 80
			screen.SHOW

			A$ = CHR$(13) + "Too few data sets for Scatter chart"
			MSGBOX A$, 0, "Quick Chart"
			EXIT SUB

		 ' If it's a single series scatter, transfer data to one-
		 ' dimensional arrays and make chart call:
		 ELSEIF setNum = 2 THEN
			FOR i% = 1 TO maxLen%
			   ValX1!(i%) = setVal!(i%, 1)
			   ValY1!(i%) = setVal!(i%, 2)
			NEXT i%
			ChartScatter CEnv, ValX1!(), ValY1!(), maxLen%

		 ' If it's a multiple series scatter, transfer odd columns to
		 ' X-axis data array and even columns to Y-axis array and make
		 ' chart call:
		 ELSE
			FOR j% = 2 TO setNum STEP 2
			   FOR i% = 1 TO maxLen%
				  ValX2!(i%, j% \ 2) = setVal!(i%, j% - 1)
				  ValY2!(i%, j% \ 2) = setVal!(i%, j%)
			   NEXT i%
			NEXT j%

			ChartScatterMS CEnv, ValX2!(), ValY2!(), maxLen%, 1, setNum \ 2, setName$()
		 END IF

   END SELECT

   ' If there's been a "fatal" error, indicate what it was:
   IF ChartErr <> 0 THEN
	   GOSUB ViewError

   ' Otherwise, just wait for a keypress:
   ELSE
	  ' Wait for key or mousepress
	  DIM regs AS RegType
	  regs.ax = 0
	  'Check Status
	  CALL INTERRUPT(&H33, regs, regs)
	  MousePresent = regs.ax
	  IF MousePresent THEN
		   'Show Mouse
		   regs.ax = 1
		   CALL INTERRUPT(&H33, regs, regs)
	  END IF
	  mouseclick = 0
	  DO
			C$ = INKEY$
			'Check mouse status
			IF MousePresent THEN
				regs.ax = &H5
				regs.bx = 0
				CALL INTERRUPT(&H33, regs, regs)
				IF regs.bx > 0 THEN
					mouseclick = TRUE
				END IF
			END IF
	  LOOP UNTIL C$ <> "" OR mouseclick = TRUE
	  IF MousePresent THEN
		   'reset mouse
		   CALL INTERRUPT(&H33, regs, regs)
	  END IF

	  SCREEN 0
	  WIDTH 80
	  screen.SHOW
   END IF

EXIT SUB

' handle charting errors
ViewError:

	' re-init the display
	SCREEN 0
	WIDTH 80
	screen.SHOW

	' display appropriate error message
	SELECT CASE ChartErr
		CASE cBadDataWindow:
			MSGBOX "Data window cannot be displayed in available space.", 0, "Quick Chart"
		CASE cBadLegendWindow:
			MSGBOX "Invalid legend coordinates.", 0, "Quick Chart"
		CASE cTooFewSeries:
			MSGBOX "Too few series to plot.", 0, "Quick Chart"
		CASE cTooSmallN:
			MSGBOX "No data in series.", 0, "Quick Chart"
		CASE IS > 200:                              ' basic error
			MSGBOX "BASIC error #" + LTRIM$(STR$(ChartErr - 200)) + " occurred.", 0, "Quick Chart"
		CASE ELSE:                                  ' extraneous error
			MSGBOX "Charting error #" + LTRIM$(STR$(ChartErr)) + " occurred.", 0, "Quick Chart"
	END SELECT

RETURN

END SUB

DEFSNG A-Z
' Sets up and Shows the form frmChrtEdit.
'
SUB ViewData ()
	frmChrtData.SHOW
END SUB

DEFINT A-Z
' Displays list of registered fonts and allows user to
' select one or more of these fonts to load
'
SUB ViewFont ()
DIM FI AS FontInfo
DIM rfonts$(1 TO MAXFONTS)

	SetMaxFonts MAXFONTS, MAXFONTS

	' get default font
	DefaultFont Segment%, Offset%
	numReg = RegisterMemFont%(Segment%, Offset%)

	' use font files that are best suited for current screen mode
	curPath$ = CURDIR$
	IF RIGHT$(curPath$, 1) <> "\" THEN t$ = "\"
	SELECT CASE screenMode
		CASE 11, 12
			cour$ = curPath$ + t$ + "COURE.FON"
			helv$ = curPath$ + t$ + "HELVE.FON"
			tims$ = curPath$ + t$ + "TMSRE.FON"
		CASE ELSE
			cour$ = curPath$ + t$ + "COURB.FON"
			helv$ = curPath$ + t$ + "HELVB.FON"
			tims$ = curPath$ + t$ + "TMSRB.FON"
	END SELECT
	' register courier fonts
	numReg = numReg + RegisterFonts%(cour$)
	fontname$ = cour$
	IF FontErr > 0 THEN GOSUB FontError

	' register helvetica fonts
	numReg = numReg + RegisterFonts%(helv$)
	fontname$ = helv$
	IF FontErr > 0 THEN GOSUB FontError

	' register times roman fonts
	numReg = numReg + RegisterFonts%(tims$)
	fontname$ = tims$
	IF FontErr > 0 THEN GOSUB FontError

	' create a list of registered fonts
	FOR i = 1 TO numReg
		GetRFontInfo i, FI
		rfonts$(i) = RTRIM$(MID$(FI.FaceName, 1, 8)) + STR$(FI.Points) + " Point"
	NEXT i

	' set up window display
	IF numReg + 2 > 9 THEN
		frmFontDlg.Height = numReg + 2
	ELSE
		frmFontDlg.Height = 9
	END IF

	' open buttons for each font in list
	FOR i% = 1 TO numReg
		IF i% <> 1 THEN
			LOAD frmFontDlg.chkFonts(i%)
		END IF
		frmFontDlg.chkFonts(i%).Caption = rfonts$(i%)
		frmFontDlg.chkFonts(i%).Visible = TRUE
		frmFontDlg.chkFonts(i%).Value = 0
		frmFontDlg.chkFonts(i%).Top = i%
		FOR j% = 1 TO numFonts
			IF fonts$(j%) = rfonts$(i%) THEN
				frmFontDlg.chkFonts(i%).Value = 1
			END IF
		NEXT j%
	NEXT i%
	frmFontDlg.Tag = "Cancel"
	frmFontDlg.Top = (screen.Height - frmFontDlg.Height) \ 2
	frmFontDlg.Left = (screen.Width - frmFontDlg.Width) \ 2
	IF numReg > 0 THEN
		frmFontDlg.SHOW 1
	ELSE
		MSGBOX "No Fonts are available."
		frmFontDlg.Tag = "Cancel"
	END IF

	' finished and not cancelled
	IF frmFontDlg.Tag <> "Cancel" THEN
		' create font spec for load operation
		FontSpec$ = ""
		FOR i% = 1 TO numReg
			IF frmFontDlg.chkFonts(i%).Value THEN
				FontSpec$ = FontSpec$ + "/n" + LTRIM$(STR$(i))
			END IF
		NEXT i%

		' default if none chosen
		IF FontSpec$ = "" THEN
			MSGBOX "No fonts selected - using default.", 0, "Quick Chart"
			numFonts = LoadFont%("N1")
			REDIM fonts$(1)
			fonts$(1) = rfonts$(1)
		ELSE
			' load selected fonts
			numLoaded = LoadFont%(RIGHT$(FontSpec$, LEN(FontSpec$) - 1))

			' notify user of error and let them try again.
			IF FontErr <> 0 THEN
				GOSUB FontError
				currButton = 1
			ELSE
				REDIM fonts$(numLoaded)
				' create a list of loaded fonts
				FOR i = 1 TO numLoaded
					SelectFont i
					GetFontInfo FI
					fonts$(i) = RTRIM$(MID$(FI.FaceName, 1, 8)) + STR$(FI.Points) + " Point"
				NEXT i
				numFonts = numLoaded
				ClearFonts
			END IF
		END IF
	' reload existing fonts if operation cancelled
	ELSE
		FontSpec$ = ""
		FOR i = 1 TO numReg
			FOR j% = 1 TO numFonts
				IF fonts$(j%) = rfonts$(i%) THEN FontSpec$ = FontSpec$ + "/n" + LTRIM$(STR$(i))
			NEXT j%
		NEXT i
		numFonts = LoadFont%(RIGHT$(FontSpec$, LEN(FontSpec$) - 1))
	END IF

	UnRegisterFonts

	UNLOAD frmFontDlg

	EXIT SUB

' handle font loading errors
FontError:
	SELECT CASE FontErr
		CASE cNoFontMem:
			MSGBOX "Not enough memory to load selected fonts.", 0, "Quick Chart"
		CASE cFileNotFound:
			MSGBOX fontname$ + " font file not found.", 0, "Quick Chart"
		CASE cTooManyFonts:
			numReg = MAXFONTS
		CASE cBadFontFile:
			MSGBOX "Invalid font file format for " + fontname$ + ".", 0, "Quick Chart"
		CASE cNoFonts:
			MSGBOX "No fonts are loaded.", 0, "Quick Chart"
		CASE cBadFontType:
			MSGBOX "Font not a bitmap font.", 0, "Quick Chart"
		CASE IS > 200:                                  ' basic error
			MSGBOX "BASIC error #" + LTRIM$(STR$(FontErr - 200)) + " occurred.", 0, "Quick Chart"
		CASE ELSE                                       ' unplanned font error
			MSGBOX "Font error #" + LTRIM$(STR$(FontErr)) + " occurred.", 0, "Quick Chart"
	END SELECT

RETURN

END SUB

