' ----------------------------------------------------------------------------
' SPIN.BAS: Spin Custom Control Event Procedures
'
' The Spin custom control can be used with another
' control to increment and decrement numbers.  It can
' also be used to scroll back and forth through a
' range of values or a list of items.
'
' At run-time, when the user clicks the up (or right)
' arrow of the spin button or presses the up (or right)
' arrow key, Custom events of type "SpinUp" are
' generated and the value property is incremented accordingly.
' Likewise, when the user clicks the down (or left) arrow
' of the spin button or presses the down (or left) arrow
' key, Custom events of type "SpinDown" are generated and
' the value property is decremented.
'
' The Style property determines the type of spin
' control:
'     0 - Vertical (default)
'     1 - Horizontal
' The Interval property is used to determine how often
'     the SpinUp and SpinDown events are generated (in
'     milliseconds - default = 100).
' The Min and Max properties determine the lower and
'     upper range that the Value property cycles
'     (or spins) through.  When Value becomes equal
'     to Max it is reset to Min and vice-versa.
' The BorderStyle property is not available at
' run-time.  Width and Height properties are read-only
' at run-time - the control size is fixed.  All other
' properties behave similar to the same properties of
' the standard controls.
'
' Custom control event procedure template created by
' CUSTGEN.EXE (Custom Control Template Generator).
' CUSTGEN.EXE is a utility provided to make custom
' control development easier.  It allows you to select
' the events you want your custom control to respond to,
' then generates code templates and a custom control
' registration routine for these events.
'
' Modify the code template file as necessary, then build
' your custom control as follows:
'    ML -c spinreg.asm             ; Assumes Masm 6.0 compiler
'    BC /x/o spin.bas;
'    DEL spin.lib                  ; Delete existing library if exists
'    LIB spin.lib+spinreg.obj+spin.obj
'    LINK /Q spin.lib,spin.qlb,,VBDOSQLB.LIB;
' You can combine the spin custom control with other custom controls
' into one Quick library for use within the programming environment
' as follows:
'    DEL <CombinedLib.LIB>         ; Delete existing library if exists
'    LIB <CombinedLib.LIB>+spin.lib+<Cust2.LIB>+<CustN.LIB>
'    LINK /Q <CombinedLib.LIB>,<CombinedLib.QLB>,,VBDOSQLB.LIB;
' To create an Alternate Math custom control library (instead of an
' Emulator Math custom control library as shown above), compile
' SPIN.BAS with the /FPa switch.  Note, an Altmath library cannot be
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
DECLARE SUB SetIntProperty ALIAS "SetProperty" (BYVAL value AS INTEGER, BYVAL CID AS INTEGER, BYVAL PID AS INTEGER)
DECLARE SUB SetStringProperty ALIAS "SetProperty" (value AS STRING, BYVAL CID AS INTEGER, BYVAL PID AS INTEGER)
DECLARE SUB SetLongProperty ALIAS "SetProperty" (BYVAL value AS LONG, BYVAL CID AS INTEGER, BYVAL PID AS INTEGER)

