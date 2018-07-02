// ----------------------------------------------------------------------------
// CUSTCALL.C: Custom Control Callback Examples
//
// Copyright (C) 1982-1992 Microsoft Corporation
//
// You have a royalty-free right to use, modify, reproduce
// and distribute the sample applications and toolkits provided with
// Visual Basic for MS-DOS (and/or any modified version)
// in any way you find useful, provided that you agree that
// Microsoft has no warranty, obligations or liability for
// any of the sample applications or toolkits.
//
// NOTE: This file demonstrates sample usage of the custom control
// callbacks. It is provided for examples of how different
// callbacks work. It is not part of a working custom control.
// ----------------------------------------------------------------------------

// Include file containing constant definitions for
// Property, Event, Method and ControlType ID numbers.
#include "custincl.h"
#include <stdio.h>

// Declarations for custom control callbacks.
// These callbacks are used to set and get custom control
// properties and invoke custom control methods and events.
//
//    AID = Attribute Id - list is found in CUSTINCL.H
//    CID = Control Id created internally by Visual Basic
//    PID = Property Id - list is found in CUSTINCL.H

// Declare callbacks for setting and getting property values
extern void _far _pascal SetProperty ();
extern void _far _pascal GetProperty ();

// Declare callback for getting a control's container object.
// This callback returns a CID for the container object.
extern unsigned int _far _pascal GetContainer (unsigned int CID);

// Declare callback for setting a control's attributes (access key,
// focus availability, arrow key trapping ability, and text cursor 
// location).  Refer to the custom control section of the README.TXT
// file for complete information on using this callback. 
extern void _pascal SetAttribute (unsigned int CID, unsigned int AID, unsigned int Value);

// Declare callbacks for invoking methods and events.  These
// callbacks accept a variable number and types of arguments
// depending on the method or event that is being invoked.
extern void _far _pascal InvokeEvent ();
extern void _far _pascal InvokeMethod ();

unsigned int _pascal ControlID1;         // Storage for ControlId value
unsigned int _pascal ControlID2;         // Storage for ControlId value
unsigned int _pascal SourceControlID;    // ControlId value for DragDrop source

int _pascal Left1;                       // stores custom1.left
int _pascal Top1;                        // stores top
long _pascal Interval1;                  // stores custom1.interval
unsigned long _pascal SDVal1;            // stores custom1.caption
unsigned int _pascal ContainerID;        // stores parent ID
float _pascal CoordX;                    // stores x coord for dragdrop
float _pascal CoordY;                    // stores x coord for dragdrop
unsigned int _pascal TypeOfControl;      // stores TYPEOF info


// -------------------------------------------------------------------
// The examples below assume that SDVal1 contains a valid Basic
// string descriptor.  See the Mixed-Language Programming chapter
// in the Professional Features Guide for more information.
// ---------------------------------------------------------------------


// SetAttribute example
void AttributeSet(void)
{

// Example of using the SetAttribute callback to specify access
// key for a custom control.  Note, it is up to the custom control
// developer to actually display the text containing the access key.

	// Set Alt+A or Alt+a as the access key.
	SetAttribute (ControlID1, ATTR_AccessKey, 65);      // Alt+A.

}

// Property set examples
void PropSet(void)
{

// SetProperty is a callback used to set INTEGER, LONG, and STRING properties.
// All arguments to this routine must be passed BYVAL (the string for
// string property set must be passed by reference however).  The callback
// determines property type (INTEGER, LONG, STRING) based on the
// PropertyID (last argument).  If an incorrect value type is passed
// for the given PropertyID, unpredictable results will occur.

// control.left = 25
	SetProperty (25, ControlID1, PROP_Left);

// control.interval = 50000L
	SetProperty (50000L, ControlID1, PROP_Interval);

// control.caption = SDVal1
	SetProperty ((void _near *)&SDVal1, ControlID1, PROP_Caption);
}


// Property get examples
void PropGet(void)
{

// GetProperty is a callback used to get INTEGER, LONG, and STRING properties.
// The first argument to this routine must be passed by reference,
// all others must be passed BYVAL.  The property value corresponding
// to the PropertyID (last argument) is returned via the first argument (not
// returned by Getproperty itself).  The callback determines
// property type (INTEGER, LONG, STRING) based on the PropertyID
// (last argument).  If an incorrect data type is passed
// for the given PropertyID, unpredictable results will occur.

// Left1 = Control1.left
	GetProperty (&Left1, ControlID1, PROP_Left);

// Interval1 = Control1.Interval
	GetProperty (&Interval1, ControlID1, PROP_Interval);

// SDVal1 = Control1.caption
	GetProperty (&SDVal1, ControlID1, PROP_Caption);

// Example of using the GetProperty callback to retrieve the
// control's type (TYPEOF).
	GetProperty (&TypeOfControl, ControlID1,
			 PROP_TypeOf);                   //TypeOfControl = Control1.TypeOf
	if (TypeOfControl == TYPEOF_Form)
		printf("Container is a FORM\n");

}


// GetContainer example
void GetParent(void)
{

// Example of using the GetContainer callback to retrieve
// a control's container object (returned as a ControlID).
	ContainerID = GetContainer(ControlID1);

}


// InvokeEvent example
void EventInvoke(void)
{

// Example of using the InvokeEvent callback to trigger a
// custom control's DragDrop event and execute user's DragDrop
// code if it exists.  The standard event arguments (passed to
// the user's code) are listed
// first, followed by the ControlID and EventID for the control
// and event to be triggered.  If the arguments passed don't match
// the number and type of arguments expected for the EventID,
// unpredictable results will occur.

InvokeEvent (SourceControlID, &CoordX, &CoordY, ControlID1, EVENT_DragDrop);

}


// InvokeMethod example
void MethodInvoke(void)
{

// Example of using the InvokeMethod callback to invoke
// a custom control's MOVE method.  The MOVE method can take
// up to 4 arguments (left, top, width, height).  The
// order in which the arguments are passed to InvokeMethod
// is the same as that for the method, followed by the
// number of arguments and the ControlID and
// MethodID.  All arguments must be passed by value.
// If the arguments passed don't match the number and type of
// arguments expected for the MethodID, unpredictable results will occur.

	InvokeMethod (Left1, Top1, 2, ControlID1, METHOD_Move);
}

