' ------------------------------------------------------------------------
' Visual Basic for MS-DOS Help Toolkit
'
' The Help Toolkit (HELP.BAS, HELPF.FRM, and HELPUTIL.FRM)
' makes it easy to add a hypertext Help system to your
' applications.
'
' To use the Help Toolkit in your programs, include
' HELP.BAS, HELPF.FRM, and HELPUTIL.FRM in your program or
' use the supplied library (HELP.LIB, HELPA.LIB - AltMath
' version) and Quick library (HELP.QLB) and call the
' appropriate routines to load and display your help topics.
' Forms and code modules that call Help routines
' must include HELP.BI ('$INCLUDE: 'HELP.BI').
'
' Help files can be written in any ASCII text editor or
' in Visual Basic itself.  Refer to the sample Help file
' HELPDEMO.TXT as an example of the Help file format.
' HELPDEMO.TXT also contains full information on creating
' Help files and using the Help Toolkit to display and
' navigate them.
'
' The Help ToolKit consists of the following routines:
'     HelpRegister   - initializes the Help system and loads Help file
'     HelpShowTopic  - displays specified Help topic
'     HelpClose      - closes Help file
'     HelpSetOptions - sets Help display options
'     HelpSearch     - invokes Help Search dialog to enable topic search
' Detailed descriptions of these procedures are contained
' in the comment headers above each.
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

' Include file containing procedure declarations.
'$INCLUDE: 'HELP.BI'

'$FORM frmHelpUtils         ' Form for Search, History, and Change dialogs
'$FORM frmHelpMain          ' Help window

TYPE IndexType              ' Used to index Help topics
    StartFilePtr AS LONG    ' Position within the topic's file
    NumLines AS INTEGER     ' Number of lines in the Help topic
END TYPE

TYPE PointType
    X AS INTEGER            ' Horizontal location
    Y AS INTEGER            ' Vertical location
END TYPE

' Variables common to HELP.BAS, HELPF.FRM, and HELPUTIL.FRM.
COMMON SHARED /HelpLib/ DialogBackcolor AS INTEGER ' Background color for Help dialog boxes (Search, Copy, History)
COMMON SHARED /HelpLib/ DialogForecolor AS INTEGER ' Foreground color for Help dialog boxes (Search, Copy, History)

' Variables common to HELP.BAS and HELPF.FRM.
COMMON SHARED /HelpLib/ Topic() AS STRING       ' Lines of the current Help topic
COMMON SHARED /HelpLib/ LeftChar AS INTEGER     ' Leftmost character of the Help topic given the horizonal scroll position
COMMON SHARED /HelpLib/ StartLine AS INTEGER    ' Top line of the Help topic given the vertical scroll position
COMMON SHARED /HelpLib/ MaxLineLen AS INTEGER   ' Longest line of the Help topic
COMMON SHARED /HelpLib/ HelpIndexPtr() AS IndexType ' Table that stores data about each Help topic
COMMON SHARED /HelpLib/ HelpIndexTopics() AS STRING ' Array of Help topic names.  Used with the HelpIndexPtr table.
COMMON SHARED /HelpLib/ HelpFileNum AS INTEGER  ' Logical file number assigned to the Help file by HelpRegister
COMMON SHARED /HelpLib/ HelpTopicStack()  AS STRING ' Array of the last 20 Help topics shown
COMMON SHARED /HelpLib/ HelpTopicStackPtr  AS INTEGER ' Number of topics in the HelpTopicStack
COMMON SHARED /HelpLib/ TopicFound AS STRING    ' The Help topic being shown
COMMON SHARED /HelpLib/ MaxHistoryStack AS INTEGER ' Maximum allowed size of the HelpTopicStack.  HelpRegister sets to 20.
COMMON SHARED /HelpLib/ UnloadOnClose AS INTEGER ' Flag that determines if closing the Help form terminates the Help system.
COMMON SHARED /HelpLib/ KillHelp AS INTEGER     ' Flag that HelpClose sets to terminate the Help form
COMMON SHARED /HelpLib/ CursorPos AS PointType  ' Position of the currently selected Help link within a topic
COMMON SHARED /HelpLib/ ButtonBarHeight AS INTEGER ' Number of lines to reserve at the top of the form for the button bar.  0 or 3.
COMMON SHARED /HelpLib/ CloseOnEscape AS INTEGER ' If TRUE, pressing ESC will close the Help window