' Declare callback for setting a control's attributes (access key,
' focus availability, arrow key trapping ability, and text cursor
' location).
DECLARE SUB SetAttribute (BYVAL CID AS INTEGER, BYVAL AID AS INTEGER, BYVAL value AS INTEGER)

' Declare callback for getting a control's container object.
' This callback returns a CID for the container object.
DECLARE FUNCTION GetContainer (BYVAL CID AS INTEGER) AS INTEGER

' Procedure declarations for handled events.
DECLARE FUNCTION Spin_CClick (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CDblClick (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CIntegerGet (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL PropertyId AS INTEGER, value AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CIntegerSet (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL PropertyId AS INTEGER, BYVAL value AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CGotFocus (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CKeyDown (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, keycode AS INTEGER, Shift AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CKeyPress (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, KeyAscii AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CKeyUp (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, keycode AS INTEGER, Shift AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CLoad (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CLostFocus (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CMouseDown (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, Button AS INTEGER, Shift AS INTEGER, X AS SINGLE, Y AS SINGLE) AS INTEGER
DECLARE FUNCTION Spin_CMouseMove (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, Button AS INTEGER, Shift AS INTEGER, X AS SINGLE, Y AS SINGLE) AS INTEGER
DECLARE FUNCTION Spin_CMouseUp (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, Button AS INTEGER, Shift AS INTEGER, X AS SINGLE, Y AS SINGLE) AS INTEGER
DECLARE FUNCTION Spin_CMthAddItem (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL Count AS INTEGER, value AS STRING, BYVAL Index AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CMthCls (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CMthHide (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CMthMove (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL Count AS INTEGER, BYVAL pLeft AS INTEGER, BYVAL pTop AS INTEGER, BYVAL pWidth AS INTEGER, BYVAL pHeight AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CMthPrint (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CMthRemoveItem (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL Count AS INTEGER, BYVAL Index AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CMthShow (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL Count AS INTEGER, BYVAL Modal AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CPaint (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CStringGet (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL PropertyId AS INTEGER, value AS STRING, Index AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CStringSet (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL PropertyId AS INTEGER, value AS STRING, Index AS INTEGER) AS INTEGER
DECLARE FUNCTION Spin_CTimer (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
DECLARE SUB FireSpin (Ctrl AS CONTROL, ControlID AS INTEGER, FromRoutine$)


DIM SHARED wSpin_ButtonDown AS INTEGER  ' Button is depressed.
DIM SHARED wSpin_Tracking   AS INTEGER  ' Currently tracking spin events.
DIM SHARED sSpin_X AS SINGLE            ' X mouse coordinate.
DIM SHARED sSpin_Y AS SINGLE            ' Y mouse coordinate.

' Constant definitions.
CONST SPIN_UP = 1                   ' Spin directions.
CONST SPIN_DOWN = 2
CONST KEY_LEFT = 37                 ' Key trapping.
CONST KEY_UP = 38
CONST KEY_RIGHT = 39
CONST KEY_DOWN = 40
CONST LEFT_BUTTON = 1               ' Mouse button.
CONST TRUE = -1                     ' True/False.
CONST FALSE = 0

' Error codes.
CONST ERR_METHNOTAPPLICABLE = 421   ' Method not applicable for this object
CONST ERR_INVALIDPROPVALUE = 380    ' Invalid property value
CONST ERR_PROPERTYRO = 383          ' Property is read-only
CONST ERR_PROPNOTFOUND = 422        ' Property not found
CONST ERR_PROPNOTAVAIL = 386        ' Property not available at run-time

' Control procedure for generating spin events.
' Determine which direction to spin, then adjusts value
' and fires event accordingly.
SUB FireSpin (Ctrl AS CONTROL, ControlID AS INTEGER, FromRoutine$)
    DIM w AS INTEGER
    DIM h AS INTEGER
    DIM wSpinDir%
    DIM mx AS INTEGER
    DIM mn AS INTEGER
    DIM v AS LONG

    mx = Ctrl.Max
    mn = Ctrl.Min
    v = Ctrl.value

    ' Determine which direction to spin and calculate
    ' new value.
    IF Ctrl.Style = 1 THEN
        w = Ctrl.Width \ 2
        IF (sSpin_X < w) THEN
            wSpinDir% = SPIN_DOWN
            v = v - 1
        ELSE
            wSpinDir% = SPIN_UP
            v = v + 1
        END IF
    ELSE
        h = Ctrl.Height \ 2
        IF (sSpin_Y < h) THEN
            wSpinDir% = SPIN_UP
            v = v + 1
        ELSE
            wSpinDir% = SPIN_DOWN
            v = v - 1
        END IF
    END IF

    ' Store new Value
    IF (v < mn) THEN v = mx
    IF (v > mx) THEN v = mn
    SetIntProperty CINT(v), ControlID, PROP_Value

    ' Invoke CUSTOM event with correct event type.
    ON LOCAL ERROR RESUME NEXT
    ERR = 0
    InvokeEvent wSpinDir%, BYVAL ControlID, BYVAL EVENT_Custom
    IF (ERR) THEN MSGBOX FromRoutine$ + ": " + ERROR$, 0, "Spin Custom Control Assertion"
END SUB

' Click event for control.
FUNCTION Spin_CClick (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
    ' Trap event so not sent to user's code.
END FUNCTION

' Double click event for control.
FUNCTION Spin_CDblClick (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
    ' Trap event so not sent to user's code.
END FUNCTION

' GotFocus event for control.
' Sets blinking cursor to show focus.
FUNCTION Spin_CGotFocus (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
    SetAttribute ControlID, ATTR_TextCursor, TC_UnderScore
END FUNCTION

' Integer property get event for control.
' Allows value retrieval for supported properties.
FUNCTION Spin_CIntegerGet (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL PropertyId AS INTEGER, value AS INTEGER) AS INTEGER
    SELECT CASE PropertyId
        ' Return value of supported properties.
        CASE PROP_Width, PROP_Height, PROP_Style, PROP_Min, PROP_Max, PROP_Value, PROP_DragMode, PROP_Index, PROP_MousePointer, PROP_TabIndex, PROP_TabStop, PROP_BackColor, PROP_ForeColor, PROP_Top, PROP_Left, PROP_Enabled, PROP_Visible:
            Spin_CIntegerGet = 0
        ' Borderstyle not available at run-time.
        CASE PROP_BorderStyle:
            Spin_CIntegerGet = ERR_PROPNOTAVAIL
        ' All other properties not supported for this control.
        CASE ELSE
            Spin_CIntegerGet = ERR_PROPNOTFOUND
    END SELECT
END FUNCTION

' Integer property set event for control.
' Allows supported property values to be set.
FUNCTION Spin_CIntegerSet (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL PropertyId AS INTEGER, BYVAL value AS INTEGER) AS INTEGER
    DIM v AS INTEGER
    DIM wSpinDir AS INTEGER

    v = Ctrl.value
    SELECT CASE PropertyId
        ' Height and Width properties are read-only.
        CASE PROP_Width, PROP_Height:
            Spin_CIntegerSet = ERR_PROPERTYRO

        ' Borderstyle is not available at run-time.
        CASE PROP_BorderStyle:
            Spin_CIntegerSet = ERR_PROPNOTAVAIL

        ' Set control height and width based on style property.
        CASE PROP_Style:
            SELECT CASE value
                CASE 0
                    SetIntProperty 1, ControlID, PROP_Width
                    SetIntProperty 2, ControlID, PROP_Height
                    SetIntProperty 0, ControlID, PROP_Style
                    Spin_CIntegerSet = Spin_CPaint(Ctrl, ControlID)
                CASE 1
                    SetIntProperty 2, ControlID, PROP_Width
                    SetIntProperty 1, ControlID, PROP_Height
                    SetIntProperty 1, ControlID, PROP_Style
                    Spin_CIntegerSet = Spin_CPaint(Ctrl, ControlID)
                CASE ELSE
                    Spin_CIntegerSet = ERR_INVALIDPROPVALUE
            END SELECT
        
        ' Set min property and adjust value property if needed.
        CASE PROP_Min:
            IF value > Ctrl.Max THEN
                IF (v < Ctrl.Max) THEN SetIntProperty Ctrl.Max, ControlID, PROP_Value
            ELSE
                IF (v < value) THEN SetIntProperty value, ControlID, PROP_Value
            END IF
            SetIntProperty value, ControlID, PropertyId

        ' Set max property and adjust value property if needed.
        CASE PROP_Max:
            IF value < Ctrl.Min THEN
                IF (v > Ctrl.Min) THEN SetIntProperty Ctrl.Min, ControlID, PROP_Value
            ELSE
                IF (v > value) THEN SetIntProperty value, ControlID, PROP_Value
            END IF
            SetIntProperty value, ControlID, PropertyId

        ' Set value property, adjusting it if needed.
        CASE PROP_Value:
            ' Value cannot be greater than Max.
            IF value > Ctrl.Max THEN
                SetIntProperty Ctrl.Max, ControlID, PROP_Value
            ' Value cannot be less than Min.
            ELSEIF value < Ctrl.Min THEN
                SetIntProperty Ctrl.Min, ControlID, PROP_Value
            ELSE
                SetIntProperty value, ControlID, PROP_Value
            END IF

        ' Allow other supported properties to be set.
        CASE PROP_DragMode, PROP_Index, PROP_MousePointer, PROP_TabIndex, PROP_TabStop, PROP_Interval, PROP_BackColor, PROP_ForeColor, PROP_Top, PROP_Left, PROP_Enabled, PROP_Visible:
            ERR = 0
            ON LOCAL ERROR RESUME NEXT
            SetIntProperty value, ControlID, PropertyId
            Spin_CIntegerSet = ERR

        ' All other properties are not supported.
        CASE ELSE
            Spin_CIntegerSet = ERR_PROPNOTFOUND
    END SELECT

    ' Fire Spin event if Value has changed due to
    ' Min or Max property settings.
    IF Ctrl.value > v THEN
        wSpinDir = SPIN_UP
    ELSEIF Ctrl.value < v THEN
        wSpinDir = SPIN_DOWN
    ELSE
        wSpinDir = 0
    END IF

    IF wSpinDir > 0 THEN
        ' Invoke CUSTOM event with correct event type.
        ON LOCAL ERROR RESUME NEXT
        ERR = 0
        InvokeEvent wSpinDir, BYVAL ControlID, BYVAL EVENT_Custom
        IF (ERR) THEN MSGBOX "Load: " + ERROR$, 0, "Spin Custom Control Assertion"
    END IF

END FUNCTION

' KeyDown event for control.
' Fires spin events based on key that is pressed.
FUNCTION Spin_CKeyDown (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, keycode AS INTEGER, Shift AS INTEGER) AS INTEGER
    SELECT CASE keycode
    CASE KEY_LEFT, KEY_DOWN
        sSpin_X = 0
        sSpin_Y = 1
        wSpin_Tracking = ControlID
        CALL FireSpin(Ctrl, ControlID, "KEYDOWN")
    CASE KEY_RIGHT, KEY_UP
        sSpin_X = 1
        sSpin_Y = 0
        wSpin_Tracking = ControlID
        CALL FireSpin(Ctrl, ControlID, "KEYDOWN")
    END SELECT
END FUNCTION

' KeyPress event for control.
FUNCTION Spin_CKeyPress (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, KeyAscii AS INTEGER) AS INTEGER
    ' Trap event so not sent to user's code.
END FUNCTION

' KeyDown event for control.
' Ends spin events.
FUNCTION Spin_CKeyUp (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, keycode AS INTEGER, Shift AS INTEGER) AS INTEGER
    wSpin_Tracking = FALSE
END FUNCTION

' Load event for control.
' Sets default property values at control load time.
FUNCTION Spin_CLoad (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
    DIM Min AS INTEGER
    DIM Max AS INTEGER
    DIM v AS INTEGER
    DIM wSpinDir AS INTEGER

    ' Set run-time borderstyle (none).
    SetIntProperty 0, ControlID, PROP_BorderStyle

    ' Set control width and height based on style (horizontal or vertical).
    IF (Ctrl.Style = 1) THEN
        SetIntProperty 1, ControlID, PROP_Height
        SetIntProperty 2, ControlID, PROP_Width
    ELSE
        SetIntProperty 1, ControlID, PROP_Width
        SetIntProperty 2, ControlID, PROP_Height
        SetIntProperty 0, ControlID, PROP_Style
    END IF

    Min = Ctrl.Min
    Max = Ctrl.Max
    v = Ctrl.value

    ' Set default max value.
    IF Max = 0 THEN SetIntProperty 32767, ControlID, PROP_Max

    ' Set value property based on min and max.
    IF v < Min AND Min < Max THEN
        SetIntProperty Min, ControlID, PROP_Value
    ELSEIF v > Max AND Min < Max THEN
        SetIntProperty Max, ControlID, PROP_Value
    ELSEIF v < Max AND Max < Min THEN
        SetIntProperty Max, ControlID, PROP_Value
    ELSEIF v > Min AND Max < Min THEN
        SetIntProperty Min, ControlID, PROP_Value
    END IF

    ' Set default interval value.
    IF Ctrl.Interval = 0 THEN SetLongProperty 100, ControlID, PROP_Interval

    ' Fire Spin event if Value has changed due to
    ' Min or Max property settings.
    IF Ctrl.value > v THEN
        wSpinDir = SPIN_UP
    ELSEIF Ctrl.value < v THEN
        wSpinDir = SPIN_DOWN
    ELSE
        wSpinDir = 0
    END IF

    IF wSpinDir > 0 THEN
        ' Invoke CUSTOM event with correct event type.
        ON LOCAL ERROR RESUME NEXT
        ERR = 0
        InvokeEvent wSpinDir, BYVAL ControlID, BYVAL EVENT_Custom
        IF (ERR) THEN MSGBOX "Load: " + ERROR$, 0, "Spin Custom Control Assertion"
    END IF
END FUNCTION

' LostFocus event for control.
' Turns off blinking cursor to show no focus.
FUNCTION Spin_CLostFocus (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
    SetAttribute ControlID, ATTR_TextCursor, TC_NoCursor
END FUNCTION

' MouseDown event for control.
' Fires spin events based on cursor location.
FUNCTION Spin_CMouseDown (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, Button AS INTEGER, Shift AS INTEGER, X AS SINGLE, Y AS SINGLE) AS INTEGER
    DIM w AS INTEGER
    DIM h AS INTEGER
    DIM wSpinDir%

    ' Store current cursor location and mouse state.
    sSpin_X = X
    sSpin_Y = Y
    wSpin_ButtonDown = TRUE
    wSpin_Tracking = ControlID

    ' Fire spin event.
    CALL FireSpin(Ctrl, ControlID, "MOUSEDOWN")
END FUNCTION

' MouseMove event for control.
' Fires spin events based on cursor location.
FUNCTION Spin_CMouseMove (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, Button AS INTEGER, Shift AS INTEGER, X AS SINGLE, Y AS SINGLE) AS INTEGER
    ' Store current cursor location and mouse state.
    sSpin_X = X
    sSpin_Y = Y

    ' If mouse button is still down, update tracking information.
    IF (wSpin_ButtonDown) THEN
        IF ((X >= 0) AND (X < Ctrl.Width)) THEN
            IF ((Y >= 0) AND (Y < Ctrl.Height)) THEN
                wSpin_Tracking = ControlID
            ELSE
                wSpin_Tracking = FALSE
            END IF
        ELSE
            wSpin_Tracking = FALSE
        END IF
    END IF
END FUNCTION

' MouseUp event for control.
' Ends spin events.
FUNCTION Spin_CMouseUp (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, Button AS INTEGER, Shift AS INTEGER, X AS SINGLE, Y AS SINGLE) AS INTEGER
    ' Store current cursor location and mouse state.
    sSpin_X = X
    sSpin_Y = Y
    wSpin_ButtonDown = FALSE
    wSpin_Tracking = FALSE
END FUNCTION

' Method trap - returns error if attempt to use unsupported methods.
FUNCTION Spin_CMthAddItem (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL Count AS INTEGER, value AS STRING, BYVAL Index AS INTEGER) AS INTEGER
    Spin_CMthAddItem = ERR_METHNOTAPPLICABLE
END FUNCTION

' Method trap - returns error if attempt to use unsupported methods.
FUNCTION Spin_CMthCls (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
    Spin_CMthCls = ERR_METHNOTAPPLICABLE
END FUNCTION

' Method trap - returns error if attempt to use unsupported methods.
FUNCTION Spin_CMthHide (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
    Spin_CMthHide = ERR_METHNOTAPPLICABLE
END FUNCTION

' Move method trap.
' Traps attempts to size control via Move method
' as control size is read-only at run-time.
FUNCTION Spin_CMthMove (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL Count AS INTEGER, BYVAL pLeft AS INTEGER, BYVAL pTop AS INTEGER, BYVAL pWidth AS INTEGER, BYVAL pHeight AS INTEGER) AS INTEGER
    ' Can't size control.
    IF (Count > 2) THEN
        Spin_CMthMove = ERR_PROPERTYRO
    ' Move control.
    ELSE
        ERR = 0
        ON LOCAL ERROR RESUME NEXT
        Ctrl.Left = pLeft
        IF (ERR) THEN
            Spin_CMthMove = ERR
            EXIT FUNCTION
        END IF

        ERR = 0
        Ctrl.Top = pTop
        IF (ERR) THEN
            Spin_CMthMove = ERR
            EXIT FUNCTION
        END IF

        Spin_CMthMove = Spin_CPaint(Ctrl, ControlID)
    END IF
END FUNCTION

' Method trap - returns error if attempt to use unsupported methods.
FUNCTION Spin_CMthPrint (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
    Spin_CMthPrint = ERR_METHNOTAPPLICABLE
END FUNCTION

' Method trap - returns error if attempt to use unsupported methods.
FUNCTION Spin_CMthRemoveItem (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL Count AS INTEGER, BYVAL Index AS INTEGER) AS INTEGER
    Spin_CMthRemoveItem = ERR_METHNOTAPPLICABLE
END FUNCTION

' Method trap - returns error if attempt to use unsupported methods.
FUNCTION Spin_CMthShow (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL Count AS INTEGER, BYVAL Modal AS INTEGER) AS INTEGER
    Spin_CMthShow = ERR_METHNOTAPPLICABLE
END FUNCTION

' Paint event for control.
' Displays spin control based on control style.
FUNCTION Spin_CPaint (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
    DIM w AS INTEGER
    DIM h AS INTEGER
    DIM X AS INTEGER
    DIM Y AS INTEGER
    DIM f AS INTEGER
    DIM b AS INTEGER
    DIM S$

    f = Ctrl.ForeColor
    b = Ctrl.BackColor

    w = Ctrl.Width \ 2
    h = Ctrl.Height \ 2

    ' Draw horizontal spin control.
    IF Ctrl.Style = 1 THEN
        InvokeMethod BYVAL 0, BYVAL 0, BYVAL f, BYVAL b, CHR$(17), BYVAL 5, BYVAL ControlID, BYVAL METHOD_Print
        X = Ctrl.Width - 1
        InvokeMethod BYVAL X, BYVAL 0, BYVAL f, BYVAL b, CHR$(16), BYVAL 5, BYVAL ControlID, BYVAL METHOD_Print
    ' Draw vertical spin control.
    ELSE
        X = 0
        Y = 0
        S$ = CHR$(30)
        InvokeMethod BYVAL X, BYVAL Y, BYVAL f, BYVAL b, S$, BYVAL 5, BYVAL ControlID, BYVAL METHOD_Print
        X = 0
        Y = Ctrl.Height - 1
        S$ = CHR$(31)
        InvokeMethod BYVAL X, BYVAL Y, BYVAL f, BYVAL b, S$, BYVAL 5, BYVAL ControlID, BYVAL METHOD_Print
    END IF
END FUNCTION

' String property get event for control.
' Allows value retrieval for supported properties.
FUNCTION Spin_CStringGet (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL PropertyId AS INTEGER, value AS STRING, Index AS INTEGER) AS INTEGER
        ' Only Tag string property is supported.
        IF (PropertyId <> PROP_Tag) THEN
            Spin_CStringGet = ERR_PROPNOTFOUND
        END IF
END FUNCTION

' String property set event for control.
' Allows tag property value to be set.
FUNCTION Spin_CStringSet (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER, BYVAL PropertyId AS INTEGER, value AS STRING, Index AS INTEGER) AS INTEGER
        ' Only Tag string property is supported.
        IF PropertyId = PROP_Tag THEN
            SetStringProperty value, ControlID, PROP_Tag
        ELSE
            Spin_CStringSet = ERR_PROPNOTFOUND
        END IF
END FUNCTION

' Timer event for control.
' Allows continuous firing of spin control provided mouse
' or key is down.
FUNCTION Spin_CTimer (Ctrl AS CONTROL, BYVAL ControlID AS INTEGER) AS INTEGER
    IF (wSpin_Tracking = ControlID) THEN
        CALL FireSpin(Ctrl, ControlID, "TIMER")
    END IF
END FUNCTION

