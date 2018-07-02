' ----------------------------------------------------------------------------
' CUSTINCL.BI: Custom Control Include File
'
' Custom control include file containing constant
' definitions for Property, Event, Method and ControlType
' ID numbers used for identification purposes in custom
' control event handlers.
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

' Attribute IDs  (see custom control section of README.TXT for more
'                 information about setting custom control attributes)
'
CONST ATTR_AccessKey = 0
CONST ATTR_AcceptFocus = 1
CONST ATTR_TrapArrowKeys = 2
CONST ATTR_TextCursor = 3

' Text Cursor Attribute Values
'
CONST TC_NoCursor = 0           ' No text cursor.
CONST TC_Underscore = 1         ' Blinking underscore cursor.
CONST TC_Block = 2              ' Blinking block cursor.

' Property IDs
'
CONST PROP_Archive = 1
CONST PROP_Attached = 2
CONST PROP_AutoRedraw = 3
CONST PROP_AutoSize = 4
CONST PROP_Cancel = 5
CONST PROP_Checked = 6
CONST PROP_ControlBox = 7
CONST PROP_Default = 8
CONST PROP_Enabled = 9
CONST PROP_Hidden = 10
CONST PROP_MaxButton = 11
CONST PROP_MinButton = 12
CONST PROP_MultiLine = 13
CONST PROP_Normal = 14
CONST PROP_ReadOnly = 15
CONST PROP_Separator = 16
CONST PROP_Sorted = 17
CONST PROP_System = 18
CONST PROP_TabStop = 19
CONST PROP_Visible = 20
CONST PROP_Alignment = 21
CONST PROP_BackColor = 22
CONST PROP_BorderStyle = 23
CONST PROP_CurrentX = 24
CONST PROP_CurrentY = 25
CONST PROP_DragMode = 26
CONST PROP_ForeColor = 27
CONST PROP_Height = 28
CONST PROP_Left = 29
CONST PROP_MousePointer = 30
CONST PROP_ScaleHeight = 31
CONST PROP_ScaleWidth = 32
CONST PROP_ScrollBars = 33
CONST PROP_Style = 34
CONST PROP_TabIndex = 35
CONST PROP_Top = 36
CONST PROP_Width = 37
CONST PROP_WindowState = 38
CONST PROP_Index = 39
CONST PROP_LargeChange = 40
CONST PROP_ListCount = 41
CONST PROP_ListIndex = 42
CONST PROP_Max = 43
CONST PROP_Min = 44
CONST PROP_SelLength = 46
CONST PROP_SelStart = 47
CONST PROP_SmallChange = 48
CONST PROP_TypeOf = 49
CONST PROP_Value = 50
CONST PROP_Action = 54
CONST PROP_Column = 55
CONST PROP_ControlID = 56
CONST PROP_Mode = 57
CONST PROP_Row = 58
CONST PROP_Interval = 59
CONST PROP_Caption = 60
CONST PROP_Drive = 61
CONST PROP_Filename = 62
CONST PROP_List = 63
CONST PROP_Path = 64
CONST PROP_Pattern = 65
CONST PROP_SelText = 66
CONST PROP_Tag = 67
CONST PROP_Text = 68
CONST PROP_TypeID = 69

' Method IDs
'
CONST METHOD_AddItem = 0
CONST METHOD_Cls = 1
CONST METHOD_Hide = 2
CONST METHOD_Move = 3
CONST METHOD_Print = 4
CONST METHOD_PrintForm = 5
CONST METHOD_Refresh = 6
CONST METHOD_RemoveItem = 7
CONST METHOD_SetFocus = 8
CONST METHOD_Show = 9
CONST METHOD_Drag = 12

' TypeOf property IDs
'
CONST TYPEOF_Form = 0
CONST TYPEOF_CheckBox = 1
CONST TYPEOF_ComboBox = 2
CONST TYPEOF_CommandButton = 3
CONST TYPEOF_DirListBox = 4
CONST TYPEOF_DriveListBox = 5
CONST TYPEOF_FileListBox = 6
CONST TYPEOF_Frame = 7
CONST TYPEOF_HScrollBar = 8
CONST TYPEOF_Label = 9
CONST TYPEOF_ListBox = 10
CONST TYPEOF_Menu = 11
CONST TYPEOF_OptionButton = 12
CONST TYPEOF_PictureBox = 13
CONST TYPEOF_TextBox = 14
CONST TYPEOF_Timer = 15
CONST TYPEOF_VScrollBar = 16
CONST TYPEOF_Extensible = 17

' User events IDs
'
CONST EVENT_Change = 1
CONST EVENT_Click = 2
CONST EVENT_Custom = 3
CONST EVENT_DblClick = 4
CONST EVENT_DragDrop = 5
CONST EVENT_DragOver = 6
CONST EVENT_DropDown = 7
CONST EVENT_GotFocus = 8
CONST EVENT_KeyDown = 9
CONST EVENT_KeyPress = 10
CONST EVENT_KeyUp = 11
CONST EVENT_Load = 12
CONST EVENT_LostFocus = 13
CONST EVENT_MouseDown = 14
CONST EVENT_MouseMove = 15
CONST EVENT_MouseUp = 16
CONST EVENT_Paint = 17
CONST EVENT_PathChange = 18
CONST EVENT_PatternChange = 19
CONST EVENT_Resize = 20
CONST EVENT_Timer = 21
CONST EVENT_Unload = 22

' Special custom control event IDs
'
CONST EVENT_CustomLoad = 23
CONST EVENT_IntegerGet = 24
CONST EVENT_IntegerSet = 25
CONST EVENT_LongGet = 26
CONST EVENT_LongSet = 27
CONST EVENT_StringGet = 28
CONST EVENT_StringSet = 29
CONST EVENT_CustomUnload = 30
CONST EVENT_MethodAddItem = 31
CONST EVENT_MethodCls = 32
CONST EVENT_MethodHide = 33
CONST EVENT_MethodMove = 34
CONST EVENT_MethodPrint = 35
CONST EVENT_MethodRefresh = 37
CONST EVENT_MethodRemoveItem = 38
CONST EVENT_MethodSetFocus = 39
CONST EVENT_MethodShow = 40
CONST EVENT_MethodDrag = 43
