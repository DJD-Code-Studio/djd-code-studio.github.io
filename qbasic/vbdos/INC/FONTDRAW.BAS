' ------------------------------------------------------------------------
' Visual Basic for MS-DOS Font ToolKit Demo Program Support Module
'
' Provides font display routine for specified font,
' screen mode, and text.
'
' Font display support comes from the Font tooklit.
' To run this program you must use the supplied
' library (FONT.LIB, FONTA.LIB) and Quick Library
' (FONT.QLB).
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

' Include file containing Font Toolkit procedure
' declarations and variable definitions.
'$INCLUDE: 'font.bi'

' Variable to hold font information.
DIM SHARED FI AS FontInfo

' Font display routine.
' Display supplied text in indicated font and screen mode.
'
SUB DisplayFont (Font$, ScreenMode%, Text$)
    ' Set the maximum number of fonts that can be loaded
    ' Note, one font file can contain multiple fonts.
    SetMaxFonts 10, 10

    ' Register selected font file.
    Reg% = RegisterFonts(Font$)

    ' If an error has occurred, display error and exit.
    ' Note, if font file is currently locked (sharing violation),
    ' a font file not found error will be generated.
    IF FontErr THEN
        MSGBOX "Font cannot be displayed (FontErr = " + STR$(FontErr) + ").", 0, "Font Toolkit Demo"
        EXIT SUB
    ELSEIF Reg% = 0 THEN
        MSGBOX "Only vector fonts can be displayed.", 0, "Font Toolkit Demo"
        EXIT SUB
    END IF

    ' Load all fonts contained in font file.
    StrLen% = Reg% * 3 - 1
    IF Reg% > 9 THEN StrLen% = StrLen% + Reg% - 9
    LoadStr$ = LEFT$("N1/N2/N3/N4/N5/N6/N7/N8/N9/N10", StrLen%)
    TotalLoad% = LoadFont(LoadStr$)

    ' If an error has occurred, display error and exit.
    IF FontErr THEN
        MSGBOX "Font cannot be displayed (FontErr = " + STR$(FontErr) + ").", 0, "Font Toolkit Demo"
        EXIT SUB
    END IF

    ' Hide form.
    SCREEN.HIDE
    ' Switch to given graphics mode to display font.
    SCREEN ScreenMode%

    ' Determine proper characteristics for screen mode.
    SELECT CASE ScreenMode%
        CASE 1: XS% = 160: YS% = 100
        CASE 2: XS% = 320: YS% = 100
        CASE 3: XS% = 360: YS% = 174
        CASE 4: XS% = 320: YS% = 200
        CASE 7: XS% = 160: YS% = 100
        CASE 8: XS% = 320: YS% = 100
        CASE 9: XS% = 320: YS% = 175
        CASE 10: XS% = 320: YS% = 175
        CASE 11: XS% = 320: YS% = 240
        CASE 12: XS% = 320: YS% = 240
        CASE 13: XS% = 160: YS% = 100
    END SELECT

    ' Display each font contained in the file.
    FOR i% = 1 TO TotalLoad%
        CLS

        ' Get the font information.
        SelectFont i%
        GetFontInfo FI
        SetGTextDir 0
        SetGTextColor 14

        ' Display font name and size.
        Length% = OutGText(1, 1, RTRIM$(FI.FaceName))
        Length% = OutGText(1, 1 + FI.PixHeight, LTRIM$(STR$(FI.Points) + " Point"))

        ' Display given text in current font.
        FOR Dir% = 0 TO 3
            SetGTextDir Dir%
            SetGTextColor 15 - Dir%
            SELECT CASE Dir%
                CASE 0: X% = XS%: Y% = YS% - FI.PixHeight
                CASE 1: X% = XS% - FI.PixHeight: Y% = YS%
                CASE 2: X% = XS%: Y% = YS% + FI.PixHeight
                CASE 3: X% = XS% + FI.PixHeight: Y% = YS%
            END SELECT
            Length% = OutGText(CSNG(X%), CSNG(Y%), Text$)
        NEXT Dir%

        ' Display prompt to continue to next font.
        SetGTextDir 0
        SetGTextColor 14
        prompt$ = "Press any key to continue"
        Length% = GetGTextLen(prompt$)
        Length% = OutGText(2 * XS% - Length% - 10, 2 * YS% - FI.PixHeight - 1, prompt$)
        DO UNTIL INKEY$ <> "": LOOP
    NEXT i%

    ' Reset screen mode and redisplay the form.
    SCREEN 0
    WIDTH 80, 25
    SCREEN.SHOW
END SUB

