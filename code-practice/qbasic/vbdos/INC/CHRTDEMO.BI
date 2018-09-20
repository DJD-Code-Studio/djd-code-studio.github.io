' Constant and global variable declarations for
' chart demo.


'$INCLUDE: 'chart.bi'
'$INCLUDE: 'font.bi'
'$INCLUDE: 'vbdos.bi'

CONST cMaxValues = 15                       'Maximum values
CONST cMaxSets = 15                         'Maximum sets
CONST cMaxSeries = 15                       'Maximum data series

CONST CANCEL = 3                            'status flags
CONST OK = 1

CONST MAXCOLORS = 16                        ' max colors in color lists
CONST MAXFONTS = 16                         ' max fonts in font list


'necessary declarations for using toolboxes
' chart environment variables
COMMON SHARED /chrtdemo/ CEnv AS ChartEnvironment   'Main
COMMON SHARED /chrtdemo/ setNum AS INTEGER          'number of data sets

COMMON SHARED /chrtdemo/ colors$()                  'color list
COMMON SHARED /chrtdemo/ numColors AS INTEGER       'number of colors

COMMON SHARED /chrtdemo/ fonts$()                   'loaded fonts
COMMON SHARED /chrtdemo/ numFonts AS INTEGER        'number of fonts

' chart data variables
COMMON SHARED /chrtdemo/ catLen AS INTEGER                 '# of categories
COMMON SHARED /chrtdemo/ Cat$()                           'category names
COMMON SHARED /chrtdemo/ setName$()                       'set names
COMMON SHARED /chrtdemo/ setLen()  AS INTEGER             '# values per set
COMMON SHARED /chrtdemo/ setVal!()                        ' actual values
COMMON SHARED /chrtdemo/ screenMode AS INTEGER            'screen mode