DEFINT A-Z

CONST FALSE = 0
CONST TRUE = NOT FALSE
CONST TabSpaces = 4                 ' Number of spaces that a TAB represents

DIM SHARED SelectedTopicColor AS INTEGER ' The foreground color of Help links
DIM SHARED SpaceString AS STRING    ' A string of blank spaces used by the HelpPrintText procedure
DIM SHARED HelpFileName AS STRING   ' Help file name.


'----------------------------------------------------
' Sample usage of the Help Toolkit. This code is
' only executed if HELP.BAS is the start-up file.
' Parameter information for each Help procedure is
' contained in the header comments for the procedure.
'----------------------------------------------------

' Set the title bar background color to magenta (5),
' the screen background color to blue (1), and the
' access key color to red (4).
screen.controlpanel(16) = 5
screen.controlpanel(5) = 1
screen.controlpanel(0) = 4

' Initialize the Help system and load specified Help file.
' HelpLoaded% returns whether or not the Help file was
' loaded successfully.
HelpRegister "HELPDEMO.TXT", HelpLoaded%

' HelpLoaded% will be FALSE if HelpRegister fails.
IF HelpLoaded% THEN
    ' Set Help color and button display options.
    ' Calls to this routine are optional as Help will
    ' use its defaults if this call is ommitted.
    HelpSetOptions 3, 0, 7, 0, 7, 11, 2

    ' Show the table of contents topic for the Help file.
    ' Help will remain visible until window is closed
    ' by the user.  Help topics can be changed by the user
    ' once the Help window is made visible with the first
    ' topic displayed.
    HelpShowTopic "Contents"
END IF

' Help close and unload routine.
'
' Closes help file and unloads help form.
' This routine should be called when the
' parent application terminates. If the parent
' routine has no END statement (e.g. it stops when
' the user closes the last form), the last Form_Unload
' must call this procedure.  Otherwise, the application
' will not end because frmHelpMain will still be loaded.
'
SUB HelpClose ()
    KillHelp = TRUE
    UNLOAD frmHelpMain
END SUB

' Internal routine that returns the greater of two integers.
'
FUNCTION HelpMax (int1 AS INTEGER, int2 AS INTEGER) AS INTEGER
    IF int1 > int2 THEN
        HelpMax = int1
    ELSE
        HelpMax = int2
    END IF
END FUNCTION

' Internal routine that returns the lower of two integers.
'
FUNCTION HelpMin (int1 AS INTEGER, int2 AS INTEGER) AS INTEGER
    IF int1 > int2 THEN
        HelpMin = int2
    ELSE
        HelpMin = int1
    END IF
END FUNCTION

