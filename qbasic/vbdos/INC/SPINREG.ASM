; ----------------------------------------------------------------------------
; SPINREG.ASM: Spin Custom Control Initialization and
; and IsHandler routines.
;
; Initializer segment and IsHandler routine created by
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
;    ML -c spinreg.asm          ; Assumes Masm 6.0 compiler
;    BC /x/o/d spin.bas;        ; Use appropriate compiler for template source code
;    DEL spin.lib               ; Delete existing library if exists
;    LIB spin.lib+spinreg.obj+spin.obj
;    LINK /Q spin.lib,spin.qlb,,VBDOSQLB.LIB;
; You can combine the spin custom control with other custom controls
; into one Quick library for use within the programming environment 
; as follows:
;    DEL <CombinedLib.LIB>         ; Delete existing library if exists
;    LIB <CombinedLib.LIB>+spin.lib+<Cust2.LIB>+<CustN.LIB>
;    LINK /Q <CombinedLib.LIB>,<CombinedLib.QLB>,,VBDOSQLB.LIB;
; To create an Alternate Math custom control library (instead of an
; Emulator Math custom control library as shown above), compile the 
; TemplateFile with the /FPa switch.  Note, an Altmath library cannot be
; used to create a Quick Library.
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


; Memory model and include files.

.MODEL    medium, basic
INCLUDE   CUSTINCL.INC

; Far externs for the custom control event handlers.
EXTRN   Spin_CClick:FAR
EXTRN   Spin_CDblClick:FAR
EXTRN   Spin_CGotFocus:FAR
EXTRN   Spin_CKeyDown:FAR
EXTRN   Spin_CKeyPress:FAR
EXTRN   Spin_CKeyUp:FAR
EXTRN   Spin_CLostFocus:FAR
EXTRN   Spin_CMouseDown:FAR
EXTRN   Spin_CMouseMove:FAR
EXTRN   Spin_CMouseUp:FAR
EXTRN   Spin_CPaint:FAR
EXTRN   Spin_CTimer:FAR
EXTRN   Spin_CLoad:FAR
EXTRN   Spin_CIntegerGet:FAR
EXTRN   Spin_CIntegerSet:FAR
EXTRN   Spin_CStringGet:FAR
EXTRN   Spin_CStringSet:FAR
EXTRN   Spin_CMthAddItem:FAR
EXTRN   Spin_CMthCls:FAR
EXTRN   Spin_CMthHide:FAR
EXTRN   Spin_CMthMove:FAR
EXTRN   Spin_CMthPrint:FAR
EXTRN   Spin_CMthRemoveItem:FAR
EXTRN   Spin_CMthShow:FAR


   PUBLIC BCC$SPIN                      ; Public declaration to pull in necessary
   BCC$SPIN  EQU 5253H                  ; code when linking EXE file.  Must consist of
                           ; 'BCC$' plus TypeID string or custom control
                           ; code will not be linked into program.


; Custom control initializer segment
;
; Note, more than one custom control's initialization
; information can be contained in this segment.  Simply
; provide the required information in correct order for
; each custom control.

DGROUP GROUP XECIB, XECI, XECIE

XECIB  SEGMENT WORD PUBLIC 'DATA'  ; Start of the initializer segment
XECIB  ENDS

XECI   SEGMENT WORD PUBLIC 'DATA'
   DW OFFSET SpinType         ; Custom control TypeID string.
                           ; Must be alphanumeric beginning
                           ; with alphabetic character.
                           ; Near pointer to 0 terminated
                           ; string in data segment
   DW lenSpinType             ; Length of string (excluding
                           ; terminating zero, max = 25)
   DD SpinIsHandler           ; Far pointer to IsHandler
   DW 0                    ; Flags (0,1) determines if control
                           ; can be a container object.

   BeginEventMasks         ; Event masks
      MaskItem EVENT_Change
      MaskItem EVENT_Click
      MaskItem EVENT_DblClick
      MaskItem EVENT_DropDown
      MaskItem EVENT_KeyDown
      MaskItem EVENT_KeyPress
      MaskItem EVENT_KeyUp
      MaskItem EVENT_Load
      MaskItem EVENT_MouseDown
      MaskItem EVENT_MouseMove
      MaskItem EVENT_MouseUp
      MaskItem EVENT_Paint
      MaskItem EVENT_PathChange
      MaskItem EVENT_PatternChange
      MaskItem EVENT_Resize
      MaskItem EVENT_Timer
      MaskItem EVENT_Unload
   EndEventMasks
   BeginPropertyMasks      ; Property masks
      MaskItem PROP_Action
      MaskItem PROP_Alignment
      MaskItem PROP_Archive
      MaskItem PROP_AutoRedraw
      MaskItem PROP_BorderStyle
      MaskItem PROP_Caption
      MaskItem PROP_Checked
      MaskItem PROP_Column
      MaskItem PROP_Drive
      MaskItem PROP_Filename
      MaskItem PROP_Height
      MaskItem PROP_Hidden
      MaskItem PROP_LargeChange
      MaskItem PROP_ListCount
      MaskItem PROP_ListIndex
      MaskItem PROP_Mode
      MaskItem PROP_MultiLine
      MaskItem PROP_Normal
      MaskItem PROP_Path
      MaskItem PROP_Pattern
      MaskItem PROP_ReadOnly
      MaskItem PROP_Row
      MaskItem PROP_ScrollBars
      MaskItem PROP_SelLength
      MaskItem PROP_SelStart
      MaskItem PROP_SelText
      MaskItem PROP_SmallChange
      MaskItem PROP_Sorted
      MaskItem PROP_System
      MaskItem PROP_Text
      MaskItem PROP_Width
   EndPropertyMasks
