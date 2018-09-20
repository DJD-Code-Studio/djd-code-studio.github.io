// ----------------------------------------------------------------------------
// CUSTINCL.H: Custom Control Include File
//
// Custom control include file containing constant
// definitions for Property, Event, Method and ControlType
// ID numbers used for identification purposes in custom
// control event handlers.
//
//
// Copyright (C) 1982-1992 Microsoft Corporation
//
// You have a royalty-free right to use, modify, reproduce
// and distribute the sample applications and toolkits provided with
// Visual Basic for MS-DOS (and/or any modified version)
// in any way you find useful, provided that you agree that
// Microsoft has no warranty, obligations or liability for
// any of the sample applications or toolkits.
// ----------------------------------------------------------------------------

// Attribute IDs  (see custom control section of README.TXT for more
//                 information about setting custom control attributes)
//
#define ATTR_AccessKey 0
#define ATTR_AcceptFocus 1
#define ATTR_TrapArrowKeys 2
#define ATTR_TextCursor 3

// Text Cursor Attribute Values
//
#define TC_NoCursor 0           // No text cursor.
#define TC_Underscore 1         // Blinking underscore cursor.
#define TC_Block 2              // Blinking block cursor.

// Property IDs
//
#define PROP_Archive 1
#define PROP_Attached 2
#define PROP_AutoRedraw 3
#define PROP_AutoSize 4
#define PROP_Cancel 5
#define PROP_Checked 6
#define PROP_ControlBox 7
#define PROP_Default 8
#define PROP_Enabled 9
#define PROP_Hidden 10
#define PROP_MaxButton 11
#define PROP_MinButton 12
#define PROP_MultiLine 13
#define PROP_Normal 14
#define PROP_ReadOnly 15
#define PROP_Separator 16
#define PROP_Sorted 17
#define PROP_System 18
#define PROP_TabStop 19
#define PROP_Visible 20
#define PROP_Alignment 21
#define PROP_BackColor 22
#define PROP_BorderStyle 23
#define PROP_CurrentX 24
#define PROP_CurrentY 25
#define PROP_DragMode 26
#define PROP_ForeColor 27
#define PROP_Height 28
#define PROP_Left 29
#define PROP_MousePointer 30
#define PROP_ScaleHeight 31
#define PROP_ScaleWidth 32
#define PROP_ScrollBars 33
#define PROP_Style 34
#define PROP_TabIndex 35
#define PROP_Top 36
#define PROP_Width 37
#define PROP_WindowState 38
#define PROP_Index 39
#define PROP_LargeChange 40
#define PROP_ListCount 41
#define PROP_ListIndex 42
#define PROP_Max 43
#define PROP_Min 44
#define PROP_SelLength 46
#define PROP_SelStart 47
#define PROP_SmallChange 48
#define PROP_TypeOf 49
#define PROP_Value 50
#define PROP_Action 54
#define PROP_Column 55
#define PROP_ControlID 56
#define PROP_Mode 57
#define PROP_Row 58
#define PROP_Interval 59
#define PROP_Caption 60
#define PROP_Drive 61
#define PROP_Filename 62
#define PROP_List 63
#define PROP_Path 64
#define PROP_Pattern 65
#define PROP_SelText 66
#define PROP_Tag 67
#define PROP_Text 68
#define PROP_TypeID 69

// Method IDs
//
#define METHOD_AddItem 0
#define METHOD_Cls 1
#define METHOD_Hide 2
#define METHOD_Move 3
#define METHOD_Print 4
#define METHOD_PrintForm 5
#define METHOD_Refresh 6
#define METHOD_RemoveItem 7
#define METHOD_SetFocus 8
#define METHOD_Show 9
#define METHOD_Drag 12

// TypeOf property IDs
//
#define TYPEOF_Form 0
#define TYPEOF_CheckBox 1
#define TYPEOF_ComboBox 2
#define TYPEOF_CommandButton 3
#define TYPEOF_DirListBox 4
#define TYPEOF_DriveListBox 5
#define TYPEOF_FileListBox 6
#define TYPEOF_Frame 7
#define TYPEOF_HScrollBar 8
#define TYPEOF_Label 9
#define TYPEOF_ListBox 10
#define TYPEOF_Menu 11
#define TYPEOF_OptionButton 12
#define TYPEOF_PictureBox 13
#define TYPEOF_TextBox 14
#define TYPEOF_Timer 15
#define TYPEOF_VScrollBar 16
#define TYPEOF_Extensible 17

// User events IDs
//
#define EVENT_Change 1
#define EVENT_Click 2
#define EVENT_Custom 3
#define EVENT_DblClick 4
#define EVENT_DragDrop 5
#define EVENT_DragOver 6
#define EVENT_DropDown 7
#define EVENT_GotFocus 8
#define EVENT_KeyDown 9
#define EVENT_KeyPress 10
#define EVENT_KeyUp 11
#define EVENT_Load 12
#define EVENT_LostFocus 13
#define EVENT_MouseDown 14
#define EVENT_MouseMove 15
#define EVENT_MouseUp 16
#define EVENT_Paint 17
#define EVENT_PathChange 18
#define EVENT_PatternChange 19
#define EVENT_Resize 20
#define EVENT_Timer 21
#define EVENT_Unload 22

// Special custom control event IDs
//
#define EVENT_CustomLoad 23
#define EVENT_IntegerGet 24
#define EVENT_IntegerSet 25
#define EVENT_LongGet 26
#define EVENT_LongSet 27
#define EVENT_StringGet 28
#define EVENT_StringSet 29
#define EVENT_CustomUnload 30
#define EVENT_MethodAddItem 31
#define EVENT_MethodCls 32
#define EVENT_MethodHide 33
#define EVENT_MethodMove 34
#define EVENT_MethodPrint 35
#define EVENT_MethodRefresh 37
#define EVENT_MethodRemoveItem 38
#define EVENT_MethodSetFocus 39
#define EVENT_MethodShow 40
#define EVENT_MethodDrag 43