' Help topic print routine.
'
' Internal routine that prints Help topic text.
' Called when a topic is first shown and when
' the form is scrolled.
'
' Parameters:
'   TopLine   - The first element (line) of the topic
'               array to be displayed.
'   LeftPos   - The first character of each topic line
'               to be displayed.
'
SUB HelpPrintText (TopLine AS INTEGER, LeftPos AS INTEGER)
    MaxLines = UBOUND(Topic)    ' The number of lines in the Help topic.
    IF TopLine > MaxLines THEN EXIT SUB
    LastPrintedLine = TopLine + frmHelpMain.pctBackground.ScaleHeight ' The last line of the Help topic that will be printed.

    IF LastPrintedLine > MaxLines THEN
        ' Ensures that the routine does not attempt to print more lines than the topic size
        LastPrintedLine = MaxLines
    END IF

    blanklines = frmHelpMain.pctBackground.ScaleHeight - (LastPrintedLine - TopLine - ButtonBarHeight) ' Number of blank lines on the form.
    FormWidth = frmHelpMain.pctBackground.ScaleWidth ' Local variable copy of the form width.  Used to minimize property access.
    frmHelpMain.pctBackground.CurrentY = 0 ' Start printing at the top of the picture control

    ' Print the necessary topic lines.
    FOR i = TopLine TO LastPrintedLine
        frmHelpMain.pctBackground.PRINT MID$(Topic(i) + SpaceString, LeftPos, FormWidth)
    NEXT i

    ' Print as many blank lines as required.
    DO WHILE blanklines > 0
        blanklines = blanklines - 1
        frmHelpMain.pctBackground.PRINT SpaceString
    LOOP

    ' Set the common variables StartLine and LeftChar based
    ' on parameters passed to this routine.
    StartLine = TopLine
    LeftChar = LeftPos

    ' Do a quick check to see if there is a highlighted
    ' link.  CursorPos.Y will be 0 if the users has not
    ' pressed TAB or Shift-TAB in this topic.  Skips a lot
    ' of code if there is no selected Help link.
    '
    IF CursorPos.Y > 0 THEN
        DIM PrintTopicFound AS STRING ' String containing the selected Help link

        ' Is the selected link within the currently visible
        ' vertical region of the form?
        IF CursorPos.Y >= StartLine AND CursorPos.Y <= LastPrintedLine THEN
            ' Yes.
            
            ' Now see if it's in the visible horizontal
            ' region
            IF CursorPos.X >= LeftPos AND CursorPos.X <= LeftPos + FormWidth THEN
                ' The entire link text will fit horizontally
                frmHelpMain.pctBackground.CurrentX = CursorPos.X - LeftPos
                PrintTopicFound = TopicFound
            ELSEIF CursorPos.X + LEN(TopicFound) >= LeftPos AND CursorPos.X <= LeftPos + FormWidth THEN
                ' Part of the link text will fit horizontally
                frmHelpMain.pctBackground.CurrentX = 0
                PrintTopicFound = MID$(TopicFound, LeftChar - CursorPos.X + 1)
            END IF

            ' Print the link text in the SelectedTopicColor
            ' if it is in the visible region.
            IF PrintTopicFound <> "" THEN
                frmHelpMain.pctBackground.CurrentY = CursorPos.Y - StartLine
                RealColor = frmHelpMain.pctBackground.Forecolor
                frmHelpMain.pctBackground.Forecolor = SelectedTopicColor
                frmHelpMain.pctBackground.PRINT PrintTopicFound
                frmHelpMain.pctBackground.Forecolor = RealColor
            END IF
        END IF
    END IF

    ' Set the scroll bar values.
    frmHelpMain.vscHelp.Value = StartLine
    frmHelpMain.hscHelp.Value = LeftChar

    ' Make sure the Help form is visible.
    frmHelpMain.SHOW
END SUB

