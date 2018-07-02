/* ----------------------------------------------------------------------------
 * CUSTEVNT.C: Custom Control Event Procedures
 *
 * Custom control event procedure templates created by
 * CUSTGEN.EXE (Custom Control Template Generator).
 *
 * CUSTGEN.EXE is a utility provided to make custom
 * control development easier.  It allows you to select
 * the events you want your custom control to respond to,
 * then generates code templates and a custom control
 * registration routine for these events.
 *
 * Modify the code template file as necessary, then build
 * your custom control as follows:
 *    ML -c <RegisterFile>          ; Assumes Masm 6.0 compiler
 *    CL -c <TemplateFile>
 *    DEL <TemplateFile.LIB>        ; Delete existing library if exists
 *    LIB <TemplateFile.LIB>+<RegisterFile.OBJ>+<TemplateFile.OBJ>
 *    LINK /Q <TemplateFile.LIB>,<TemplateFile.QLB>,,VBDOSQLB.LIB;
 * You can combine multiple custom controls into one Quick library for
 * use within the programming environment as follows:
 *    DEL <CombinedLib.LIB>         ; Delete existing library if exists
 *    LIB <CombinedLib.LIB>+<Cust1.LIB>+<Cust2.LIB>+<CustN.LIB>
 *    LINK /Q <CombinedLib.LIB>,<CombinedLib.QLB>,,VBDOSQLB.LIB;
 * To create an Alternate Math custom control library (instead of an
 * Emulator Math custom control library as shown above), compile the 
 * TemplateFile with the /FPa switch.  Note, an Altmath library cannot be
 * used to create a Quick Library.
 *
 *
 * Copyright (C) 1982-1992 Microsoft Corporation
 *
 * You have a royalty-free right to use, modify, reproduce
 * and distribute the sample applications and toolkits provided with
 * Visual Basic for MS-DOS (and/or any modified version)
 * in any way you find useful, provided that you agree that
 * Microsoft has no warranty, obligations or liability for
 * any of the sample applications or toolkits.
 * -------------------------------------------------------------------------- */


/* Include file containing constant definitions for
 * Property, Event, Method and ControlType ID numbers. */
#include "custincl.h"

/* Declarations for custom control callbacks.
 * These callbacks are used to set and get custom control
 * properties and invoke custom control methods and events.
 *
 *    AID = Attribute Id - list is found in CUSTINCL include file.
 *    CID = Control Id created internally by Visual Basic
 *    EID = Event Id - list is found in CUSTINCL include file.
 *    MthID = Method Id - list is found in CUSTINCL include file.
 *    PID = Property Id - list is found in CUSTINCL include file.
 *
 * Declare callbacks for invoking methods and events and getting
 * and setting properties.  These callbacks accept a variable number 
 * and types of arguments depending on the method or event that is 
 * being invoked. */
extern void _far _pascal InvokeEvent();
extern void _far _pascal InvokeMethod();
extern void _far _pascal GetProperty();
extern void _far _pascal SetProperty();

/* Declare callback for getting a control's container object.
 * This callback returns a ControlID for the container object. */
extern int _far _pascal GetContainer (unsigned int CID);

/* Declare callback for setting a control's attributes (access key,
 * focus availability, arrow key trapping ability, and text cursor 
 * location).  Refer to the custom control section of the README.TXT
 * file for complete information on using this callback. */
extern void _far _pascal SetAttribute (unsigned int CID, unsigned int AID, unsigned int Value);

/* Declare unique callbacks for each property datatype for 
 * setting and getting property values by aliasing the
 * GetProperty and SetProperty callbacks which accept any datatype.
 * This provides type checking during calls to these procedures. */
#define GetIntProperty(Value, CID, PID)     GetProperty ((int *) Value, (unsigned int) CID, (unsigned int) PID)
#define GetStringProperty(Value, CID, PID)  GetProperty ((char *) Value, (unsigned int) CID, (unsigned int) PID)
#define GetLongProperty(Value, CID, PID)    GetProperty ((long *) Value, (unsigned int) CID, (unsigned int) PID)
#define SetIntProperty(Value, CID, PID)     SetProperty ((int) Value, (unsigned int) CID, (unsigned int) PID)
#define SetStringProperty(Value, CID, PID)  SetProperty ((char *) Value, (unsigned int) CID, (unsigned int) PID)
#define SetLongProperty(Value, CID, PID)    SetProperty ((long) Value, (unsigned int) CID, (unsigned int) PID)

/* Declare unique callbacks for invoking each user event
 * by aliasing the InvokeEvent callback which accepts a variable number
 * of arguments and types depending on the event being invoked.
 * This provides type checking during calls to these procedures. */
