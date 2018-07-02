; ----------------------------------------------------------------------------
; CUSTCALL.ASM: Custom Control Callback Examples
;
; Copyright (C) 1982-1992 Microsoft Corporation
;
; You have a royalty-free right to use, modify, reproduce
; and distribute the sample applications and toolkits provided with
; Visual Basic for MS-DOS (and/or any modified version)
; in any way you find useful, provided that you agree that
; Microsoft has no warranty, obligations or liability for
; any of the sample applications or toolkits.
;
; NOTE: This file demonstrates sample usage of the custom control
; callbacks. It is provided for examples of how different
; callbacks work. It is not part of a working custom control.
; ----------------------------------------------------------------------------

; Include file containing constant definitions for
; Property, Event, Method and ControlType ID numbers.
include custincl.inc

; Declarations for custom control callbacks.
; These callbacks are used to set and get custom control
; properties and invoke custom control methods and events.
;

; Declare callbacks for setting and getting property values
extrn SetProperty:far
extrn GetProperty:far

; Declare callback for getting a control's container object.
; This callback returns a control ID for the container object.
extrn GetContainer:far

; Declare callback for setting a control's attributes.
extrn SetAttribute:far            ; Refer to custom control section
								  ; in README.TXt for information on
								  ; using this callback.

; Declare callbacks for invoking methods and events.  These
; callbacks accept a variable number and types of arguments
; depending on the method or event that is being invoked.
extrn InvokeEvent:far
extrn InvokeMethod:far

_DATA   SEGMENT WORD PUBLIC 'DATA'

ControlID1  DW  0       ; Storage for ControlId value
ControlID2  DW  0       ; Storage for ControlId value
SourceControlID DW  0   ; ControlId value for DragDrop source

Left1       DW  0       ; stores custom1.left
Top1        DW  0       ; stores Top
Interval1   DD  0       ; stores custom1.interval
SDVal1      DD  0       ; stores custom1.caption
ContainerID DW  0       ; stores parent ID
CoordX      DD  0       ; stores x coord
CoordY      DD  0       ; store y coord
TypeOfControl   DW  0   ; stores TYPEOF info

_DATA   ENDS

DGROUP  GROUP _DATA

MYCONTROL_CODE SEGMENT BYTE PUBLIC 'CODE'
	ASSUME  CS:MYCONTROL_CODE
	ASSUME  DS:DGROUP


; -------------------------------------------------------------------
; The examples below assume that SDVal1 contains a valid Basic
; string descriptor.  See the Mixed-Language Programming chapter
; in the Professional Features Guide for more information.
; ---------------------------------------------------------------------


; SetAttribute example

; Example of using the SetAttribute callback to specify access
; key for a custom control.  Note, it is up to the custom control
; developer to actually display the text containing the access key.

	; Set Alt+A or Alt+a as the access key.
	mov     ax,ControlID1
	push    ax
	mov     ax,ATTR_AccessKey
	push    ax
	mov     ax,65           ; Alt+A.
	push    ax
	call    SetAttribute
	

; Property set examples

; SetProperty is a callback used to set INTEGER, LONG, and STRING properties.
; All arguments to this routine must be passed BYVAL (the string for
; string property set must be passed by reference however).  The callback
; determines property type (INTEGER, LONG, STRING) based on the
; PropertyID (last argument).  If an incorrect value type is passed
; for the given PropertyID, unpredictable results will occur.

; control.left = 25
	mov     ax,25
	push    ax
	mov     ax,ControlID1
	push    ax
	mov     ax,PROP_Left
	push    ax
	call    SetProperty

; control.interval = 50000
	mov     ax,0H
	push    ax
	mov     ax,0C350H
	push    ax
	mov     ax,ControlID1
	push    ax
	mov     ax,PROP_Interval
	push    ax
	call    SetProperty

; control.caption = SDVal
	mov     ax,offset SDVal1
	push    ax
	mov     ax,ControlID1
	push    ax
	mov     ax,PROP_Caption
	push    ax
	call    SetProperty


; Property get examples

; GetProperty is a callback used to get INTEGER, LONG, and STRING properties.
; The first argument to this routine must be passed by reference,
; all others must be passed BYVAL.  The property value corresponding
; to the PropertyID (last argument) is returned via the first argument (not
; returned by Getproperty itself).  The callback determines
; property type (INTEGER, LONG, STRING) based on the PropertyID
; (last argument).  If an incorrect data type is passed
; for the given PropertyID, unpredictable results will occur.

; Left1 = Control1.left
	mov     ax,offset Left1
	push    ax
	mov     ax,ControlID1
	push    ax
	mov     ax,PROP_Left
	push    ax
	call    GetProperty

; Interval1 = Control1.Interval
	mov     ax,offset Interval1
	push    ax
	mov     ax,ControlID1
	push    ax
	mov     ax,PROP_Interval
	push    ax
	call    GetProperty

; SDVal1 = Control1.caption
	mov     ax,offset SDVal1
	push    ax
	mov     ax,ControlID1
	push    ax
	mov     ax,PROP_Caption
	push    ax
	call    GetProperty


; Example of using the GetProperty callback to retrieve the
; control's type (TYPEOF).
	mov     ax,offset TypeOfControl
	push    ax
	mov     ax,ControlID1
	push    ax
	mov     ax,PROP_TypeOf
	push    ax
	call    GetProperty
	cmp     TypeOfControl,TYPEOF_Form   ; found a FORM?
	jne     @F                          ; branch if not.
	; Add code to print, "FORM found as container"


@@:

; GetContainer example

; Example of using the GetContainer callback to retrieve
; a control's container object (returned as a ControlID).
	mov     ax,ControlID1
	push    ax
	call    GetContainer
	mov     ContainerID,ax


; InvokeEvent example

; Example of using the InvokeEvent callback to trigger a
; custom control's DragDrop event and execute user's DragDrop
; code if it exists.  The standard event arguments (passed to
; the user's code) are listed
; first, followed by the ControlID and EventID for the control
; and event to be triggered.  If the arguments passed don't match
; the number and type of arguments expected for the EventID,
; unpredictable results will occur.

	mov     ax,SourceControlID
	push    ax
	mov     ax,offset DGROUP:CoordX
	push    ax
	mov     ax,offset DGROUP:CoordY
	push    ax
	mov     ax,ControlID1
	push    ax
	mov     ax,EVENT_DragDrop
	push    ax
	call    InvokeEvent


; InvokeMethod example

; Example of using the InvokeMethod callback to invoke
; a custom control's MOVE method.  The MOVE method can take
; up to 4 arguments (left, top, width, height).  The
; order in which the arguments are passed to InvokeMethod
; is the same as that for the method, followed by the
; number of arguments and the ControlID and
; MethodID.  All arguments must be passed by value.
; If the arguments passed don't match the number and type of
; arguments expected for the MethodID, unpredictable results will occur.

	mov     ax,Left1
	push    ax
	mov     ax,Top1
	push    ax
	mov     ax,2
	push    ax
	mov     ax,ControlID1
	push    ax
	mov     ax,METHOD_Move
	push    ax
	call    InvokeMethod

MYCONTROL_CODE  ENDS

END

