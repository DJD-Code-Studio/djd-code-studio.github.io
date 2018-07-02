' Procedure declarations for Help Toolkit.
'

' Public routines.
DECLARE SUB HelpRegister (HelpFile$, Success AS INTEGER)
DECLARE SUB HelpShowTopic (ProvidedTopic$)
DECLARE SUB HelpClose ()
DECLARE SUB HelpSetOptions (bcolor AS INTEGER, fcolor AS INTEGER, dbcolor AS INTEGER, dfcolor AS INTEGER, buttoncolor AS INTEGER, SelectColor AS INTEGER, Flags AS INTEGER)
DECLARE SUB HelpSearch ()

' Private routines.
DECLARE SUB HelpPrintText (TopLine AS INTEGER, LeftPos AS INTEGER)
DECLARE FUNCTION HelpMax (int1 AS INTEGER, int2 AS INTEGER) AS INTEGER
DECLARE FUNCTION HelpMin (int1 AS INTEGER, int2 AS INTEGER) AS INTEGER
DECLARE SUB cmdOK_Click ()
DECLARE SUB cmdButtonBar_Click (index AS INTEGER)
DECLARE SUB Form_Unload (Cancel AS INTEGER)

