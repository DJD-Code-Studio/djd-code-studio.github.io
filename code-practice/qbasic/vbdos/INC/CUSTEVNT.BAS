' ----------------------------------------------------------------------------
' CUSTEVNT.BAS: Custom Control Event Procedures
'
' Custom control event procedure templates created by
' CUSTGEN.EXE (Custom Control Template Generator).
'
' CUSTGEN.EXE is a utility provided to make custom
' control development easier.  It allows you to select
' the events you want your custom control to respond to,
' then generates code templates and a custom control
' registration routine for these events.
'
' Modify the code template file as necessary, then build
' your custom control as follows:
'    ML -c <RegisterFile>          ; Assumes Masm 6.0 compiler
'    BC /o <TemplateFile>;
'    DEL <TemplateFile.LIB>        ; Delete existing library if exists
'    LIB <TemplateFile.LIB>+<RegisterFile.OBJ>+<TemplateFile.OBJ>
'    LINK /Q <TemplateFile.LIB>,<TemplateFile.QLB>,,VBDOSQLB.LIB;
' You can combine multiple custom controls into one Quick library for
' use within the programming environment as follows:
'    DEL <CombinedLib.LIB>         ; Delete existing library if exists
'    LIB <CombinedLib.LIB>+<Cust1.LIB>+<Cust2.LIB>+<CustN.LIB>
'    LINK /Q <CombinedLib.LIB>,<CombinedLib.QLB>,,VBDOSQLB.LIB;
' To create an Alternate Math custom control library (instead of an
' Emulator Math custom control library as shown above), compile the 
' TemplateFile with the /FPa switch.  Note, an Altmath library cannot be
' used to create a Quick Library.
'
'
' Copyright (C) 1982-1992 Microsoft Corporation
'
' You have a royalty-free right to use, modify, reproduce
' and distribute the sample applications and toolkits provided with
' Visual Basic for MS-DOS (and/or any modified version)
' in any way you find useful, provided that you agree that
' Microsoft has no warranty, obligations or liability for
' any of the sample applications or toolkits.
' ----------------------------------------------------------------------------


' Include file containing constant definitions for
' Property, Event, Method and ControlType ID numbers.
'$INCLUDE: 'CUSTINCL.BI'

' Turn on option explicit to force all variables to be
' declared before use.  Note, this is an optional debugging aid.
OPTION EXPLICIT


' Declarations for custom control callbacks.
' These callbacks are used to set and get custom control
' properties and invoke custom control methods and events.
'
' ** IMPORTANT: Remove all unused callback declarations
'    to reduce DGROUP consumption.
'
'    AID = Attribute Id - list is found in CUSTINCL include file.
'    CID = Control Id created internally by Visual Basic
'    EID = Event Id - list is found in CUSTINCL include file.
'    MthID = Method Id - list is found in CUSTINCL include file.
'    PID = Property Id - list is found in CUSTINCL include file.

' Declare callbacks for invoking methods and events and getting
' and setting properties.  These callbacks accept a variable number 
' and types of arguments depending on the method or event that is 
' being invoked.
DECLARE SUB InvokeEvent
DECLARE SUB InvokeMethod
DECLARE SUB GetProperty
DECLARE SUB SetProperty

' Declare callback for getting a control's container object.
' This callback returns a CID for the container object.
DECLARE FUNCTION GetContainer (BYVAL CID AS INTEGER) AS INTEGER