' Help initialization routine.
'
' Initializes the Help Toolkit by scanning through
' the specified Help file to create a table of
' all Help topics. This routine MUST be
' called BEFORE using any other Help Toolkit
' routines.
'
' Parameters:
'   HelpFile$ - The MS-DOS file name of the Help file.
'               Must include file extensions (e.g. HELPDEMO.TXT).
'   Success% -  Signals whether Help initialization was successful.
'
' Topics must be defined in the Help file as follows
' for HelpRegister to recognize them.  See HELPDEMO.TXT
' for a complete example.
'      .TOPIC:
'      topic_name
'      Topic Text Goes Here....
'
SUB HelpRegister (HelpFile$, Success%)
    Success% = FALSE

    ' Default option settings.  HelpSetOptions can override.
    ButtonBarHeight = 3
    SelectedTopicColor = screen.controlpanel(0)
    DialogBackcolor = 7
    DialogForecolor = 0
    
    ' Assume there are 50 help topics in the file.
    MaxTopics = 50
    REDIM HelpIndexPtr(MaxTopics)  AS IndexType
    REDIM HelpIndexTopics(MaxTopics) AS STRING

    HelpFileNum = FREEFILE
    
    ON LOCAL ERROR GOTO HelpFileNotFound
        OPEN HelpFile$ FOR INPUT AS HelpFileNum
    ON LOCAL ERROR GOTO 0

    DO WHILE NOT EOF(HelpFileNum)
        LINE INPUT #HelpFileNum, temp$
        IF RTRIM$(temp$) = ".TOPIC:" THEN
            ' Now that it hit a .TOPIC:, it knows how
            ' many lines were in the previous
            ' topic so goes back and fills in
            ' the # of lines for the PREVIOUS
            ' topic.  Will fill element 0, by the way.
            HelpIndexPtr(NumTopics).NumLines = LinesRead
            
            ' Now clear LinesRead for this new
            ' topic and increment the number of topics.
            LinesRead = 0
            NumTopics = NumTopics + 1

            ' Are the arrays large enough given the number
            ' Help topics?
            IF NumTopics > MaxTopics THEN
                ' No.  More topics than current array
                ' allocation so grow the arrays by another
                ' 50 elements.
                MaxTopics = MaxTopics + 50
                ON LOCAL ERROR GOTO HelpOutOfMemory
                    REDIM PRESERVE HelpIndexPtr(MaxTopics) AS IndexType
                    REDIM PRESERVE HelpIndexTopics(MaxTopics) AS STRING
                ON LOCAL ERROR GOTO 0
            END IF

            ' The next line in the file must be the topic
            ' name.
            LINE INPUT #HelpFileNum, HelpIndexTopics(NumTopics)

            ' Remember where the Help topic actually
            ' starts so HelpShowTopic can jump to it
            ' immediately when a jump is requested.
            HelpIndexPtr(NumTopics).StartFilePtr = SEEK(HelpFileNum)
        ELSE
            ' Line was not a Topic marker or the first line
            ' after a topic marker.  Increment the number
            ' of lines in this topic.
            LinesRead = LinesRead + 1
        END IF
    LOOP

    ' Abort the registration process if no Help topics
    ' were found.
    IF NumTopics = 0 THEN
        MSGBOX HelpFile$ + " is not a valid Help file.", 0, "Help"
        HelpFileNum = 0
        EXIT SUB
    END IF

    ' Completes the table entries for the last topic
    HelpIndexPtr(NumTopics).NumLines = LinesRead

    ' Shrink the arrays to the exact size required
    ON LOCAL ERROR GOTO HelpOutOfMemory
        REDIM PRESERVE HelpIndexPtr(NumTopics) AS IndexType
        REDIM PRESERVE HelpIndexTopics(NumTopics) AS STRING
    ON LOCAL ERROR GOTO 0

    ' Initialize variables
    HelpTopicStackPtr = 0
    frmHelpMain.cmdButtonBar(0).Enabled = TRUE ' Enable the Contents button
    frmHelpMain.cmdButtonBar(1).Enabled = TRUE ' Enable the Search button
    MaxHistoryStack = 20
    ON LOCAL ERROR GOTO HelpOutOfMemory
        REDIM HelpTopicStack(MaxHistoryStack)  AS STRING
    ON LOCAL ERROR GOTO 0

    SpaceString = STRING$(screen.width, 32)
    IF HelpFileNum > 0 THEN
        Success% = TRUE

        ' Store a fully qualified HelpFile name
        ' in case the Help file needs to be
        ' re-registered later.  The full path
        ' name is stored so the Help Toolkit can
        ' always find the file even if an application
        ' causes CURDIR$ to change.
        '
        IF INSTR(HelpFile$, "\") = 0 THEN
            ' No slash in the file name so local
            ' file name was provided.  Add path
            ' info.
            IF RIGHT$(CURDIR$, 1) = "\" THEN
                HelpFileName = CURDIR$ + HelpFile$
            ELSE
                HelpFileName = CURDIR$ + "\" + HelpFile$
            END IF
        ELSE
            ' Path info was already provided
            HelpFileName = HelpFile$
        END IF
    END IF
EXIT SUB

' Local error handlers
HelpOutOfMemory:
    MSGBOX "Insufficient memory to display Help.", 0, "Help"
    HelpClose
    EXIT SUB

HelpFileNotFound:
    ' Construct a fully qualified file name
    IF RIGHT$(CURDIR$, 1) = "\" THEN
        UseFile$ = CURDIR$ + HelpFile$
    ELSE
        UseFile$ = CURDIR$ + "\" + HelpFile$
    END IF

    MSGBOX "Help file " + UseFile$ + " not found.", 0, "Help"
    HelpClose
    EXIT SUB
END SUB

' Help search routine.
'
' Displays Help Search dialog and searchs for
' selected Help topic.
'
SUB HelpSearch ()
    ' Confirm that a Help file is open.
    IF HelpFileNum = 0 THEN
        ' No open Help file.  HelpFileName will
        ' be null if HelpRegister was never successful
        ' but will have a valid file name if a Help
        ' file was registered correctly but an error
        ' such as Insufficient Memory to Display Help
        ' caused Help to close.  Also occurs if
        ' HelpSearch is called after the Help
        ' form is unloaded (e.g. if HelpSetOptions
        ' set UnloadOnClose to TRUE).
        IF HelpFileName = "" THEN
            MSGBOX "Help Search can only be used after registering a valid Help file.", 0, "Help"
            EXIT SUB
        ELSE
            ' Register the Help file again.
            HelpRegister HelpFileName, HelpLoaded
            IF HelpLoaded = FALSE THEN
                MSGBOX "Help Search can only be used after registering a valid Help file.", 0, "Help"
                EXIT SUB
            END IF
        END IF
    END IF

    ' Fill the search list box with all the Help
    ' topics.  LstSearch.Sorted = TRUE so the topics will
    ' be listed alphabetically.
    FOR i = 1 TO UBOUND(HelpIndexTopics)
        frmHelpUtils.lstSearch.ADDITEM HelpIndexTopics(i)
    NEXT i

    ' Set the list index to the top.
    frmHelpUtils.lstSearch.ListIndex = 0

    ' Show the Search form modally.
    frmHelpUtils.SHOW 1

    ' The search form's tag property will be set
    ' to the topic the user selected or null if Cancel
    ' was selected.
    RequestedTopic$ = frmHelpUtils.Tag
    UNLOAD frmHelpUtils

    ' pctBackground must always have the focus so keys can
    ' be trapped.
    IF frmHelpMain.visible THEN frmHelpMain.pctBackground.SETFOCUS

    ' Show the selected topic.
    IF RequestedTopic$ <> "" THEN
        HelpShowTopic RequestedTopic$
    END IF
END SUB

' Help option setting routine.
'
' Sets colors and shows/hides buttons on the
' Help window's button bar.  This routine is
' optional as default settings are provided.
'
' Parameters:
'   BColor      - Sets help window background color (frmHelpMain.pctBackground.BackColor)
'   FColor      - Sets help window foreground color (frmHelpMain.pctBackground.ForeColor)
'   DBColor     - Sets the background color for Help dialogs (Search, Copy, History).
'   DFColor     - Sets the foreground color for Help dialogs (Search, Copy, History).
'   ButtonColor - Sets the background color for the five
'                 help window button bar.  Set SCREEN.CONTROLPANEL(4)
'                 to change button foreground color.
'   SelectColor - Sets the color of the link markers.
'   Flags       - Bit flags set the VISIBLE status
'                 of the five command buttons and
'                 enable other Help Toolit options.
'                 Add the values below to show buttons
'                 and enable options.
'
'                 Function               Value    Default
'                 ---------------------  -----    -------
'                 ESC closes Help            1       0 (Escape key does not close help window)
'                 UNLOAD Help at Form close  2       0 (Help form in made invisible, not unloaded when form is closed)
'                 No Contents Button         4       0 (Contents button is visible)
'                 No Search Button           8       0 (Search button is visible)
'                 No Back Button            16       0 (Back button is visible)
'                 No History Button         32       0 (History button is visible)
'                 No Copy Button            64       0 (Copy button is visible)
'
'                 For example, Flags = 65 allows ESC to
'                 close Help and hides the Copy button.
'                 Space for the button bar is only reserved
'                 at the top frmHelpMain if at least one button is visible.
'
SUB HelpSetOptions (bcolor AS INTEGER, fcolor AS INTEGER, dbColor AS INTEGER, dfColor AS INTEGER, buttoncolor AS INTEGER, SelectColor AS INTEGER, Flags AS INTEGER)
    ' Trap to ensure HelpRegister has already been called.
    IF HelpFileNum = 0 THEN
        MSGBOX "You must call the HelpRegister procedure before calling HelpSetOptions.  Proposed settings ignored.", 0, "Help"
        EXIT SUB
    END IF

    ' Confirm that the proposed color settings are valid.
    ' If so, set the appropriate properties or variables.
    IF bcolor >= 0 AND bcolor <= 15 THEN frmHelpMain.pctBackground.Backcolor = bcolor
    IF fcolor >= 0 AND fcolor <= 15 THEN frmHelpMain.pctBackground.Forecolor = fcolor
    IF SelectColor >= 0 AND SelectColor <= 15 THEN SelectedTopicColor = SelectColor
    IF dbColor >= 0 AND dbColor <= 15 THEN DialogBackcolor = dbColor
    IF dfColor >= 0 AND dfColor <= 15 THEN DialogForecolor = dfColor

    IF buttoncolor >= 0 AND buttoncolor <= 15 THEN
        frmHelpMain.Backcolor = buttoncolor
        FOR i = 0 TO 4
            frmHelpMain.cmdButtonBar(i).Backcolor = buttoncolor
        NEXT i
    END IF
    
    ' Hide or show buttons as requested
    FOR i = 0 TO 4
        IF (Flags AND 2 ^ (i + 3)) = FALSE THEN
            frmHelpMain.cmdButtonBar(i).Left = 13 * NumButtons
            frmHelpMain.cmdButtonBar(i).visible = TRUE
            NumButtons = NumButtons + 1
        ELSE
            frmHelpMain.cmdButtonBar(i).visible = FALSE
        END IF
    NEXT i

    ' Allow space for the button bar if at least one button
    ' is shown.
    IF NumButtons = 0 THEN
        ButtonBarHeight = 0
    ELSE
        ButtonBarHeight = 3
    END IF

    CloseOnEscape = Flags AND 1
    UnloadOnClose = Flags AND 2
    
END SUB

' Help topic display routine.
'
' Displays the requested topic on the Help form.
'
' Parameter:
'   ProvidedTopic$ - The name of the topic that should be shown.
'
SUB HelpShowTopic (ProvidedTopic$)
    ' Confirm that a Help file has been registered and
    ' that non-null topic has been provided.
    IF ProvidedTopic$ = "" THEN
        MSGBOX "A Help topic must be supplied", 0, "Help"
        EXIT SUB
    END IF

    ' Confirm that a Help file is open.
    IF HelpFileNum = 0 THEN
        ' No open Help file.  HelpFileName will
        ' be null if HelpRegister was never successful
        ' but will have a valid file name if a Help
        ' file was registered correctly but an error
        ' such as Insufficient Memory to Display Help
        ' caused Help to close.  Also occurs if
        ' HelpShowTopic is called after the Help
        ' form is unloaded (e.g. if HelpSetOptions
        ' set UnloadOnClose to TRUE).
        IF HelpFileName = "" THEN
            MSGBOX "You must call the HelpRegister procedure before calling HelpShowTopic.", 0, "Help"
            EXIT SUB
        ELSE
            ' Register the Help file again.
            HelpRegister HelpFileName, HelpLoaded
            IF HelpLoaded = FALSE THEN
                MSGBOX "You must call the HelpRegister procedure before calling HelpShowTopic.", 0, "Help"
                EXIT SUB
            END IF
        END IF
    END IF

    ' Convert the topic request to uppercase to make
    ' matching easier then scan the HelpIndex table
    ' for that topic.
    '
    RequestedTopic$ = UCASE$(ProvidedTopic$)
    TotalTopics = UBOUND(HelpIndexTopics)
    TopicNum = 1
    EndNow = FALSE
    DO UNTIL EndNow
        IF UCASE$(HelpIndexTopics(TopicNum)) = RequestedTopic$ THEN
            EndNow = TRUE
        ELSE
            TopicNum = TopicNum + 1
            IF TopicNum > TotalTopics THEN
                EndNow = TRUE
                TopicNum = 0
            END IF
        END IF
    LOOP

    ' Exit if the topic does not exist.
    IF TopicNum = 0 THEN
        MSGBOX "Help topic '" + ProvidedTopic$ + "' not found.", 0, "Help"
        EXIT SUB
    END IF

    ' Seek to the topic's position in the Help file.
    SEEK HelpFileNum, HelpIndexPtr(TopicNum).StartFilePtr
    
    ' REDIM the topic array so that it's the exact size
    ' needed to store the requested topic.
    MaxLines = HelpIndexPtr(TopicNum).NumLines

    ON LOCAL ERROR GOTO HelpShowOutOfMemory
        REDIM Topic(1 TO MaxLines)  AS STRING
    
        ' Load the topic lines into the topic array
        MaxLineLen = 0
        FOR i = 1 TO MaxLines
            LINE INPUT #HelpFileNum, Topic(i)

            ' Convert tabs (CHR$(9)) to spaces.
            TabPos = INSTR(Topic(i), CHR$(9))
            DO WHILE TabPos > 0
                Topic(i) = LEFT$(Topic(i), TabPos - 1) + STRING$(TabSpaces - (TabPos MOD TabSpaces), " ") + MID$(Topic(i), TabPos + 1)
                TabPos = INSTR(TabPos + TabSpaces - 1, Topic(i), CHR$(9))
            LOOP
            IF LEN(Topic(i)) > MaxLineLen THEN MaxLineLen = LEN(Topic(i))
        NEXT i
    ON LOCAL ERROR GOTO 0

    ' Set misc. values
    frmHelpMain.hscHelp.Value = 1
    frmHelpMain.hscHelp.min = 1
    frmHelpMain.hscHelp.max = HelpMax(MaxLineLen - frmHelpMain.pctBackground.ScaleWidth + 1, 1)
    frmHelpMain.vscHelp.max = HelpMax(MaxLines - frmHelpMain.pctBackground.ScaleHeight + 1, 1)
    frmHelpMain.vscHelp.Value = 1
    frmHelpMain.vscHelp.min = 1
    frmHelpMain.Caption = "Help: " + ProvidedTopic$
    TopicCursor.Y = 0
    IF frmHelpMain.ScaleHeight > 3 THEN frmHelpMain.vscHelp.LargeChange = frmHelpMain.pctBackground.ScaleHeight
    
    ' Update the history stack
    HelpTopicStackPtr = HelpTopicStackPtr + 1

    ' Only store the last MaxHistoryStack of
    ' Help topics.
    IF HelpTopicStackPtr > MaxHistoryStack THEN
        'Would overflow.  Drop the least recent entry.
        FOR i = 2 TO MaxHistoryStack
            HelpTopicStack(i - 1) = HelpTopicStack(i)
        NEXT i
        HelpTopicStackPtr = MaxHistoryStack
    END IF

    ' Add this topic to the Help stack
    HelpTopicStack(HelpTopicStackPtr) = HelpIndexTopics(TopicNum)

    ' Enable/disable buttons based on the size of the
    ' Help stack
    SELECT CASE HelpTopicStackPtr
    CASE 1
        ' This is the first topic.  Both
        ' BACK (2) and History(3) should be
        ' disabled.
        frmHelpMain.cmdButtonBar(2).Enabled = FALSE
        frmHelpMain.cmdButtonBar(3).Enabled = FALSE
    CASE 2
        ' This is the second topic.
        ' BACK (2) should be enabled but History(3)
        ' isn't necessary.
        frmHelpMain.cmdButtonBar(2).Enabled = TRUE
        frmHelpMain.cmdButtonBar(3).Enabled = FALSE
    CASE IS > 2
        ' More than 2 topics have been shown so enabled
        ' both Back and History.
        frmHelpMain.cmdButtonBar(2).Enabled = TRUE
        frmHelpMain.cmdButtonBar(3).Enabled = TRUE
    END SELECT

    ' Restore the Help form to its former size/position
    ' if it is currently minimized.
    IF frmHelpMain.WindowState = 1 THEN
        frmHelpMain.WindowState = 0
    END IF

    ' Refresh the form to ensure that new button bar
    ' states take effect.

    ' Actually display the topic, starting at
    ' the top and far left
    CursorPos.X = 0
    CursorPos.Y = 0
    HelpPrintText 1, 1
EXIT SUB

HelpShowOutOfMemory:
    MSGBOX "Insufficient memory to display Help.", 0, "Help"
    HelpClose
    EXIT SUB

END SUB

