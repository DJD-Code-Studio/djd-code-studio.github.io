' ------------------------------------------------------------------------
' Visual Basic for MS-DOS Constant Include File
'
' Include file that contains constant definitions
' for enumerated form or control property values and
' event procedure, method, and function parameter values.
' 
' This file can be included and used as is in your applications.
' Each constant definition reduces the amount of memory available
' for your application, however, so for best results, include only 
' those constant definitions you plan to use in your application.
' In addition, some of the constant definitions below may conflict with
' variable definitions in your existing programs. 
' 
' Some constants below are commented out because they
' have duplicates (for example, NONE appears in several
' places).
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


' -------
' General
' -------

' Booleans
CONST TRUE = -1
CONST FALSE = 0

' ----------------
' Event parameters
' ----------------

' Button and Shift (KeyDown, KeyUp, MouseDown, MouseMove, MouseUp)
CONST SHIFT_MASK = 1
CONST CTRL_MASK = 2
CONST ALT_MASK = 4
CONST LEFT_BUTTON = 1
CONST RIGHT_BUTTON = 2

' KeyCode (KeyDown, KeyUp)
CONST KEY_BACK = 8
CONST KEY_TAB = 9
CONST KEY_CLEAR = 12
CONST KEY_RETURN = 13           ' Enter key
CONST KEY_SHIFT = 16
CONST KEY_CONTROL = 17
CONST KEY_MENU = 18             ' Alt key
CONST KEY_PAUSE = 19
CONST KEY_CAPITAL = 20          ' Caps lock key
CONST KEY_ESCAPE = 27
CONST KEY_SPACE = 32
CONST KEY_PRIOR = 33            ' Page up key
CONST KEY_NEXT = 34             ' Page down key
CONST KEY_END = 35
CONST KEY_HOME = 36
CONST KEY_LEFT = 37
CONST KEY_UP = 38
CONST KEY_RIGHT = 39
CONST KEY_DOWN = 40
CONST KEY_SELECT = 41
CONST KEY_PRINT = 42
CONST KEY_EXECUTE = 43
CONST KEY_SNAPSHOT = 44
CONST KEY_INSERT = 45
CONST KEY_DELETE = 127          ' Delete key returns 46 in Visual Basic for Windows.
CONST KEY_HELP = 47

' KeyCode parameter in KeyDown and KeyUp event procedures
' returns the same value as KeyAscii in the KeyPress event 
' procedure for keys corresponding to ASCII printable 
' characters (A-Z, a-z, 0-9, ~,[,],{,},+,=, etc).  Return 
' values will be the ASCII value of the character (see 
' ASCII Character Codes topic in Help).  Extended ASCII
' characters can be returned via KeyCode and KeyAscii
' by holding down the ALT key, entering the ASCII number
' of the extended ASCII character, then releasing the
' ALT key.  Note, the NumLock key must be on if the numeric
' keypad is used.

CONST KEY_NUMPAD0 = 48
CONST KEY_NUMPAD1 = 49
CONST KEY_NUMPAD2 = 50
CONST KEY_NUMPAD3 = 51
CONST KEY_NUMPAD4 = 52
CONST KEY_NUMPAD5 = 53
CONST KEY_NUMPAD6 = 54
CONST KEY_NUMPAD7 = 55
CONST KEY_NUMPAD8 = 56
CONST KEY_NUMPAD9 = 57
CONST KEY_MULTIPLY = 42
CONST KEY_ADD = 43
CONST KEY_SUBTRACT = 45
CONST KEY_DECIMAL = 46
CONST KEY_DIVIDE = 47
CONST KEY_F1 = 112
CONST KEY_F2 = 113
CONST KEY_F3 = 114
CONST KEY_F4 = 115
CONST KEY_F5 = 116
CONST KEY_F6 = 117
CONST KEY_F7 = 118
CONST KEY_F8 = 119
CONST KEY_F9 = 120
CONST KEY_F10 = 121
CONST KEY_F11 = 122
CONST KEY_F12 = 123
CONST KEY_NUMLOCK = 144
CONST KEY_SCRLOCK = 145

' State (DragOver)
CONST ENTER = 0
CONST LEAVE = 1
CONST OVER = 2

' -------------------
' Function parameters
' -------------------

' MSGBOX parameters
CONST MB_OK = 0                         ' OK button only
CONST MB_OKCANCEL = 1                   ' OK and Cancel buttons
CONST MB_ABORTRETRYIGNORE = 2           ' Abort, Retry, and Ignore buttons
CONST MB_YESNOCANCEL = 3                ' Yes, No, and Cancel buttons
CONST MB_YESNO = 4                      ' Yes and No buttons
CONST MB_RETRYCANCEL = 5                ' Retry and Cancel buttons

CONST MB_DEFBUTTON1 = 0                 ' First button is default
CONST MB_DEFBUTTON2 = 256               ' Second button is default
CONST MB_DEFBUTTON3 = 512               ' Third button is default

' MSGBOX return values
CONST IDOK = 1                          ' OK button pressed
CONST IDCANCEL = 2                      ' Cancel button pressed
CONST IDABORT = 3                       ' Abort button pressed
CONST IDRETRY = 4                       ' Retry button pressed
CONST IDIGNORE = 5                      ' Ignore button pressed
CONST IDYES = 6                         ' Yes button pressed
CONST IDNO = 7                          ' No button pressed


' -----------------
' Method parameters
' -----------------

' DRAG (controls)
CONST CANCEL_DRAG = 0
CONST BEGIN_DRAG = 1
CONST END_DRAG = 2

' SHOW (form)
CONST MODELESS = 0
CONST MODAL = 1

' ---------------
' Property values
' ---------------

