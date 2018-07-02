                                  README.TXT

        Release Notes for Microsoft (R) Visual Basic (TM) for MS-DOS (R)

                       Professional Edition Version 1.00

                 (C) Copyright Microsoft Corporation, 1982-1992

This document contains release notes for version 1.00 of Microsoft Visual
Basic for MS-DOS. Information in this document is more current than that 
in the manuals. Information in online Help may also be more current than 
that in the manuals.

Microsoft revises its printed documentation at the time of reprinting, so
manuals with document numbers ending in numbers higher than "0992" may
include the corrections listed in parts 2-4. Document numbers are found on
the copyright page of each manual.

===========================================================================
Contents
===========================================================================

Part    Description
----    -----------

1       Notes on Using Microsoft Visual Basic

2       Corrections to "Microsoft Visual Basic Programmer's Guide"

3       Corrections to "Microsoft Visual Basic Reference"

4       Corrections to Online Help

5       Corrections to "Microsoft Visual Basic Professional Edition"


===========================================================================
Part 1: Notes on Using Microsoft Visual Basic
===========================================================================

This part contains the following sections:

    1.1  Tips and Tricks
    1.2  Forms
    1.3  Language
    1.4  LINK
    1.5  Hardware Considerations 
    1.6  TRNSLATE.EXE
    1.7  Custom Controls
    1.8  CodeView
    1.9  Overlays
    1.10 ISAM
    1.11 BUILDRTM
    1.12 PROFILE


-------------------
1.1 Tips and Tricks
-------------------

Programming Environment Speed vs. Capacity
------------------------------------------
The programming environment (VBDOS.EXE) has been overlayed to increase 
capacity. The default in-memory size of VBDOS.EXE is tuned to provide a 
good speed/capacity tradeoff. If the environment seems slow to you, you 
can increase speed by using the /S:n command-line switch. This switch 
specifies the in-memory size of VBDOS.EXE. The default is approximately 
350K. To increase performance, specify a value greater than the default.
To increase capacity, specify a value less than the default. For more 
information, refer to Appendix B, "Memory Management" in the 
"Programmer's Guide."

Memory Configuration Suggestions
--------------------------------
For systems running MS-DOS 5.00 and later, load MS-DOS and TSRs high to 
free as much conventional memory as possible. Optimal configurations for 
conventional, Extended memory (XMS), and Expanded memory (EMS) vary 
depending on the type and amount of memory available on your system.
The following recommendations cover 1 MB, 2 MB, and =>3 MB configurations.

1 MB memory: If you have no XMS or EMS, the programming environment swaps
to disk and all code is stored in conventional memory. To increase 
performance, set the /S:n command-line option to a value greater than 350 
(default). This will reduce overlay swapping. To increase capacity, set the 
/S:n command-line option to a value less than 350. This reduces the 
in-memory size of the programming environment, providing more far memory 
for your program; overlay swapping increases however.

2 MB memory: If you have XMS, use a memory manager such as EMM386 to
configure all available memory above 1 MB as EMS. EMS can be used by the
programming environment for overlay swapping as well as for program code 
and data storage. If you do not have a memory manager that can configure 
XMS memory as EMS memory, or if you do not need EMS for code and data 
storage, use HIMEM.SYS to allow access to XMS memory for overlay swapping.  
HIMEM.SYS uses less conventional and XMS memory for itself than memory 
managers, such as EMM386.

3 MB or more memory: Configure 1.5 MB as XMS for programming environment
overlay swapping and divide the remaining memory between EMS and disk 
caching (such as SMARTDRV.SYS). EMS provides more memory for program code 
and data and disk caching provides faster file access.

Debugging Compiled .EXEs
------------------------
You must use the /D compiler switch to enable Out of Stack space, array
bounds, and overflow checking in the compiled code. In addition, /D 
enables CTRL+BREAK at run-time in compiled .EXEs. This error checking is
provided automatically in the programming environment.

Using VBDOS.EXE and Windows
---------------------------
Since VBDOS.EXE is opened for reading while it is being run (due to 
overlay support), you cannot automatically run VBDOS.EXE in two MS-DOS 
sessions with SHARE.EXE loaded. To allow running VBDOS in multiple sessions, 
make VBDOS.EXE read-only on your hard disk. 

Ending Execution While Debugging
--------------------------------
Pressing CTRL+BREAK while executing an application in the programming
environment returns you to the currently executing code -- if a form is
waiting for an event, you are returned to the code that invoked the form:
either the module level of the start-up form or a SHOW method.

Terminating the application normally (by closing the last form, for example)
returns you to your former location in code.

Inserting Special Characters
----------------------------
To insert a special character in the Code window or in the Settings box in
the Properties bar: 

1. Set NUMLOCK on. 
2. Press CTRL+P. 
3. Hold down the ALT key and type the ASCII code of the character using 
   the numeric keypad. 
4. Release the ALT key.

Note that this process may not work for some characters below ASCII 28. In
those cases, use the CHR$ statement to insert special characters in code.
For example:

x$ = CHR$(21) ' Section symbol.

