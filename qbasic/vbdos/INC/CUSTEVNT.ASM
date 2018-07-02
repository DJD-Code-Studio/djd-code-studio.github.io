; ----------------------------------------------------------------------------
; CUSTEVNT.ASM: Custom Control Event Procedures
;
; Custom control event procedure templates created by
; CUSTGEN.EXE (Custom Control Template Generator).
;
; CUSTGEN.EXE is a utility provided to make custom
; control development easier.  It allows you to select
; the events you want your custom control to respond to,
; then generates code templates and a custom control
; registration routine for these events.
;
; Modify the code template file as necessary, then build
; your custom control as follows:
;    ML -c <RegisterFile>          ; Assumes Masm 6.0 compiler
;    ML -c <TemplateFile>
;    DEL <TemplateFile.LIB>        ; Delete existing library if exists
;    LIB <TemplateFile.LIB>+<RegisterFile.OBJ>+<TemplateFile.OBJ>
;    LINK /Q <TemplateFile.LIB>,<TemplateFile.QLB>,,VBDOSQLB.LIB;
; You can combine multiple custom controls into one Quick library for
; use within the programming environment as follows:
;    DEL <CombinedLib.LIB>         ; Delete existing library if exists
;    LIB <CombinedLib.LIB>+<Cust1.LIB>+<Cust2.LIB>+<CustN.LIB>
;    LINK /Q <CombinedLib.LIB>,<CombinedLib.QLB>,,VBDOSQLB.LIB;
;
;
; Copyright (C) 1982-1992 Microsoft Corporation
;
; You have a royalty-free right to use, modify, reproduce
; and distribute the sample applications and toolkits provided with
; Visual Basic for MS-DOS (and/or any modified version)
; in any way you find useful, provided that you agree that
; Microsoft has no warranty, obligations or liability for
; any of the sample applications or toolkits.
; ----------------------------------------------------------------------------
;
; Memory model and include files.
.MODEL    medium, basic

; Include file containing constant definitions for
; Property, Event, Method and ControlType ID numbers.
INCLUDE   CUSTINCL.INC

; Callback declarations for invoking methods and events and getting
; and setting properties.  These callbacks accept a variable number 
; and types of arguments depending on the method or event that is 
; being invoked.
EXTRN InvokeEvent:FAR
EXTRN InvokeMethod:FAR
EXTRN GetProperty:FAR
EXTRN SetProperty:FAR
EXTRN GetContainer:FAR
EXTRN SetAttribute:FAR            ; Refer to custom control section
                                  ; in README.TXt for information on
                                  ; using this callback.


.CODE   MyControl_TEXT


PUBLIC   MyControl_CClick
MyControl_CClick PROC, Ctrl:WORD, ControlId:WORD

;
; Place your comments and code for this event here.
; Basic errors are triggered by returning a non-zero value (ERR).
; Set and get properties and invoke methods and user events and 
; by using the appropriate callbacks declared above.
; PropertyID, EventID, and MethodID constant definitions are
; are contained in the CUSTINCL include file.
;

; IMPORTANT: You must always have a return value.
    XOR ax,ax                      ; Return no errors
    RET

MyControl_CClick ENDP

PUBLIC   MyControl_CKeyPress
MyControl_CKeyPress PROC, Ctrl:WORD, ControlId:WORD, KeyAscii:WORD

;
; Place your comments and code for this event here.
; Basic errors are triggered by returning a non-zero value (ERR).
; Set and get properties and invoke methods and user events and 
; by using the appropriate callbacks declared above.
; PropertyID, EventID, and MethodID constant definitions are
; are contained in the CUSTINCL include file.
;

; IMPORTANT: You must always have a return value.
    XOR ax,ax                      ; Return no errors
    RET

MyControl_CKeyPress ENDP

PUBLIC   MyControl_CIntegerGet
MyControl_CIntegerGet PROC, Ctrl:WORD, ControlId:WORD, PropertyID:WORD, Value:WORD

;
; Place your comments and code for this event here.
; Basic errors are triggered by returning a non-zero value (ERR).
; Set and get properties and invoke methods and user events and 
; by using the appropriate callbacks declared above.
; PropertyID, EventID, and MethodID constant definitions are
; are contained in the CUSTINCL include file.
;

; IMPORTANT: You must always have a return value.
    XOR ax,ax                      ; Return no errors
    RET

MyControl_CIntegerGet ENDP

END
