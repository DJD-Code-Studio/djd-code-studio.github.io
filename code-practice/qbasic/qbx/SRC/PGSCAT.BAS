' PGSCAT.BAS:  Create sample scatter diagram

DEFINT A-Z
' $INCLUDE: 'CHRTB.BI'
CONST FALSE = 0, TRUE = NOT FALSE, MONTHS = 12
CONST HIGHESTMODE = 13, TEXTONLY = 0

DIM Env AS ChartEnvironment                 ' See CHRTB.BI for declaration of                     ' the
																						' ChartEnvironment type
DIM OJvalues(1 TO MONTHS) AS SINGLE         ' Array for 1st data series
DIM HCvalues(1 TO MONTHS) AS SINGLE         ' Array for 2nd data series
DECLARE FUNCTION BestMode ()

' Initialize the data arrays
FOR index = 1 TO MONTHS: READ OJvalues(index): NEXT index
FOR index = 1 TO MONTHS: READ HCvalues(index): NEXT index

' Pass the value returned by the BestMode function to the Presentation
' Graphics routine ChartScreen to set the graphics mode for charting

ChartScreen (BestMode)      ' Even if SCREEN is already set to an acceptable
														' mode, you still have to set it with ChartScreen
IF ChartErr = cBadScreen THEN   ' Check to make sure ChartScreen succeeded
	PRINT "Sorry --- There is a screen-mode problem in the Charting library"
	END
END IF

' Initialize a default pie chart
																			' Pass Env (the environment variable);
DefaultChart Env, cScatter, cNoLines  ' constant cScatter (for Scatter Chart);
																			' cNoLines (unjoined points)

' Add Titles and some chart options. These assignments modify some default
' values set in the variable Env (of type ChartEnvironment) by DefaultChart

Env.MainTitle.Title = "Good Neighbor Grocery" ' Specifies text of chart title
Env.MainTitle.TitleColor = 11                 ' Specifies color of title text
Env.MainTitle.Justify = cRight                ' How to align of title text
Env.SubTitle.Title = "OJ vs. Hot Chocolate"   ' Text of chart subtitle
Env.SubTitle.TitleColor = 15                  ' Color of subtitle text
Env.SubTitle.Justify = cRight                 ' How to align of subtitle text
Env.ChartWindow.Border = cNo                  ' Specifies chart has no border

' The next two assignments label the x and y axes of the chart
Env.XAxis.AxisTitle.Title = "Orange Juice Sales"
Env.YAxis.AxisTitle.Title = "Hot Chocolate Sales"

' Call the pie-charting routine --- Arguments for call to ChartPie are:
' Env                 - Environment variable
' OJvalues            - Array containing orange-juice sales values to chart
' HCvalues            - Array containing hot-chocolate sales values to chart
' MONTHS              - Tells number of data values to chart

	ChartScatter Env, OJvalues(), HCvalues(), MONTHS
	SLEEP
	'  If the rest of your program isn't graphic, reset original mode here
END

' Simulate data generation for chart values and category labels
DATA 33,27,42,64,106,157,182,217,128,62,43,36
DATA 37,37,30,19,10,5,2,1,7,15,28,39      

'============= Function to determine and set highest resolution ========
' The BestMode function uses a local error trap to check available modes,
' then assigns the integer representing the best mode for charting to its
' name so it is returned to the caller. The function terminate execution if
' the hardware doesn't support a mode appropriate for Presentation Graphics
'========================================================================
FUNCTION BestMode

' Set a trap for an expected local error --- handled within the function
ON LOCAL ERROR GOTO ScreenError

FOR TestValue = HIGHESTMODE TO 0 STEP -1
	DisplayError = FALSE
	SCREEN TestValue
	IF DisplayError = FALSE THEN
		SELECT CASE TestValue
			CASE 12, 13
				BestMode = 12
			CASE 9, 10, 11
				BestMode = 9
			CASE 8, 4, 3
				BestMode = TestValue
			CASE 2, 7
				BestMode = 2
			CASE 1
				BestMode = 1
			CASE ELSE
				PRINT "Sorry, you need graphics to display charts"
				END
		END SELECT
		EXIT FUNCTION
	END IF
NEXT TestValue
' Note there is no need to turn off the local error handler. It is turned off
' automatically when control passes out of the function

EXIT FUNCTION
'==================== | Local error handler code |=======================
' The ScreenError label identifies a local error handler relied in the
' BestMode function. Invalid SCREEN values generate Error # 5 (Illegal
' function call) --- so if that is not the error reset ERROR to the ERR
' value that was generated so the error can be passed to other, possibly
' more appropriate errors.
ScreenError:
	IF ERR = 5 THEN
		DisplayError = TRUE
		RESUME NEXT
	ELSE
		ERROR ERR
	END IF
END FUNCTION

