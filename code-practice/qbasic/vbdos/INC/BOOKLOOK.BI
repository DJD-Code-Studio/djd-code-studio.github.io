' Procedure declarations and type structure definitions
' for BookLook ISAM demo.
'

' Procedure declarations.
DECLARE SUB DisplayRecord ()
DECLARE SUB SaveRecord ()
DECLARE SUB KeyHandle (KeyCode AS INTEGER)
DECLARE SUB OpenFile ()

' General constants.
CONST FALSE = 0
CONST TRUE = NOT FALSE
 
' Constants for the database table names.
CONST cBookStockTableNum = 1
CONST cCardHoldersTableNum = 2
CONST cBooksOutTableNum = 3

' Structure corresponding to BooksOut table.
TYPE BookStatus
  IDnum     AS DOUBLE
  CardNum   AS LONG
  DueDate   AS DOUBLE
END TYPE

' Structure corresponding to CardHolders table.
TYPE Borrowers
  CardNum         AS LONG
  Zip             AS LONG
  TheName         AS STRING * 36
  City            AS STRING * 26
  Street          AS STRING * 50
  State           AS STRING * 2
END TYPE

' Structure corresponding to BookStock table.
TYPE Books
  IDnum     AS DOUBLE
  Price     AS CURRENCY
  Edition   AS INTEGER
  Title     AS STRING * 50
  Publisher AS STRING * 50
  Author    AS STRING * 36
END TYPE

TYPE RecStruct                  ' This structure contains each of the other
  TableNum    AS INTEGER        ' other table structures. When you pass a
  WhichIndex  AS STRING * 40    ' reference to this structure to procedures
  Inventory   AS Books          ' the procedure decodes the TableNum
  Lendee      AS Borrowers      ' element, then deals with the proper table.
  OutBooks    AS BookStatus     ' WhichIndex is used to communicate the index
END TYPE                        ' the user wants to set.

' Common variables.
COMMON SHARED /booklook/ BigRec AS RecStruct    ' User-defined type structures corresponding
                                                ' to ISAM tables.  Used to access record information.
COMMON SHARED /booklook/ TempRec AS RecStruct   ' Temporary record used to compare against BigReg

COMMON SHARED /booklook/ CardRecordChanged AS INTEGER ' Tracks CardHolder record changes.
COMMON SHARED /booklook/ BookRecordChanged AS INTEGER ' Tracks BookStock record changes.

' Application forms.
'$FORM frmList
'$FORM frmSearch
'$FORM frmCardHolder
'$FORM frmBookStock
'$FORM frmBooklook