' Declare callback for setting a control's attributes (access key,
' focus availability, arrow key trapping ability, and text cursor 
' location).  Refer to the custom control section of the README.TXT
' file for complete information on using this callback.
DECLARE SUB SetAttribute (BYVAL CID AS INTEGER, BYVAL AID AS INTEGER, BYVAL Value AS INTEGER)

' Declare unique callbacks for each property datatype for 
' setting and getting property values by aliasing the
' GetProperty and SetProperty callbacks which accept any datatype.
' This provides type checking during calls to these procedures.
DECLARE SUB GetIntProperty    ALIAS "GETPROPERTY" (Value AS INTEGER, BYVAL CID AS INTEGER, BYVAL PID AS INTEGER)
DECLARE SUB GetStringProperty ALIAS "GETPROPERTY" (Value AS STRING,  BYVAL CID AS INTEGER, BYVAL PID AS INTEGER)
DECLARE SUB GetLongProperty   ALIAS "GETPROPERTY" (Value AS LONG,    BYVAL CID AS INTEGER, BYVAL PID AS INTEGER)
DECLARE SUB SetIntProperty    ALIAS "SETPROPERTY" (BYVAL value AS INTEGER, BYVAL CID AS INTEGER, BYVAL PID AS INTEGER)
DECLARE SUB SetStringProperty ALIAS "SETPROPERTY" (Value AS STRING,        BYVAL CID AS INTEGER, BYVAL PID AS INTEGER)
DECLARE SUB SetLongProperty   ALIAS "SETPROPERTY" (BYVAL value AS LONG,    BYVAL CID AS INTEGER, BYVAL PID AS INTEGER)

' Declare unique callbacks for invoking each user event
' by aliasing the InvokeEvent callback which accepts a variable number
' of arguments and types depending on the event being invoked.
' This provides type checking during calls to these procedures.
DECLARE SUB InvokeChangeEvent        ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeClickEvent         ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeCustomEvent        ALIAS "INVOKEEVENT" (EventType AS INTEGER, BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeDblClickEvent      ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeDragDropEvent      ALIAS "INVOKEEVENT" (BYVAL SourceCID AS INTEGER, X AS SINGLE, Y AS SINGLE, BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeDragOverEvent      ALIAS "INVOKEEVENT" (BYVAL SourceCID AS INTEGER, X AS SINGLE, Y AS SINGLE, State AS INTEGER, BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeDropDownEvent      ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeGotFocusEvent      ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeKeyDownEvent       ALIAS "INVOKEEVENT" (KeyCode AS INTEGER, Shift AS INTEGER, BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeKeyPressEvent      ALIAS "INVOKEEVENT" (KeyAscii AS INTEGER, BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeKeyUpEvent         ALIAS "INVOKEEVENT" (KeyCode AS INTEGER, Shift AS INTEGER, BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeLoadEvent          ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeLostFocusEvent     ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeMouseDownEvent     ALIAS "INVOKEEVENT" (Button AS INTEGER, Shift AS INTEGER, X AS SINGLE, Y AS SINGLE, BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeMouseMoveEvent     ALIAS "INVOKEEVENT" (Button AS INTEGER, Shift AS INTEGER, X AS SINGLE, Y AS SINGLE, BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeMouseUpEvent       ALIAS "INVOKEEVENT" (Button AS INTEGER, Shift AS INTEGER, X AS SINGLE, Y AS SINGLE, BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokePaintEvent         ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokePathChangeEvent    ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokePatternChangeEvent ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeResizeEvent        ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeTimerEvent         ALIAS "INVOKEEVENT" (BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)
DECLARE SUB InvokeUnloadEvent        ALIAS "INVOKEEVENT" (Cancel AS INTEGER, BYVAL CID AS INTEGER, BYVAL EID AS INTEGER)

' Declare unique callbacks for invoking each custom control method
' by aliasing the InvokeMethod callback which accepts a variable number
' of arguments and types depending on the method being invoked.
' This provides type checking during calls to these procedures.
DECLARE SUB InvokePrintMethod      ALIAS "INVOKEMETHOD" (BYVAL CurrX AS INTEGER, BYVAL CurrY AS INTEGER, BYVAL FColor AS INTEGER, BYVAL BColor AS INTEGER, Text AS STRING, BYVAL NumArgs AS INTEGER, BYVAL CID AS INTEGER, BYVAL MthID AS INTEGER)
DECLARE SUB InvokePrintFormMethod  ALIAS "INVOKEMETHOD" (BYVAL NumArgs AS INTEGER, BYVAL CID AS INTEGER, BYVAL MthID AS INTEGER)
DECLARE SUB InvokeCLSMethod        ALIAS "INVOKEMETHOD" (BYVAL NumArgs AS INTEGER, BYVAL CID AS INTEGER, BYVAL MthID AS INTEGER)
DECLARE SUB InvokeHideMethod       ALIAS "INVOKEMETHOD" (BYVAL NumArgs AS INTEGER, BYVAL CID AS INTEGER, BYVAL MthID AS INTEGER)
DECLARE SUB InvokeShowMethod       ALIAS "INVOKEMETHOD" (BYVAL Modal AS INTEGER, BYVAL NumArgs AS INTEGER, BYVAL CID AS INTEGER, BYVAL MthID AS INTEGER)
DECLARE SUB InvokeRefreshMethod    ALIAS "INVOKEMETHOD" (BYVAL NumArgs AS INTEGER, BYVAL CID AS INTEGER, BYVAL MthID AS INTEGER)
DECLARE SUB InvokeMoveMethod       ALIAS "INVOKEMETHOD" (BYVAL mLeft AS INTEGER, BYVAL mTop AS INTEGER, BYVAL mWidth AS INTEGER, BYVAL mHeight AS INTEGER, BYVAL NumArgs AS INTEGER, BYVAL CID AS INTEGER, BYVAL MthID AS INTEGER)
DECLARE SUB InvokeSetFocusMethod   ALIAS "INVOKEMETHOD" (BYVAL NumArgs AS INTEGER, BYVAL CID AS INTEGER, BYVAL MthID AS INTEGER)
DECLARE SUB InvokeDragMethod       ALIAS "INVOKEMETHOD" (BYVAL Action AS INTEGER, BYVAL NumArgs AS INTEGER, BYVAL CID AS INTEGER, BYVAL MthID AS INTEGER)


FUNCTION MyControl_CClick(Ctrl as Control, ByVal ControlId as Integer) AS INTEGER

'
' Place your comments and code for this event here.
' Basic errors are triggered by returning a non-zero value (ERR).
' Set and get properties and invoke methods and user events and 
' by using the appropriate callbacks declared above.
' PropertyID, EventID, and MethodID constant definitions are
' are contained in the CUSTINCL include file.
'

' IMPORTANT: You must always have a return value.
    MyControl_CClick = 0

END FUNCTION 

FUNCTION MyControl_CKeyPress(Ctrl as Control, ByVal ControlId as Integer, KeyAscii as Integer) AS INTEGER

'
' Place your comments and code for this event here.
' Basic errors are triggered by returning a non-zero value (ERR).
' Set and get properties and invoke methods and user events and 
' by using the appropriate callbacks declared above.
' PropertyID, EventID, and MethodID constant definitions are
' are contained in the CUSTINCL include file.
'

' IMPORTANT: You must always have a return value.
    MyControl_CKeyPress = 0

END FUNCTION 

FUNCTION MyControl_CIntegerGet(Ctrl as Control, ByVal ControlId as Integer, ByVal PropertyID as Integer, Value as Integer) AS INTEGER

'
' Place your comments and code for this event here.
' Basic errors are triggered by returning a non-zero value (ERR).
' Set and get properties and invoke methods and user events and 
' by using the appropriate callbacks declared above.
' PropertyID, EventID, and MethodID constant definitions are
' are contained in the CUSTINCL include file.
'

' IMPORTANT: You must always have a return value.
    MyControl_CIntegerGet = 0

END FUNCTION 