' Alignment (label)
CONST LEFT_JUSTIFY = 0                  ' 0 - Left Justify
CONST RIGHT_JUSTIFY = 1                 ' 1 - Right Justify
CONST CENTER = 2                        ' 2 - Center

' BackColor, ForeColor (form, controls)
CONST BLACK = 0
CONST BLUE = 1
CONST GREEN = 2
CONST CYAN = 3
CONST RED = 4
CONST MAGENTA = 5
CONST BROWN = 6
CONST WHITE = 7
CONST GRAY = 8
CONST BRIGHT_BLUE = 9
CONST BRIGHT_GREEN = 10
CONST BRIGHT_CYAN = 11
CONST BRIGHT_RED = 12
CONST PINK = 13
CONST YELLOW = 14
CONST BRIGHT_WHITE = 15

' BorderStyle (form)
CONST NONE = 0                          ' 0 - None
CONST FIXED_SINGLE = 1                  ' 1 - Fixed Single
CONST SIZABLE_SINGLE = 2                ' 2 - Sizable Single
CONST FIXED_DOUBLE = 3                  ' 3 - Fixed Double
CONST SIZABLE_DOUBLE = 4                ' 4 - Sizable Double
CONST FIXED_SOLID = 5                   ' 5 - Fixed Solid
CONST SIZABLE_SOLID = 6                 ' 6 - Sizable Solid

' BorderStyle (label, picture box, text box)
' CONST NONE = 0                        ' 0 - None
CONST SINGLE_LINE = 1                   ' 1 - Single Line
CONST DOUBLE_LINE = 2                   ' 2 - Double Line (label and picture box only)

' DragMode (controls)
CONST MANUAL = 0                        ' 0 - Manual
CONST AUTOMATIC = 1                     ' 1 - Automatic

' FormType (form - Multiple Document Interface (MDI) vs Single Document Interface (SDI) applications)
CONST NORMAL = 0                        ' 0 - Normal (Normal form in SDI applications, 
                                        '     child form in MDI applications)
CONST MDI = 1                           ' 1 - MDI (Container form in MDI application)

' MousePointer (form, controls)
CONST DEFAULT = 0                       ' 0 - Default (Same MousePointer as container object's MousePointer)
CONST BLOCK = 1                         ' 1 - Block (ASCII 219)
CONST CROSSHAIR = 2                     ' 2 - Cross (ASCII 197)
CONST IBEAM = 3                         ' 3 - I-Beam (ASCII 73)
CONST ICON = 4                          ' 4 - Icon (ASCII 002)
CONST SIZE_POINTER = 5                  ' 5 - Size (ASCII 015)
CONST LEFT_ARROW = 6                    ' 6 - Left Arrow (ASCII 027)
CONST SIZE_N_S = 7                      ' 7 - Size North South (ASCII 018)
CONST RIGHT_ARROW = 8                   ' 8 - Right Arrow (ASCII 026)
CONST SIZE_W_E = 9                      ' 9 - Size West East (ASCII 029)
CONST UP_ARROW = 10                     ' 10 - Up Arrow (ASCII 024)
CONST HOURGLASS = 11                    ' 11 - Hourglass (ASCII 088)
CONST DOWN_ARROW = 12                   ' 12 - Down Arrow (ASCII 025)

' ScrollBar (text box)
' CONST NONE = 0                        ' 0 - None
CONST HORIZONTAL = 1                    ' 1 - Horizontal
CONST VERTICAL = 2                      ' 2 - Vertical
CONST BOTH = 3                          ' 3 - Both

' Value (check box)
CONST UNCHECKED = 0                     ' 0 - Unchecked
CONST CHECKED = 1                       ' 1 - Checked
CONST GRAYED = 2                        ' 2 - Grayed

' WindowState (form)
' CONST NORMAL = 0                        ' 0 - Normal
CONST MINIMIZED = 1                     ' 1 - Minimized
CONST MAXIMIZED = 2                     ' 2 - Maximized

' SCREEN.ControlPanel array elements
CONST ACCESSKEY_FORECOLOR = 0           ' Access key foreground color (0-15).
CONST ACTIVE_BORDER_BACKCOLOR = 1       ' Active border background color (0-15).
CONST ACTIVE_BORDER_FORECOLOR = 2       ' Active border foreground color (0-15).
CONST ACTIVE_WINDOW_SHADOW = 3          ' Active window shadow effect (Boolean).
CONST COMBUTTON_FORECOLOR = 4           ' Command button foreground color (0-15).
CONST DESKTOP_BACKCOLOR = 5             ' Desktop background color (0-15).
CONST DESKTOP_FORECOLOR = 6             ' Desktop foreground color (0-15).
CONST DESKTOP_PATTERN = 7               ' Desktop fill pattern (ASCII 0-255).
CONST DISABLED_ITEM_FORECOLOR = 8       ' Disabled menu/dialog item foreground color (0-15).
CONST MENU_BACKCOLOR = 9                ' Menu background color (0-15).
CONST MENU_FORECOLOR = 10               ' Menu foreground color (0-15).
CONST MENU_SELECTED_BACKCOLOR = 11      ' Menu selected item background color (0-15).
CONST MENU_SELECTED_FORECOLOR = 12      ' Menu selected item foreground color (0-15).
CONST SCROLLBAR_BACKCOLOR = 13          ' Scrollbar background color (0-15).
CONST SCROLLBAR_FORECOLOR = 14          ' Scrollbar foreground color (0-15).
CONST THREE_D = 15                      ' 3-D effect for controls with borders (Boolean).
CONST TITLEBAR_BACKCOLOR = 16           ' Titlebar background color (0-15).
CONST TITLEBAR_FORECOLOR = 17           ' Titlebar foreground color (0-15).

