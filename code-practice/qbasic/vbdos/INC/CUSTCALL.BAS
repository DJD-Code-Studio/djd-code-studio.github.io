' ----------------------------------------------------------------------------
' CUSTCALL.BAS: Custom Control Callback Examples
'
' Copyright (C) 1982-1992 Microsoft Corporation
'
' You have a royalty-free right to use, modify, reproduce
' and distribute the sample applications and toolkits provided with
' Visual Basic for MS-DOS (and/or any modified version)
' in any way you find useful, provided that you agree that
' Microsoft has no warranty, obligations or liability for
' any of the sample applications or toolkits.
'
' NOTE: This file demonstrates sample usage of the custom control
' callbacks. It is provided for examples of how different
' callbacks work. It is not part of a working custom control.
' ----------------------------------------------------------------------------

' Include file containing constant definitions for
' Property, Event, Method and ControlType ID numbers.
'$INCLUDE: 'custincl.bi'

' Declarations for custom control callbacks.
' These callbacks are used to set and get custom control
' properties and invoke custom control methods and events.
'
'    AID = Attribute Id - list is found in CUSTINCL.BI
'    CID = Control Id created internally by Visual Basic
'    PID = Property Id - list is found in CUSTINCL.BI

' Declare callbacks for setting and getting property values
DECLARE SUB SetProperty
DECLARE SUB GetProperty

' Declare callback for getting a control's container object.
' This callback returns a CID for the container object.
DECLARE FUNCTION GetContainer (CID AS INTEGER) AS INTEGER

' Declare callback for setting a control's attributes (access key,
' focus availability, arrow key trapping ability, and text cursor
' location).  Refer to the custom control section of the README.TXT
' file for complete information on using this callback.
DECLARE SUB SetAttribute (BYVAL CID AS INTEGER, BYVAL AID AS INTEGER, BYVAL Value AS INTEGER)

' Declare callbacks for invoking methods and events.  These
' callbacks accept a variable number and types of arguments
' depending on the method or event that is being invoked.
DECLARE SUB InvokeEvent
DECLARE SUB InvokeMethod

DIM SHARED ControlID1 AS INTEGER        ' Storage for ControlId value
DIM SHARED ControlID2 AS INTEGER        ' Storage for ControlId value
DIM SHARED SourceControlID AS INTEGER   ' ControlId value for DragDrop source

DIM SHARED Left1 AS INTEGER             ' stores custom1.left
DIM SHARED Top1  AS INTEGER             ' stores top
DIM SHARED Interval1 AS LONG            ' stores custom1.interval
DIM SHARED SDVal1 AS STRING             ' stores custom1.caption
DIM SHARED ContainerID AS INTEGER       ' stores parent ID
DIM SHARED CoordX AS SINGLE             ' stores x coord for dragdrop
DIM SHARED CoordY AS SINGLE             ' stores x coord for dragdrop
DIM SHARED TypeOfControl AS INTEGER     ' stores TYPEOF info

' SetAttribute example
SUB AttributeSet ()

' Example of using the SetAttribute callback to specify access
' key for a custom control.  Note, it is up to the custom control
' developer to actually display the text containing the access key.

	' Set Alt+A or Alt+a as the access key.
	SetAttribute ControlID1, ATTR_AccessKey, 65      'Alt+A.

END SUB

' InvokeEvent example
SUB EventInvoke ()

' Example of using the InvokeEvent callback to trigger a
' custom control's DragDrop event and execute user's DragDrop
' code if it exists.  The standard event arguments (passed to
' the user's code) are listed
' first, followed by the ControlID and EventID for the control
' and event to be triggered.  If the arguments passed don't match
' the number and type of arguments expected for the EventID, 
' unpredictable results will occur.

	InvokeEvent BYVAL SourceControlID, CoordX, CoordY, BYVAL ControlID1, BYVAL EVENT_DragDrop

END SUB

' GetContainer example
SUB GetParent ()

' Example of using the GetContainer callback to retrieve
' a control's container object (returned as a ControlID).
	ContainerID = GetContainer(ControlID1)

END SUB

' InvokeMethod example
SUB MethodInvoke ()

' Example of using the InvokeMethod callback to invoke
' a custom control's MOVE method.  The MOVE method can take
' up to 4 arguments (left, top, width, height).  The
' order in which the arguments are passed to InvokeMethod
' is the same as that for the method, followed by the
' number of arguments and the ControlID and
' MethodID.  All arguments must be passed by value.
' If the arguments passed don't match the number and type of
' arguments expected for the MethodID, unpredictable results will occur.

	InvokeMethod BYVAL Left1, BYVAL Top1, BYVAL 2, BYVAL ControlID1, BYVAL METHOD_Move

END SUB

' Property get examples
SUB PropGet ()

' GetProperty is a callback used to get INTEGER, LONG, and STRING properties.
' The first argument to this routine must be passed by reference,
' all others must be passed BYVAL.  The property value corresponding
' to the PropertyID (last argument) is returned via the first argument (not
' returned by Getproperty itself).  The callback determines
' property type (INTEGER, LONG, STRING) based on the PropertyID
' (last argument).  If an incorrect data type is passed
' for the given PropertyID, unpredictable results will occur.

'Left1 = Control1.left
	GetProperty Left1, BYVAL ControlID1, BYVAL PROP_Left

'Interval1 = Control1.Interval
	GetProperty Interval1, BYVAL ControlID1, BYVAL PROP_Interval

'SDVal1 = Control1.caption
	GetProperty SDVal1, BYVAL ControlID1, BYVAL PROP_Caption

' Example of using the GetProperty callback to retrieve the
' control's type (TYPEOF).
	GetProperty TypeOfControl, BYVAL ControlID1, BYVAL PROP_TypeOf                           'TypeOfControl = Control1.TypeOf
	IF TypeOfControl = TYPEOF_Form THEN
		PRINT "Container is a FORM"
	END IF

END SUB

' Property set examples
SUB PropSet ()

' SetProperty is a callback used to set INTEGER, LONG, and STRING properties.
' All arguments to this routine must be passed BYVAL (the string for
' string property set must be passed by reference however).  The callback
' determines property type (INTEGER, LONG, STRING) based on the
' PropertyID (last argument).  If an incorrect value type is passed
' for the given PropertyID, unpredictable results will occur.

'control.left = 25
	SetProperty BYVAL 25, BYVAL ControlID1, BYVAL PROP_Left

'control.interval = 50000L
	SetProperty BYVAL 50000, BYVAL ControlID1, BYVAL PROP_Interval

'control.caption = SDVal1
	SetProperty SDVal1, BYVAL ControlID1, BYVAL PROP_Caption

END SUB