To insert a special character in a form application at runtime (for example, 
when typing in a text box):

1. Set NUMLOCK on. 
2. Hold down the ALT key and type the ASCII code of the character using 
   the numeric keypad. 
3. Release the ALT key.

Printing
--------
PRINT method output (PRINT from a form module) always goes to the active 
form whether or not that form is visible. PRINT statement output (PRINT
from a code module) always goes to the screen unless qualified by a form 
reference (FORM1.PRINT. The PRINT statement cannot be used when forms are 
showing. To send output to the screen from a form-based application, you 
must first hide all visible forms (SCREEN.HIDE) and then use the PRINT 
statement from a code module.

PRINT from the Immediate window applies to the currently active module
if in a CTRL+BREAK state or to the Startup module if not in an
edit-and-continue state. Therefore, if a code module is active, PRINT from
the Immediate window is treated like the PRINT statement and the
rules outlined above apply (PRINT statement not allowed when forms
are showing). If the active module is a form module, PRINT from the
Immediate window is treated like the PRINT method and applies to
that form, whether or not it is visible. 

Code Cleanup
-------------
If you save your files in binary format, variable name table entries are
preserved even after you have deleted all instances of a variable name. 
To eliminate these entries, save your files as text (ASCII) and then resave 
as binary. This increases capacity within the programming environment 
and reduces the size of your source files.

Visual Basic does not automatically remove unused event procedure templates
that you create with the Edit Event Procedures dialog box. Make sure you 
delete all unused procedure templates before completing your project.

Form Redraw
-----------
The form painting and redraw algorithms in Visual Basic may not always 
refresh the screen at the time you expect. This is because they have 
been optimized to provide the best speed/redraw compromise. To repaint a
form or control at any time, use the object's REFRESH method. For instance,
PRINT output on a nonactive form may overwrite the shadow of the active 
form, since PRINT does not cause a form refresh. Use the REFRESH method on
the active form after the PRINT method to redraw the shadow.

Accessing Network Drives 
------------------------
Setting the Drive or Path properties to a network drive may hang your
application if the drive has disconnected.

Variable Names 
--------------
Avoid using scalar variable names of the form "A.B". This type of variable 
naming is not supported Visual Basic for Windows and increases load time 
due to the special parsing that is required. Use the "." notation only when 
referencing properties, methods, or elements of a record variable. 
Replace variables of the form "A.B" with variables of the form "A_B".

Avoid using variable names that are also the names of properties or 
ControlPanel constants. Doing so can make it difficult to debug an 
application. Because the Help system recognizes these names, symbol Help 
for these variables is inhibited.

To work around this problem, rename VBDOS.HLP then request help on
the variable. The programming environment displays an error dialog box. 
When you choose Cancel, the programming environment displays symbol Help 
for the variable.

Exiting When Out of Memory During Binding 
-----------------------------------------
If you run out of memory while binding in the programming environment, Visual
Basic displays a dialog box with the "Out of Memory" error message. In some 
cases, choosing OK only redisplays the dialog box. If this occurs, pressing 
the SPACEBAR instead of ENTER may break the loop.

Math Coprocessor Performance
----------------------------
Memory managers such as EMM386 and 386MAX will slow performance of
math operations using a coprocessor. For best results, do not have a 
memory manager resident when performing intensive math calculations using a 
coprocessor.

Distinguishing Between Apostrophe and Right Arrow Keys
------------------------------------------------------
The apostrophe (') and right arrow keys both return key codes of 39 in 
key event procedures. To distinguish between these keys in code, use a
combination of the KeyDown, KeyUp, and KeyPress events as shown below:

SUB Form_KeyDown (KeyCode AS INTEGER, Shift AS INTEGER)
  SELECT CASE KeyCode
    CASE 39
      IF Shift = 0 THEN Tag = "arrow" ELSE Tag = ""
    CASE ELSE
  END SELECT
END SUB

SUB Form_KeyPress (KeyAscii AS INTEGER)
  IF KeyAscii = 39 THEN Tag = ""
  PRINT CHR$(KeyAscii);
END SUB

SUB Form_KeyUp (KeyCode AS INTEGER, Shift AS INTEGER)
  IF KeyCode = 39 AND Tag = "arrow" THEN PRINT CHR$(16);
END SUB

The preceding code takes advantage of the fact that KeyPress does not detect
arrow keys -- if the key is detected in that event procedure, the code sets
the form's Tag property to "" and prints the character. The Tag property is 
then used in the KeyUp event procedure to print a "" character if KeyCode
39 is detected.


---------
1.2 Forms
---------

Ending Form Applications
------------------------
If your compiled application has a hidden form and then unloads the last
visible form, the system appears to stop. This occurs because there is
still a loaded form, but no way to access it. To avoid this, end your 
applications explicitly using an END statement or its equivalent, rather
than relying on UNLOAD.

Note that reading or setting an unloaded form's properties or controls
implicitly loads that form without displaying it. This is the most common
way to get into the situation described above.

Visibility
----------
Hiding a modal form makes that form nonmodal. Hiding an MDI form hides all 
of its children: Thus, any modal children will no longer be modal when 
they are shown again (unless explicitly shown again as modal). SCREEN.HIDE 
hides all visible forms: Thus, modal  forms will be hidden and will no 
longer be modal when they are shown again (unless explicitly shown as modal).

You can change the Visible property of child controls while their parent
is hidden, but the Visible property of child controls will return False (0)
as long as the parent is hidden. For example:

frmOpen.Visible = 0                     ' Hide parent form.
cmdState% = frmOpen.cmdExit.Visible     ' cmdState% will be 0 (False)
frmOpen.cmdExit.Visible = NOT cmdState% ' Change Visible property.
frmOpen.Visible = -1                    ' Show form again.

In the preceding code, you might expect the third line to toggle the
visibility of the command button. Instead, it sets Visible to True
(NOT 0 = -1), regardless of the initial setting of cmdExit.Visible.

Menus and Timer Events
----------------------
While a menu control has focus, timer events and ON <event> trapping are
suspended. When the menu control loses focus, timer events and ON <event>
trapping resume.

Insert State
------------
Forms programs maintain the insert state internally. There is no way to
programmatically switch between insert and overstrike in a text box.

Monochrome Displays
-------------------
For best appearance on monochrome displays, you should avoid 3-D. For
example, the following turns off 3-D if a system does not have color or
grey scale capability:

SUB CheckMono ( )
  ON LOCAL ERROR GOTO SetNo3D
  SCREEN.HIDE
  SCREEN 1                   ' SCREEN 1 requires minimal graphics.
  ON LOCAL ERROR GOTO 0
  SCREEN 0
  SCREEN.SHOW
  EXIT SUB
SetNo3D:
  SCREEN.ControlPanel(THREE_D) = 0
  RESUME NEXT
END SUB

When creating form applications for users with monochrome monitors, be aware
that the default color setting for access keys may display as bright white
on bright white on some monitors. For applications that target this hardware,
you may want to rely on tab order rather than access keys to provide a
keyboard interface.

The sample applications included with Visual Basic are written for color
monitors and monitors that support grey scale. If they do not display 
properly on your system, turn off 3-D in their form load event procedures.

Setting ForeColor Property
--------------------------
SCREEN.ControlPanel(THREE_D) must be set to FALSE (0) for changes to the
ForeColor property to affect the border of a control. While THREE_D is 
TRUE (-1), Visual Basic supplies the border color.

Symbol Help on Controls
-----------------------
You cannot get Help on a control if it is not referenced in code from its 
parent form. For example, in module ONE.FRM:

SUB frmONE_Click()
cmdOK.Visible = FALSE
END SUB

In module TWO.FRM:

X$ = frmONE.cmdOK.Tag
Y$ = frmONE.fraHelp.Tag

In the preceding example, pressing F1 on cmdOK displays symbol Help on the
control, but pressing F1 on fraHelp only beeps.

Maximum Number of Controls 
--------------------------
The maximum number of controls on a form is 254.

Maximum Number of Timers 
------------------------
You cannot have more than 16 active timers at any one time. A timer is
active if its Enabled property is True and its Interval property is nonzero.
Custom controls that function as timers also apply to this limit. This
limit does not apply to inactive timers.

Forms in Quick Libraries
------------------------
You can create Quick libraries out of form modules by following the same
procedures for Basic code modules. To access the properties of a Quick 
library form or control in your application, you must declare the Quick
library form by manually inserting a $FORM metacommand at the module level
of the calling code.

With project files, the programming environment automatically inserts
'$FORM metacommands as needed. However, the programming enviroment cannot
do this for forms in Quick libraries, since they are already compiled.

Accessing Width and Height Properties Before Forms are Visible
--------------------------------------------------------------
To ensure correct values for a form's Width and Height properties and
SCREEN.Width and SCREEN.Height, execute a SHOW method before using
them.

"Overflow" with ASCII Forms 
---------------------------
The Form Designer generates an "Overflow" error message if the absolute
coordinates of an object exceed 255. This can occur only with ASCII form
descriptions created outside of the Form Designer. "Absolute coordinates"
are the values that result from combining the Top + Height or Left + Width
property values of a control and its parents. When these combine in a way
that the right edge or bottom edge of a control exceeds 255, the "Overflow"
error results.

To fix this, you must reduce the Top, Height, Left, or Width property values
of the object or its parents in the ASCII form using an ordinary text editor.

Child Form Placement in MDI Form_Load Event 
-------------------------------------------
To ensure the correct display of child forms and print output, add a SHOW
statement as the first line of the Form_Load event procedure of any form that
is an MDI container. For example:

' Event procedure in frmMDI.FRM.
SUB Form_Load ( )
    frmMDI.SHOW
END SUB

This forces a redraw event which sets the MDI container's ScaleHeight and
ScaleWidth properties to their maximized settings, rather than the
design-time settings.

Option Buttons and Modal Operations
-----------------------------------
Option buttons sometimes require multiple clicks to become selected if the
code in their click events include modal operations such as displaying
a MSGBOX or hiding forms. For example, the following code requires multiple
clicks to select option buttons Option1 or Option2:

SUB Option1_Click ()
SCREEN.HIDE
WIDTH , 43
SCREEN.SHOW
END SUB

SUB Option2_Click ()
SCREEN.HIDE
WIDTH , 25
SCREEN.SHOW
END SUB

Separator Bar as First Menu Item
--------------------------------
If you specify a separator bar as the first menu control below a top-level
menu item, you won't be able to select menu items in that list using
the keyboard.

KeyUp Events and Menus
----------------------
KeyUp events for the active control will be generated when using access
or shortcut keys for menus.  To differentiate between menu generated
KeyUp events and user generated KeyUp events for the active control, set
a flag in the control's KeyDown event procedure that can be tested before
processing keys in the KeyUp event procedure.

Child Form Width and Resize Events
----------------------------------
If a child form has the same width as its MDI container, it will not
generate a resize event when maximized.

Height and Width of Attached Scroll Bars 
----------------------------------------
The Height and Width properties of scroll bars that are attached to a form
do not return accurate values when the form is first displayed. Height and
Width return accurate values after a resize event occurs.

Printing Attached Scroll Bars 
-----------------------------
Scroll bars that are attached to a form do not print if the the form is not
active when the PRINTFORM method is invoked.

Forms Disable Blinking
----------------------
Using MSGBOX, INPUTBOX$, or forms disables the blinking bit in MS-DOS. 
To re-enable blinking and restore correct COLOR statement settings when
forms are not showing, call the MS-DOS interrupt 10H. For example:

' Requires VBDOS.QLB for CALL Interrupt.
REM $INCLUDE: 'vbdos.bi'
DIM inregs AS regtype, outregs AS regtype
CLS
COLOR 26, 6                 ' Blinking green on red.
PRINT "Blinking text"
SLEEP 1                     ' Pause
screen.controlpanel(7) = 0  ' Preserve background.
MSGBOX "Click OK."          ' MSGBOX turns off blinking
                            ' and changes colors.
' These statements restore colors and blinking.
inregs.ax = &H1003
inregs.bx = 1
CALL interrupt(&H10, inregs, outregs)

Passing Control Array Elements
------------------------------
You cannot pass an entire control array to a procedure as an argument. 
When you pass a control array element to a procedure, you pass only that
instance of the control, as in the following example:

type% = IsCmdBtn%(RandomControl(1)) ' Pass control array element to procedure

FUNCTION IsCmdBtn%(X AS CONTROL)
  IF TYPEOF X IS CommandButton THEN
    FindType% = TRUE
  ELSE
    FindType% = FALSE
  END IF
END FUNCTION

Note that you can't discern that X refers to a control array element once
the control is passed to the procedure.

In compiled programs, you cannot pass a control array element into a
procedure, then load it from that procedure. For example, the following
code generates the error "Control array element does not exist" if
executed in a compiled program:

LoadIt cmdButton(1)

SUB LoadIt (X as CONTROL)
  LOAD X
END SUB

Note that the preceding code will run in the programming environment without
an error. This difference occurs because compiled applications are "early
bound."

TabStop Property
----------------
Using access keys on a form where all controls have TabStop = FALSE will
cause unpredictable results.


------------
1.3 Language
------------

String Literals in Memory
-------------------------
String literals (i.e. quoted strings "This is a string") are stored in far 
memory. All string literals in a form or code module are stored in their 
own 64K segment. Thus, storage for string literals no longer comes out of 
DGROUP.

Line Continuation
-----------------
When loading or compiling Basic code created outside of the programming 
environment, the underscore character (_) may be used to continue a line 
if it is preceded by a tab or space. Terminating a line with the underscore 
alone causes an error. The programming environment automatically joins
continued lines and removes line-continuation characters when you load code.
Note that the underscore without a preceding space can now be used in symbol
names.

Keyword Conflicts
-----------------
When loading a SUB or FUNCTION with an invalid definition -- a parameter 
list contains a variable with the same name as a reserved word -- that SUB or
FUNCTION definition will not be recognized; instead it will be placed
at the module level and flagged as an error. The code contained in the
procedure will also be placed at module level. If this occurs, orrect the 
invalid definition and reload the file.

Calling C Routines From Basic
-----------------------------
If you are writing C routines to use with Basic, you should be aware
that all routines that Basic calls that can cause an error (either
directly or indirectly, including math errors and divide-by-zero)
must set up a BP frame. However, the Microsoft C Compiler optimizes 
away the BP frame if the routine has no parameters or local variables.
If this occurs, you can rectify the problem by turning off optimizations
when compiling your C routine or by adding a local variable to the
routine.

RMDIR "."
---------
Using RMDIR with "." generates the error "Path not found." You cannot
remove the current directory.

User-Defined Error Numbers
--------------------------
Error number 105 is used by the system as a temporary error number and 
should not be used as a user-defined error number in your programs. 
If used, it halts execution of your application but does not generate
the error message, "Unprintable Error," as other unassigned error numbers
do.

Setting ERR
-----------
You cannot use the ERR statement with arguments greater than 255. To work
around this, use ERROR to generate the error. For example:

ON ERROR RESUME NEXT
ERROR 431
PRINT ERR

FRE(-3) and Overlays
--------------------
Using FRE(-3) in a compiled program is no longer supported and will return
the error message "Feature Unavailable."

GET, PUT, SADD, SWAP, VARSEG, VARPTR$ 
-------------------------------------
Visual Basic permits you to use form variables with these statements and
functions, but such use is not meaningful and will cause unpredictable
results. For example:

SUB ChangeCaption (X AS FORM)
DEF SEG = VARSEG (X)                 ' May cause system to stop.
' Other code ommitted.
END SUB

Using MSGBOX, INPUTBOX$ with Existing Code
------------------------------------------
By default, these statements display the default form background pattern.
To preserve your screen, set the ControlPanel(DESKTOP_PATTERN) property.
For example:

LOCATE 10, 10 : PRINT "Preserve this text"
SCREEN.ControlPanel(7) = 0                           ' 7 = DESKTOP_PATTERN
MSGBOX "This is displayed without blanking screen."

OPTION EXPLICIT and Immediate Window
------------------------------------
If your program uses OPTION EXPLICIT, you must declare any variables used
in the Immediate window. For example:

DIM i%: FOR i% = 1 to 10: PRINT i%: NEXT


--------
1.4 LINK
--------

The Microsoft Segment-Executable Linker (LINK) can make use of a DPMI server
such as 386MAX or Windows enhanced mode. LINK runs fine without a DPMI 
server, however. If it cannot locate a DPMI server, LINK displays a warning 
message and then executes in real mode.


---------------------------
1.5 Hardware Considerations
---------------------------

Phantom Drive Support
---------------------
Accessing the phantom drive (drive B on a single-floppy system) when
forms are showing on the screen causes the operating system to 
print the message "Insert diskette for drive B: and press any key when
ready" if the B drive is not considered active. This message is
printed on top of any visible forms at the current cursor location.
To respond to this message and allow the operating system to continue,
the user must ensure the drive door is closed and then press any key.

Your program cannot trap this message using error handling, but you can
intercept problems before they occur by searching a drive list box for
the "B:" specification and then prohibiting your program from switching to
the B: drive if it is not present. For example, the following code uses
a drive list box (Drive1) to check if a B: drive exists and sets a flag
to TRUE if it does:

' Module level
DIM SHARED BFlag AS INTEGER

SUB Form_Load ( )
  FOR i% = 0 to Drive1.ListCount
    IF INSTR(Drive1.List(i%), "B:") THEN BFlag = TRUE
  NEXT
END SUB

Invalid Drive on Start-Up
-------------------------
Make sure the current drive is valid (the drive exists and contains a disk)
before starting VBDOS, FD, or running an application with a directory list
in the programming environment. If the drive is not valid, you may receive
an "Out of memory" error message.

French Keyboards
----------------
In the Form Designer, the M accelerator key does not work if your cursor is
in an edit field.

In the programming environment, bookmarks do not work correctly with this
keyboard driver.

Monochrome Monitors 
-------------------
Some systems with monochrome monitors may not display the programming
environment and Form Designer correctly. Applications created with Visual
Basic will display correctly on these systems, however.

ATI Ultra VGA Video Cards 
-------------------------
Systems with this card may wrap the first character of print output to the
end of the preceding line in screen mode 10.

InColor Hercules Video Cards
----------------------------
The programming environment and the Form Designer display in black and
white on systems with this card. In addition, text box controls do not
display a cursor on these systems.

SCREEN 13 with SpeedStar VGA Video Cards
----------------------------------------
Screen mode 13 causes display anomalies on the output screen with SpeedStar
VGA video cards. This occurs when displaying the output screen with F4 and
when stepping through an application in the programming environment.

Aspect Ratio with Wyse EGA and CGA Video Cards
----------------------------------------------
Use an aspect ratio of 1.2 when drawing circles on Wyse EGA and CGA video
cards to make circles appear round.


----------------
1.6 TRNSLATE.EXE 
----------------
For specific information on language differences between Visual Basic for
Windows and Visual Basic for MS-DOS, see the "Programmer's Guide" appendixes
E, G, H, and I and the file COMPAT.TXT.

VBDOS.EXE, VB.EXE, and FT.EXE 
-----------------------------
All of these executables must be in directories in your PATH environment
variable when you run TRNSLATE.EXE.

Character Mappings 
------------------
TRNSLATE.EXE and FT.EXE do not map extended ASCII characters (>128) to their
ANSI equivalents and vice versa. For this reason, it is a good idea to 
replace extended characters, such as umlauts, with non-extended characters
before converting your application.

Note that using extended ANSI characters in a form or control name in
Visual Basic for Windows results in an invalid form or control name in
Visual Basic for MS-DOS.


-------------------
1.7 Custom Controls
-------------------

Cannot Cancel Load or Unloads
-----------------------------
You cannot return a error from the custom control load or unload event
-- Custom1_CustomUnload -- to prevent your custom control from being
loaded or unloaded. Load or unload prevention is not possible, and returning
an error from these functions can de-stabilize the system and cause it to
stop. Thus, if you use the InvokeEvent callback to provide an Unload
event procedure for your custom control to your users, you must ignore
the Cancel parameter or map its meaning to something else, since you cannot
cancel the unload process. This applies to control array elements as
well as to controls being unloaded due to form unload.

SetAttribute Routine
--------------------
Use the SetAttribute callback routine to specify an access key for a custom
control, allow the control to reject focus, reject arrow-key trapping, or
control the display of a text cursor on the control. 

In Basic, declare SetAttribute as follows:

DECLARE SUB SetAttribute (BYVAL ControlID AS INTEGER, _
  BYVAL AttributeID AS INTEGER, BYVAL Value AS INTEGER)

Parameter     Description
-----------   -------------------------------------------------------------
ControlID     ControlID property of the custom control.
AttributeID   Attribute to set.
Value         Setting of the attribute.

Constant values for AttributeID are contained in the CUSTINCL Include files
and have these values:

Settings for AttributeID                             Settings for
constant (literal)        Description                Value parameter
------------------------  -------------------------  --------------------
ATTR_AccessKey     (0)    Specifies ASCII            ASCII code of key
                          code of access key.        (not case-sensitive)
ATTR_AcceptFocus   (1)    Specifies whether control  TRUE (-1)
                          can receive focus.         FALSE (0)
ATTR_TrapArrowKeys (2)    Specifies whether control  TRUE (-1)
                          can detect arrow           FALSE (0)
                          keys in Key events.
ATTR_TextCursor    (3)    Determines the style of    0 - 2
                          cursor on the control.

ATTR_AccessKey - Value is the ASCII code for the access key. The key is 
not case-sensitive (A = a). You can have only one access key per control. 
You must display the string containing the access key on your control, parse 
the &, and highlight the access-key character (as is done for standard 
controls such as command buttons). A Value of 0 (default)  specifies no 
access key.

ATTR_AcceptFocus - TRUE (default) allows the control to have focus. 
FALSE makes the control act like a label and reject the focus (focus passes 
to the next control in TabIndex).

ATTR_TrapArrowKeys - TRUE (default) enables arrow key (up, down, left, right) 
trapping in the key-handling event procedures.  FALSE does not trap these 
keys and allows arrow keys to act like TAB (as with command buttons). 

ATTR_TextCursor - Displays a text cursor at CurrentX, CurrentY on your custom
control. This text cursor follows CurrentX and CurrentY until turned off.
This is useful for creating custom textboxes or for showing focus. Value is 
enumerated as follows (constants are defined in CUSTINCL include files):

Settings for Value
Constant (Literal)    Description
------------------    -----------------------------
TC_NoCursor    (0)    No text cursor (default).
TC_Underscore  (1)    Blinking underscore cursor.
TC_Block       (2)    Blinking block cursor.

Note that changing the text cursor for a custom control also changes the 
cursor on the active control if that control displays a cursor. (If this
happens, the original cursor for the active control is restored when the
control loses, then regains focus.)

Using SetAttribute on a standard control may produce unpredictable results. 
Passing an invalid AttributeID does the same, as does passing an invalid 
Value for the given AttributeID.

Cursor Coordinates
------------------
CurrentX and CurrentY are relative to the current control. When there are
multiple containers for a control, the absolute coordinates of CurrentX
and CurrentY may exceed 255. In this situation, there is a remote chance that 
the cursor may reappear on the screen at a seemingly random location.
When writing a custom control that displays a cursor, you should test
the behavior of your control when absolute CurrentX and CurrentY coordinates
exceed 255.

"String formula too complex" Error 
----------------------------------
Custom controls may cause this error if you have not defined a handler for
the ADDITEM method. The CUSTGEN utility generates a handler for this method
if you include MthAddItem in the Template Events list box.

Restoring TabIndex
------------------
Setting CurrentX, CurrentY, or Interval within custom control code may
reset TabIndex, accidentally. To avoid this, store the TabIndex property
before setting CurrentX, CurrentY, or Interval, then restore TabIndex.

ReadOnly and Enabled Properties
-------------------------------
Setting one of these properties for a custom control inadvertantly sets the
other to the same value. If you use the ReadOnly property in your custom
control, trap the value when set and store it internally in your custom
control code. Use this internal value to control ReadOnly behavior to and
return the correct value to the user whenever the property is read.

Run-time Only Properties
------------------------
The values of the following properties will not be saved at design-time:
    Drive, FileName, Path, SelText, Text
These properties should be used as run-time only properties and masked
out at design-time.


------------
1.8 CodeView
------------
The version of CodeView supplied with Visual Basic for MS-DOS (4.02) is newer
than that supplied with Microsoft C/C++ 7.0. This newer version can be 
used with C7. The same is true for CVPACK.EXE and LINK.EXE.

CodeView requires a memory manager such as HIMEM.SYS, Microsoft Windows, 
or 386MAX. CodeView also requires a 80286/386/486 processor.

Variables are Case-Sensitive
----------------------------
Use of variable names within CodeView is case-sensitive. Any reference to a
variable from the Command window or within a watch expression must match
the case used when the variable was first declared.

In addition, if you have variable of the same name but different case within
scope, CodeView will only look for the variable that matches the case of the
first instance.

Viewing Basic String Variables in CodeView
------------------------------------------
You cannot directly watch the value of a Basic string in CodeView.
To view the value of a string variable, use the b$sd routine from the
Command window.

Syntax for b$sd is as follows:

b$sd(&stringvar),S

The argument stringvar is the name of a string variable minus the
type-declaration character (if used). If the variable is a formal
parameter within a procedure, omit the &. For example:

In code                In CodeView Command window    Type of string
--------------------   ----------------------------  ----------------------
DIM X$                 >?b$sd(&X),S                  With type character
DIM Y AS STRING        >?b$sd(&Y),S                  Without type character
Z$ = X$ + " "          >?b$sd(&Z),S                  Automatic variable
SUB Foo(ABC as STRING) >?b$sd(ABC),S                 Formal parameter

If you omit the ,S option, CodeView returns a pointer to the string address
rather than the value of the string.

Viewing Numeric Arrays and Fixed-Length String Variables
--------------------------------------------------------
Since you can view the data at specific memory locations in CodeView, you
can see the values of numeric arrays and fixed-length string variables in
hexadecimal with a little ingenuity. 

Things to Avoid
---------------
Do not set breakpoints on form objects using the BP command in the Command
window (for example, >BP Form1). Doing so can cause unpredictable results 
during subsequent execution.

Be sure to terminate your Basic application before exiting CodeView. Exiting
while execution is suspended may cause problems in restoring the MS-DOS
cursor and may cause errors the next time you invoke CodeView.

Using Animate from the Run menu is not practical with applications that use
forms. Since form application have an implicit DOEVENTS loop, the animation
seems to "stick" at one instruction.

Applications that rely on timers, such as CLOCK.FRM, may not update as
expected when debugged in CodeView.


------------
1.9 Overlays
------------

Calculating the Offset of Errors
--------------------------------
If you are using the assembly listing generated when compiling with /A to
debug an overlaid program, you must subtract the start address of the
overlaid module from the offset in the error message to get the correct
code offset. For example:

Error Message:

Division by zero in line 0 of WILMA     as address 9FE9:0129

Excerpt of .MAP File Generated by LINK:

Start   Stop    Length Name                Class
. . .
Overlay 1H
00000H  00053H  00054H  FRED_CODE          BC_CODE
00060H  000B3H  00054H  BARNEY_CODE        BC_CODE
000C0H  00154H  00095H  WILMA_CODE         BC_CODE
Overlay 2H
. . .
  
To calculate the actual error address, subtract the start address of the
module WILMA (000C0H) from the offset given in the error message (0129):

129H - C0H = 69H

The offset of the error is 0069 in the compiler assembly listing.

CHAIN  
-----
You cannot use CHAIN in overlaid applications compiled without /O. This is
because the run-time module is retained in memory across the CHAIN and a
new overlay heap cannot be initialized.


---------
1.10 ISAM
---------

Microsoft Windows
-----------------
When using the ISAM TSRs (PROISAM.EXE, PROISAMD.EXE) in conjunction with
Microsoft Windows, you must first start Windows and then load the ISAM TSR
in an MS-DOS box. You cannot start Windows once the ISAM TSR has been
loaded.

MS-DOS version 3.10 
-------------------
ISAM does not run under MS-DOS version 3.10. Opening a file for ISAM access
results in a "Device I/O" error under that version MS-DOS.


-------------
1.11 BUILDRTM
-------------

Removing ISAM and/or Forms Support
----------------------------------
Use the NOISAM.OBJ stub file to exclude ISAM support from your custom
run-time modules. Use the NOFORMS.OBJ stub file to exclude forms support
from your custom run-time module. 

In the standard run-time module, ISAM and forms features are loaded into 
memory at startup only if your application uses the feature. With a custom
run-time module, these features are always loaded at startup, unless you
use the stub files described above.

LINK and BUILDRTM
-----------------
BUILDRTM automatically invokes LINK with a /SEGMENTS option based on the
number of objects and libraries being built. To manually set the /SEGMENTS
option, set a LINK environment variable with the desired setting.

Including Forms and Custom Controls
-----------------------------------
You can include compiled form modules and custom controls in a custom 
run-time module. To access a form included in a custom run-time module,
add a $FORM metacommand for the form to the module-level code of your
application.


------------
1.12 PROFILE
------------
The Microsoft Profiler cannot profile applications linked with /EX, which
is the default when building an .EXE file from the programming environment.
In order to profile an application, you must link it from the command line
using the /CO linker option and omitting /EX.


===========================================================================
Part 2: Corrections to "Microsoft Visual Basic Programmer's Guide"
===========================================================================

Page    Section\Note
----    ------------

xvii    Sample Applications
        -------------------
        REMLINE.MAK is not shipped with Visual Basic.
        SORTDEMO.MAK and TORUS.MAK are included in the Professional Edition
        only. The file for the SPIN custom control is SPINDEMO.*, not
        CUSTCTRL.*.

200     Table at Top of Page
        --------------------
        "ir1_Click" should be "Dir1_Click".

490     Using Extended and Expanded Memory
        ----------------------------------
        The last part of the second paragraph should read "and 0K of XMS
        for the programming environment."

497     Memory Map Table
        ----------------
        As noted previously in this file, quoted string literals are stored
        in Far Heap, not Near Heap (DGROUP).

519     Language Summary, ALIAS Keyword
        -------------------------------
        The ALIAS keyword is available in Visual Basic for Windows.

534     Language Summary, String Routines
        ---------------------------------
        All of the following string routines are available in Visual Basic
        for MS-DOS and are completely compatible with the Microsoft Basic
        Professional Development System: StringAddress, StringAssign,
        StringLength, StringRelease.

563     Drawing the Form
        ----------------
        The illustration does not match the code that accompanies it.
        The text boxes should be labels and they should display different
        data.

564     Adding Code to Load the Form
        ----------------------------
        The code that loads the form should be:

        CASE "B"
          frmSTUDENT.SHOW 1


===========================================================================
Part 3: Corrections to "Microsoft Visual Basic Reference"
===========================================================================

Page    Section\Note
----    ------------

iii     Document Conventions
        --------------------
        Keywords are shown in normal, uppercase in tables. Not bold.
        Keywords and literals are bold in syntax.

 29     AutoRedraw Example
        ------------------
        The third sentence that introduces the example should read
        "Print output on the form is retained when the form displays
        since AutoRedraw is True." It is important to set AutoRedraw
        to True if you want to display output printed to the form during
        the Load event.

 34     BorderStyle Property
        --------------------
        BorderStyle is read-only at run time for the forms and text box
        controls. It is read/write at run time for labels and picture boxes.

        BorderStyle 3 has Minimize and Maximize buttons.

123     DragDrop Event Syntax
        ---------------------
        Event procedure parameters (Source, X, Y, and Index) should not be
        bold. You may use any names for these parameters. The ones shown
        are provided automatically when you create an event procedure with
        the Edit Event Procedures dialog box. This applies to all event
        procedure syntax in the "Reference."

145     ERR Statement
        -------------
        The value of n% cannot be >255.

170     FORMAT$ Function
        ----------------
        The formating characters for fmt$ are omitted. See online Help for
        this information.

201     $INCLUDE Syntax
        ---------------
        The syntax for the $INCLUDE metacommand is as follows:

        {' | REM}$INCLUDE: 'filespec'

212     INPUTBOX$ Function
        ------------------
        If prompt$ exceeds the length of a line, it automatically wraps
        to the next line.

251,    LPRINT, PRINT, PRINT #
329,    ----------------------
330     You can't use the comma with the USING clause in any of these
        statements or methods.

259     Menu Control
        ------------
        There is no DropDown event for menu controls.

273     MSGBOX Function
        ---------------
        The last line of example text should read:

        x% = MSGBOX(Msg$)

331     PRINT Statement
        ---------------
        The PRINT statement documentation is included under the LPRINT
        statment.

351     SCREEN Object
        -------------
        AutoRedraw does not apply to the SCREEN object.

433     WRITE # Remarks
        ---------------
        The first paragraph indicates that using WRITE # to print to the
        screen causes an error if used with forms. It should state that this
        causes an error if forms are currently displayed.

440     Scan Code Table
        ---------------
        The scan code for decimal 78 is the gray "+" key, not "-" as shown.


===========================================================================
Part 4: Corrections to Online Help
===========================================================================

Creating a Control Array
------------------------
Steps 2 and 3 in this procedure are functionally redundant. Setting the Index
property to 0 creates the control as an element of a control array, as does
giving two controls the same CtlName property at design time.

Save File As
------------
You can save forms in text format.

Scan Code Table
---------------
The table is missing these entries:

Key   Code
---   ----
Esc      1
A       30
F1      59

AutoRedraw Property
-------------------
This property does not apply to the SCREEN object.

BorderStyle Property
--------------------
BorderStyle is read-only at run time for the forms and text box controls.
It is read/write at run time for labels and picture boxes.

BorderStyle 3 has Minimize and Maximize buttons.

ERR Statement
-------------
The value of n% cannot be > 255.

INPUTBOX$ Function Details
--------------------------
If prompt$ exceeds the length of a line, it automatically wraps to the next
line.

Menu Control Details
--------------------
There is no DropDown event for menu controls.

SCREEN Object Summary
---------------------
The AutoRedraw property does not apply to the SCREEN object.


===========================================================================
Part 5: Corrections to "Microsoft Visual Basic Professional Features"
===========================================================================

Page    Section\Note
----    ------------

 31     Format of .DEF File
        -------------------
        The placeholder segementname is the base name of the Basic
        source file plus the string "_CODE". For example, if a module is
        named NEW.BAS, the segmentname is "NEW_CODE".

271     SLN# Function
        -------------
        The second bullet should be deleted.