XECI   ENDS

XECIE  SEGMENT WORD PUBLIC 'DATA'  ; End of the initializer segment.
XECIE  ENDS


.DATA

   SpinType DB    "Spin",0h        ; Custom control TypeID string.
                           ; Must be alphanumeric beginning
                           ; with alphabetic character.
   lenSpinType = $ - SpinType - 1  ; Length of string (excluding
                           ; terminating zero, max = 25)


.CODE   Spin_TEXT

   ; Custom control event handler address table.
   ; For use with a table driven IsHandler routine.  Table contains
   ; address of event handler routine for events that will be
   ; handled/intercepted by the custom control.  Table contains a
   ; Long 0 for events that will not be handled/intercepted by the
   ; custom control but passed directly to the user's code where
   ; applicable.

   SpinTable LABEL DWORD
        DD    0                                             ; Skipped table entry: DO NOT REMOVE
        DD    Spin_CClick                                   ;Click
        DD    0                                             ; Skipped table entry: DO NOT REMOVE
        DD    Spin_CDblClick                                ;DblClick
        DD    0                                             ;DragDrop
        DD    0                                             ;DragOver
        DD    0                                             ; Skipped table entry: DO NOT REMOVE
        DD    Spin_CGotFocus                                ;GotFocus
        DD    Spin_CKeyDown                                 ;KeyDown
        DD    Spin_CKeyPress                                ;KeyPress
        DD    Spin_CKeyUp                                   ;KeyUp
        DD    0                                             ; Skipped table entry: DO NOT REMOVE
        DD    Spin_CLostFocus                               ;LostFocus
        DD    Spin_CMouseDown                               ;MouseDown
        DD    Spin_CMouseMove                               ;MouseMove
        DD    Spin_CMouseUp                                 ;MouseUp
        DD    Spin_CPaint                                   ;Paint
        DD    0                                             ; Skipped table entry: DO NOT REMOVE
        DD    0                                             ; Skipped table entry: DO NOT REMOVE
        DD    0                                             ; Skipped table entry: DO NOT REMOVE
        DD    Spin_CTimer                                   ;Timer
        DD    0                                             ; Skipped table entry: DO NOT REMOVE
        DD    Spin_CLoad                                    ;Load
        DD    Spin_CIntegerGet                              ;IntegerGet
        DD    Spin_CIntegerSet                              ;IntegerSet
        DD    0                                             ;LongGet
        DD    0                                             ;LongSet
        DD    Spin_CStringGet                               ;StringGet
        DD    Spin_CStringSet                               ;StringSet
        DD    0                                             ;Unload
        DD    Spin_CMthAddItem                              ;MthAddItem
        DD    Spin_CMthCls                                  ;MthCls
        DD    Spin_CMthHide                                 ;MthHide
        DD    Spin_CMthMove                                 ;MthMove
        DD    Spin_CMthPrint                                ;MthPrint
        DD    0                                             ; Skipped table entry: DO NOT REMOVE
        DD    0                                             ;MthRefresh
        DD    Spin_CMthRemoveItem                           ;MthRemoveItem
        DD    0                                             ;MthSetFocus
        DD    Spin_CMthShow                                 ;MthShow
        DD    0                                             ; Skipped table entry: DO NOT REMOVE
        DD    0                                             ; Skipped table entry: DO NOT REMOVE
        DD    0                                             ;MthDrag

    lenSpinTable = ($ - SpinTable)/4    ; Number of entries in table


   ; ((VOID _far *)NULL) SpinIsHandler (EventId)
   ;
   ; IsHandler routine for the custom control.  This routine is 
   ; called by Visual Basic each time an event occurs for the custom control.
   ; The EventID for the event is passed to the IsHandler routine
   ; which returns the address of the custom control's event handler
   ; routine for that event.  If the custom control does not want to
   ; handle/intercept the event, IsHandler returns a Long 0 and the event
   ; is passed to the user's code if applicable.
   ; 
   ; This IsHandler routine uses a table driven approach for returning
   ; event handler address or 0 (table is defined above).
   ; Different methods can be used to return this information however.

    PUBLIC   SpinIsHandler
   SpinIsHandler PROC , EventId:WORD

      MOV    bx, EventId                ;[bx] = event Id
      CMP    bx, lenSpinTable   ; Is value in range?
      JAE    OutOfRange                ;Break and return 0:0
      ADD    bx, bx
      ADD    bx, bx                    ;[bx] = dword index
      LES    ax, SpinTable[bx-4]   ;[es:ax] = address of handler
      MOV    dx, es                    ;[dx:ax] = address of handler / 0
      RET

OutOfRange:
      XOR    ax, ax
      CWD
      RET

   SpinIsHandler ENDP

END

