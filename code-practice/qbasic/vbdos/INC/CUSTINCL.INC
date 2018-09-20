; ----------------------------------------------------------------------------
; CUSTINCL.ASM: Custom Control Include File
;
; Custom control include file containing constant
; definitions for Property, Event, Method and ControlType
; ID numbers used for identification purposes in custom
; control event handlers.
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

; Macro definitions for Event and Property masking 
;

BeginEventMasks MACRO
MASKS1 = 00000h
MASKS2 = 00000h
ENDM

EndEventMasks   MACRO
dw      MASKS1
dw      MASKS2
ENDM

BeginPropertyMasks MACRO
MASKS1 = 00000h
MASKS2 = 00000h
MASKS3 = 00000h
MASKS4 = 00000h
MASKS5 = 00000h
ENDM

EndPropertyMasks MACRO
dw      MASKS1
dw      MASKS2
dw      MASKS3
dw      MASKS4
dw      MASKS5
ENDM

MaskItem MACRO item
if      item LT 16
MASKS1 = MASKS1 OR (1 SHL item)
elseif  item LT 32
MASKS2 = MASKS2 OR (1 SHL (item-16))
elseif  item LT 48
MASKS3 = MASKS3 OR (1 SHL (item-32))
elseif  item LT 64
MASKS4 = MASKS4 OR (1 SHL (item-48))
elseif  item LT 80
MASKS5 = MASKS5 OR (1 SHL (item-64))
else
.err
endif
ENDM


; Attribute IDs  (see custom control section of README.TXT for more
;                 information about setting custom control attributes)
;
ATTR_AccessKey EQU 0
ATTR_AcceptFocus EQU 1
ATTR_TrapArrowKeys EQU 2
ATTR_TextCursor EQU 3

; Text Cursor Attribute Values
;
TC_NoCursor EQU 0           ; No text cursor.
TC_Underscore EQU 1         ; Blinking underscore cursor.
TC_Block EQU 2              ; Blinking block cursor.

; Property IDs
;
PROP_Archive EQU 1
PROP_Attached EQU 2
PROP_AutoRedraw EQU 3
PROP_AutoSize EQU 4
PROP_Cancel EQU 5
PROP_Checked EQU 6
PROP_ControlBox EQU 7
PROP_Default EQU 8
PROP_Enabled EQU 9
PROP_Hidden EQU 10
PROP_MaxButton EQU 11
PROP_MinButton EQU 12
PROP_MultiLine EQU 13
PROP_Normal EQU 14
PROP_ReadOnly EQU 15
PROP_Separator EQU 16
PROP_Sorted EQU 17
PROP_System EQU 18
PROP_TabStop EQU 19
PROP_Visible EQU 20
PROP_Alignment EQU 21
PROP_BackColor EQU 22
PROP_BorderStyle EQU 23
PROP_CurrentX EQU 24
PROP_CurrentY EQU 25
PROP_DragMode EQU 26
PROP_ForeColor EQU 27
PROP_Height EQU 28
PROP_Left EQU 29
PROP_MousePointer EQU 30
PROP_ScaleHeight EQU 31
PROP_ScaleWidth EQU 32
PROP_ScrollBars EQU 33
PROP_Style EQU 34
PROP_TabIndex EQU 35
PROP_Top EQU 36
PROP_Width EQU 37
PROP_WindowState EQU 38
PROP_Index EQU 39
PROP_LargeChange EQU 40
PROP_ListCount EQU 41
PROP_ListIndex EQU 42
PROP_Max EQU 43
PROP_Min EQU 44
PROP_SelLength EQU 46
PROP_SelStart EQU 47
PROP_SmallChange EQU 48
PROP_TypeOf EQU 49
PROP_Value EQU 50
PROP_Action EQU 54
PROP_Column EQU 55
PROP_ControlID EQU 56
PROP_Mode EQU 57
PROP_Row EQU 58
PROP_Interval EQU 59
PROP_Caption EQU 60
PROP_Drive EQU 61
PROP_Filename EQU 62
PROP_List EQU 63
PROP_Path EQU 64
PROP_Pattern EQU 65
PROP_SelText EQU 66
PROP_Tag EQU 67
PROP_Text EQU 68
PROP_TypeID EQU 69
	 
; Method IDs
;
METHOD_AddItem EQU 0
METHOD_Cls EQU 1
METHOD_Hide EQU 2
METHOD_Move EQU 3
METHOD_Print EQU 4
METHOD_PrintForm EQU 5
METHOD_Refresh EQU 6
METHOD_RemoveItem EQU 7
METHOD_SetFocus EQU 8
METHOD_Show EQU 9
METHOD_Drag EQU 12

; TypeOf property IDs
;
TYPEOF_Form EQU 0
TYPEOF_CheckBox EQU 1
TYPEOF_ComboBox EQU 2
TYPEOF_CommandButton EQU 3
TYPEOF_DirListBox EQU 4
TYPEOF_DriveListBox EQU 5
TYPEOF_FileListBox EQU 6
TYPEOF_Frame EQU 7
TYPEOF_HScrollBar EQU 8
TYPEOF_Label EQU 9
TYPEOF_ListBox EQU 10
TYPEOF_Menu EQU 11
TYPEOF_OptionButton EQU 12
TYPEOF_PictureBox EQU 13
TYPEOF_TextBox EQU 14
TYPEOF_Timer EQU 15
TYPEOF_VScrollBar EQU 16
TYPEOF_Custom EQU 17

; User events IDs
;
EVENT_Change EQU 1
EVENT_Click EQU 2
EVENT_Custom EQU 3
EVENT_DblClick EQU 4
EVENT_DragDrop EQU 5
EVENT_DragOver EQU 6
EVENT_DropDown EQU 7
EVENT_GotFocus EQU 8
EVENT_KeyDown EQU 9
EVENT_KeyPress EQU 10
EVENT_KeyUp EQU 11
EVENT_Load EQU 12
EVENT_LostFocus EQU 13
EVENT_MouseDown EQU 14
EVENT_MouseMove EQU 15
EVENT_MouseUp EQU 16
EVENT_Paint EQU 17
EVENT_PathChange EQU 18
EVENT_PatternChange EQU 19
EVENT_Resize EQU 20
EVENT_Timer EQU 21
EVENT_Unload EQU 22

; Special custom control event IDs
;
EVENT_CustomLoad EQU 23
EVENT_IntegerGet EQU 24
EVENT_IntegerSet EQU 25
EVENT_LongGet EQU 26
EVENT_LongSet EQU 27
EVENT_StringGet EQU 28
EVENT_StringSet EQU 29
EVENT_CustomUnload EQU 30
EVENT_MethodAddItem EQU 31
EVENT_MethodCls EQU 32
EVENT_MethodHide EQU 33
EVENT_MethodMove EQU 34
EVENT_MethodPrint EQU 35
EVENT_MethodRefresh EQU 37
EVENT_MethodRemoveItem EQU 38
EVENT_MethodSetFocus EQU 39
EVENT_MethodShow EQU 40
EVENT_MethodDrag EQU 43



