' Include file for the Presentation Graphics ToolKit font routines.
'
' This file should be included in any application
' using the Presentation Graphics font routines.
' It contains declarations for all of the
' user-accessible routines as well as type definitions
' for the FontInfo datatype used by most
' of the routines.  Also included are constant
' definitions for some of the parameters that must be
' specified when using the font routines.
'
' Copyright (C) 1982-1992 Microsoft Corporation
'

'-- Global constants:
CONST cFontBlockSize = 100
CONST cIBMChars = 0
CONST cWindowsChars = 1

' Type to hold information about a font:
TYPE FontInfo
   FontNum        AS INTEGER        ' Position of font in reg. or loaded list
   Ascent         AS INTEGER        ' From baseline to top of ascender
   Points         AS INTEGER
   PixWidth       AS INTEGER        ' 0 if proportional, width otherwise
   PixHeight      AS INTEGER        ' Height of character bitmap
   Leading        AS INTEGER        ' Internal leading above body of chars
   AvgWidth       AS INTEGER        ' Average pixel width of chars
   MaxWidth       AS INTEGER        ' Maximum pixel width of character
   FileName       AS STRING * 66    ' .FON File name
   FaceName       AS STRING * 32    ' Type face name
END TYPE

' Data type for blocks in the font data array:
TYPE FontDataBlock
   Block    AS STRING * cFontBlockSize   ' Buffer block for font data
END TYPE

'-- Declarations for FontLib functions and subroutines:

DECLARE SUB SetMaxFonts (Registered AS INTEGER, Loaded AS INTEGER)
DECLARE SUB GetMaxFonts (Registered AS INTEGER, Loaded AS INTEGER)
DECLARE SUB GetTotalFonts (Registered AS INTEGER, Loaded AS INTEGER)

DECLARE FUNCTION RegisterFonts% (FileName$)
DECLARE FUNCTION RegisterMemFont% (FontSeg AS INTEGER, FontOffset AS INTEGER)
DECLARE SUB UnRegisterFonts ()

DECLARE FUNCTION LoadFont% (FontSpec$)
DECLARE SUB SelectFont (FontNumber AS INTEGER)

DECLARE SUB GTextWindow (X1 AS SINGLE, Y1 AS SINGLE, X2 AS SINGLE, Y2 AS SINGLE, Scrn AS INTEGER)
DECLARE SUB SetGCharset (CharSet AS INTEGER)
DECLARE SUB SetGTextColor (C AS INTEGER)
DECLARE SUB SetGTextDir (Dir AS INTEGER)
DECLARE FUNCTION OutGText% (X AS SINGLE, Y AS SINGLE, Text$)
DECLARE FUNCTION GetGTextLen% (Text$)

DECLARE SUB GetFontInfo (FontParams AS FontInfo)
DECLARE SUB GetRFontInfo (Font AS INTEGER, FontParams AS FontInfo)

'-- Error return variable and CONST definitions:

COMMON SHARED /FontLib/ FontErr AS INTEGER

CONST cFLUnexpectedOff = 200  'Unexpected BASIC error offset
CONST cFileNotFound = 1        'Specified file not found (RegisterFonts)
CONST cBadFontSpec = 2         'Invalid part of a font spec (LoadFont)
CONST cFontNotFound = 3        'Spec. doesn't match any font (LoadFont)
CONST cBadFontFile = 5         'Invalid font file format (RegisterFonts)
CONST cBadFontLimit = 6        'Invalid font limit (SetMaxFonts)
CONST cTooManyFonts = 7        'Tried to go past limit (LoadFont, RegisterMemFont,
'                               RegisterFonts)
CONST cNoFonts = 8             'No loaded fonts (SelectFont, GetFontInfo,
'                               GetGTextLen, LoadFont)
CONST cBadFontType = 10        'Not bitmap font (RegisterMemFont)
CONST cBadFontNumber = 11      'Bad Font Number (GetRFontInfo)
CONST cNoFontMem = 12          'Not enough memory (SetMaxFonts, LoadFonts)