#define InvokeChangeEvent(CID, EventID)                     InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokeClickEvent(CID,  EventID)                     InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokeCustomEvent(EventType, CID, EventID)          InvokeEvent ((int *) EventType, (unsigned int) CID, (unsigned int) EventID)
#define InvokeDblClickEvent(CID, EventID)                   InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokeDragDropEvent(SourceCID, X, Y, CID, EventID)  InvokeEvent ((unsigned int) SourceCID, (float *) X, (float *) Y, (unsigned int) CID, (unsigned int) EventID)
#define InvokeDragOverEvent(SourceCID, X, Y, CID, EventID)  InvokeEvent ((unsigned int) SourceCID, (float *) X, (float *) Y, (unsigned int) CID, (unsigned int) EventID)
#define InvokeDropDownEvent(CID, EventID)                   InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokeGotFocusEvent(CID, EventID)                   InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokeKeyDownEvent (KeyCode, Shift, CID, EventID)   InvokeEvent ((int *) KeyCode, (int *) Shift, (unsigned int) CID, (unsigned int) EventID)
#define InvokeKeyPressEvent(KeyCode, CID, EventID)          InvokeEvent ((int *) KeyCode, (unsigned int) CID, (unsigned int) EventID)
#define InvokeKeyUpEvent(KeyCode, Shift, CID, EventID)      InvokeEvent ((int *) KeyCode, (int *) Shift, (unsigned int) CID, (unsigned int) EventID)
#define InvokeLoadEvent(CID, EventID)                       InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokeLostFocusEvent(CID, EventID)                  InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokeMouseDownEvent(Button, Shift, X, Y, CID, EventID)    InvokeEvent ((int *) Button, (int *) Shift, (float *) X, (float *) Y, (unsigned int) CID, (unsigned int) EventID)
#define InvokeMouseMoveEvent(Button, Shift, X, Y, CID, EventID)    InvokeEvent ((int *) Button, (int *) Shift, (float *) X, (float *) Y, (unsigned int) CID, (unsigned int) EventID)
#define InvokeMouseUpEvent(Button, Shift, X, Y, CID, EventID)      InvokeEvent ((int *) Button, (int *) Shift, (float *) X, (float *) Y, (unsigned int) CID, (unsigned int) EventID)
#define InvokePaintEvent(CID, EventID)                      InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokePathChangeEvent(CID, EventID)                 InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokePatternChangeEvent(CID, EventID)              InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokeResizeEvent(CID, EventID)                     InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokeTimerEvent(CID, EventID)                      InvokeEvent ((unsigned int) CID, (unsigned int) EventID)
#define InvokeUnloadEvent(Cancel, CID, EventID)             InvokeEvent (int *) Cancel, (unsigned int) CID, (unsigned int) EventID)

/* Declare unique callbacks for invoking each custom control method
 * by aliasing the InvokeMethod callback which accepts a variable number
 * of arguments and types depending on the method being invoked.
 * This provides type checking during calls to these procedures. */
#define InvokePrintFormMethod(NumArgs, CID, MthID)          InvokeMethod ((unsigned int) NumArgs, (unsigned int) CID, (unsigned int) MthID);
#define InvokeCLSMethod(NumArgs, CID, MthID)                InvokeMethod ((unsigned int) NumArgs, (unsigned int) CID, (unsigned int) MthID);
#define InvokeHideMethod(NumArgs, CID, MthID)               InvokeMethod ((unsigned int) NumArgs, (unsigned int) CID, (unsigned int) MthID);
#define InvokeShowMethod(Modal, NumArgs, CID, MthID)        InvokeMethod ((int) Modal, (signed int) NumArgs, (unsigned int) CID, (unsigned int) MthID);
#define InvokeRefreshMethod(NumArgs, CID, MthID)            InvokeMethod ((unsigned int) NumArgs, (unsigned int) CID, (unsigned int) MthID);
#define InvokeMoveMethod(Left, Top, Width, Height, NumArgs, CID, MthID)    InvokeMethod ((int) Left, (int) Top, (int) Width, (int) Height, (unsigned int) NumArgs, (unsigned int) CID, (unsigned int) MthID);
#define InvokeSetFocusMethod(NumArgs, CID, MthID)           InvokeMethod ((int) NumArgs, (unsigned int) CID, (unsigned int) MthID);
#define InvokeDragMethod(Action, NumArgs, CID, MthID)       InvokeMethod ((int) Action, (unsigned int) NumArgs, (unsigned int) CID, (unsigned int) MthID);


int _far _pascal MyControl_CClick(void _near * Control, unsigned int ControlID)
{

/* Place your comments and code for this event here.
 * Basic errors are triggered by returning a non-zero value (ERR).
 * Set and get properties and invoke methods and user events and 
 * by using the appropriate callbacks declared above.
 * PropertyID, EventID, and MethodID constant definitions are
 * are contained in the CUSTINCL include file. */

/* IMPORTANT: You must always have a return value. */
    return (0);
} 

int _far _pascal MyControl_CKeyPress(void _near * Control, unsigned int ControlID, int * KeyAscii)
{

/* Place your comments and code for this event here.
 * Basic errors are triggered by returning a non-zero value (ERR).
 * Set and get properties and invoke methods and user events and 
 * by using the appropriate callbacks declared above.
 * PropertyID, EventID, and MethodID constant definitions are
 * are contained in the CUSTINCL include file. */

/* IMPORTANT: You must always have a return value. */
    return (0);
} 

int _far _pascal MyControl_CIntegerGet(void _near * Control, unsigned int ControlID, int PropertyID, int * Value)
{

/* Place your comments and code for this event here.
 * Basic errors are triggered by returning a non-zero value (ERR).
 * Set and get properties and invoke methods and user events and 
 * by using the appropriate callbacks declared above.
 * PropertyID, EventID, and MethodID constant definitions are
 * are contained in the CUSTINCL include file. */

/* IMPORTANT: You must always have a return value. */
    return (0);
} 
