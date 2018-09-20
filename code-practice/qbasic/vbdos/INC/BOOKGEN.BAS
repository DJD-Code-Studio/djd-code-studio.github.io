' ------------------------------------------------------------------------
' Visual Basic for MS-DOS BookLook ISAM Demo Program
'
' BOOKGEN.BAS - General routines support module.
'
' Booklook is an ISAM sample program that manages a
' database of fictitious library books (BOOKS.MDB).
'
' Refer to module-level comments in BOOKLOOK.FRM
' for more information about this sample program.
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

' Include file containing procedure declarations and variable definitions.
'$INCLUDE: 'BOOKLOOK.BI'


' Sample library data for creating a new ISAM file.
' Format is:
'   Number records in CardHolder table
'   Cardholder record 1
'   Cardholder record 2
'      ....
'   Cardholder record n
'
'   Number records in BookStock table
'   BookStock record 1
'   BookStock record 2
'      ....
'   BookStock record n
'
'   Number records in BooksOut table
'   BooksOut record 1
'   BooksOut record 2
'      ....
'   BooksOut record n
'
DATA 16
DATA "Tomas, Richard", "213 Happy Lane", "Erehwon", "WA",  98042 ,  31277
DATA "Johnson, Pamela", "61 Rendezvous Road", "Redburn", "WA",  98073 ,  17445
DATA "Jones, Ted", "743 Orderly Park", "Oso", "WA",  98137 ,  16632
DATA "Sands, Steve", "1234 Sequential Street", "Index", "WA",  98333 ,  22321
DATA "Richards, Ellen", "1519 Whammadiddle Drive", "Sourwood Mountain", "NC",  37128 ,  10324
DATA "Green, Richard", "666 Spirit Circle", "Port Townsend", "WA",  98432 ,  11121
DATA "Mull, John", "23014 Somewhere Place", "Lincoln", "NY",  98021 ,  23175
DATA "Barnes, Ralph", "34 Crampon Blvd", "Tucson", "AK",  97234 ,  12113
DATA "Jackson, Sally", "89 Gold Camp Lane", "Barrow", "AZ",  76113 ,  39442
DATA "Burke, Barbara", "4 Circle Square", "Kluter", "MN",  53396 ,  11345
DATA "Stevens, Tom", "911 S. Porsche Drive", "Coupeville", "WA",  98239 ,  11443
DATA "Blake, Ruth", "232 Rana Road", "Pipiens", "CA",  92021 ,  22222
DATA "Adams, Mark", "6 Lighthouse Lane", "Sandville", "WA",  82345 ,  27731
DATA "Press, Beth", "122 S. Amazon Road", "Volvo City", "VA",  68122 ,  21905
DATA "Rollins, Nancy", "Aleph-0 Cardinal Court", "Infinity", "WA",  97191 ,  15907
DATA "Carey, Evan", "1 Cartesian Street", "Cogito", "CA",  94305 ,  20202
DATA  51
DATA "Computer BASIC the Easy Way", "Downing, Douglas", "Barron",  9.95 ,  2 ,  81200.4253
DATA "Microsoft Quick BASIC Programming for the PC", "Cornell, Gary", "Sams",  21.95 ,  1 ,  67202.2683
DATA "Exploring the Geometry of Nature: Computer...", "Reitman, Edward", "TAB Bks",  24.95 ,  1 ,  83069.1375
DATA "Advanced Structured Basic for the IBM PC", "Carney, Richard", "HarBraceJ",  18 ,  1 ,  15501.2347
DATA "Microsoft BASIC Using a Modular Structure", "Bradley, Julia C.", "Wm C Brown",  10.95 ,  2 ,  69703.0276
DATA "Introduction to Computing with BASIC", "Spencer, Donald D.", "Camelot Pub",  12.95 ,  1 ,  89218.1419
DATA "Computer Mathematics with BASIC Programming", "Spencer, Donald D.", "Camelot Pub",  14.95 ,  1 ,  89218.1354
DATA "Introduction to Computing Using BASIC", "Levine, Leonard", "Kendall-Hunt",  10.95 ,  1 ,  84034.6565
DATA "Basic Keyboarding Applications", "LaBarre, James E., et al.", "SRA",  29.95 ,  1 ,  13351.3501
DATA "BASIC: A Structured Approach, IBM Version", "IBM Technical Staff", "SW Pub",  14.95 ,  2 ,  53810.7901
DATA "Handbook of Basic for the IBM PC, XT, etc.", "Schneider, David I.", "Brady Bks",  24.95 ,  3 ,  13372.5802
DATA "Structured BASIC Programming", "Moriber, Harry", "Merrill",  29.95 ,  1 ,  67520.0715
DATA "Advanced QuickBASIC", "Knecht, Ken", "Scott F",  21.95 ,  1 ,  67338.1501
DATA "QuickBasic: Programming Techniques & Library...", "Shammas, Namir C.", "M&T Pub Inc",  19.95 ,  1 ,  15585.1004
DATA "Microsoft BASIC: Programming the IBM PC", "Bent, Robert J.; Sethares, George C.", "Brooks-Cole",  24 ,  2 ,  53410.1161
DATA "The BASIC Book", "Fanzone, Penny; Hankins, Tom", "Knopf",  11.95 ,  2 ,  39439.3236
DATA "Computer Concepts & Applications", "O'Brien", "Irwin",  33.95 ,  3 ,  25607.0016
DATA "Computers & End-User Software with BASIC", "Athey, Thomas H., et al.", "Scott F",  22.95 ,  2 ,  67338.4055
DATA "Computer Information Systems with BASIC: A...", "Tom, Paul", "Scott F",  22.95 ,  1 ,  67318.7608
DATA "Instructional Design for Computers: Cognitive...", "Gallini, Joan K.; Gredler, Margaret", "Scott F",  22.95 ,  1 ,  67339.8196
DATA "Programming in Basic for Engineers", "Rojiani, Kamal B.", "PWS-Kent Pub",  28.5 ,  1 ,  53491.8999
DATA "Advanced Structured Basic: File Processing...", "Payne, James", "PWS-Kent Pub",  24.5 ,  1 ,  53491.8722
DATA "BASIC: Concepts & Structured Problem-Solving", "Boillot, Michel", "West Pub",  35.75 ,  2 ,  31465.4615
DATA "Microsoft QuickBASIC: Developing Structured...", "Hergert, Douglas", "Microsoft",  19.95 ,  2 ,  15561.5125
DATA "The Microsoft QuickBASIC Programmer's Toolbox", "Craig, John C.", "Microsoft",  22.95 ,  1 ,  15561.1276
DATA "QuickBASIC Made Easy", "Albrecht, Bob; Wiegand, Wenden; Brow", "Osborne-McGraw",  19.95 ,  1 ,  78814.2819
DATA "Advanced QuickBASIC", "Albrecht, Bob; Inman, Don; Crane, Do", "McGraw",  21.95 ,  1 ,  70081.1361
DATA "Using QuickBASIC", "Inman, Don; Albrecht, Bob", "Osborne-McGraw",  19.95 ,  1 ,  70081.2747
DATA "Structured BASIC Programming on IBM PCs", "Castek, John", "Wiley",  12.95 ,  1 ,  77160.4895
DATA "Structured Basic Fundamentals & Style for IBM PC..", "Quansey, James S.; Maniotes, John", "Boyd & Fraser",  30 ,  1 ,  87835.2899
DATA "Quick Basic 4.0 Programming for the IBM", "Townsend, Carl", "Sams",  12.95 ,  1 ,  67222.6332
DATA "Handbook of Basic for the IBM PC, XT,...", "Schneider, David I.", "Brady Comp Bks",  24.95 ,  1 ,  13372.5821
DATA "Structured BASIC Programming", "Moriber, Harry", "Merrill",  27.95 ,  1 ,  67520.7015
DATA "Advanced BASIC Programming", "Onyett, Lloyd", "Heath",  21 ,  1 ,  66915.4415
DATA "BASIC Game Plans: Computer Games & Puzzles...", "Baumann, Ruediger", "Birkhauser",  35 ,  1 ,  81763.3677
DATA "Short Course in Structured BASIC Programming...", "Blissmer, Robert H.; Castek, John E.", "Wiley",  45.95 ,  1 ,  47160.1713
DATA "Big Blue BASIC: Programming the IBM PC...", "Rob, Peter", "Wadsworth Pub",  19.95 ,  1 ,  53408.7056
DATA "Using Microsoft Quickbasic to Write Better...", "Cooper, James", "Wiley",  35 ,  1 ,  47161.3011
DATA "Programming in BASIC: A Structured Approach", "Stern, Matthew H.; Cashman, Mark", "Comp Info Sci",  27.95 ,  1 ,  93647.7032
DATA "Basic for the IBM PC", "Shelly, Gary B.; Cashman, Thomas J.", "Boyd & Fraser",  30 ,  1 ,  87835.2122
DATA "Structured BASIC Applied to Technology", "Adamson, Thomas A.", "Merrill",  24.95 ,  1 ,  67520.7721
DATA "Structured BASIC Applied to Technology", "Adamson, Thomas A.", "Merrill",  24.95 ,  1 ,  67520.7722
DATA "Structured BASIC Applied to Technology", "Adamson, Thomas A.", "Merrill",  25.95 ,  1 ,  67520.7723
DATA "Structured BASIC Applied to Technology", "Adamson, Thomas A.", "Merrill",  25.95 ,  1 ,  67520.7724
DATA "Structured BASIC Applied to Technology", "Adamson, Thomas A.", "Merrill",  26.5 ,  1 ,  67520.7725
DATA "Problem Solving with ANSI Structured BASIC", "Yarmish, Rina; Yarmish, Joshua", "SRA",  10.95 ,  1 ,  13168.8846
DATA "QuickBASIC", "Scott, Fred", "Scott F",  22.95 ,  1 ,  67338.0823
DATA "Number Problem Visual Masters: With BASIC...", "Spencer, Donald D.", "Camelot Pub",  13.95 ,  1 ,  89218.1567
DATA "Math Problem Visual Masters: With BASIC...", "Spencer, Donald D.", "Camelot Pub",  13.95 ,  1 ,  89218.1568
DATA "IBM-PC Basic with An Introduction to...", "Serebreny, Raphael E.", "P-H",  26.67 ,  1 ,  13449.4057
DATA "Introduction to Computers & Information Systems...", "Athey, Thomas H.; Zmud, Robert W.", "Scott F",  19.95 ,  1 ,  67318.9891
DATA  37
DATA  31277 ,  69703.0276 ,  33803
DATA  23175 ,  15585.1004 ,  34200
DATA  31277 ,  53491.8999 ,  33950
DATA  17445 ,  67520.0715 ,  33820
DATA  23175 ,  15561.5125 ,  33878
DATA  17445 ,  81200.4253 ,  33836
DATA  12113 ,  13449.4057 ,  33911
DATA  39442 ,  67318.9891 ,  33945
DATA  11345 ,  71313.5867 ,  33973
DATA  27731 ,  25607.0016 ,  34041
DATA  17445 ,  66915.4415 ,  34003
DATA  31277 ,  70081.1361 ,  34123
DATA  23175 ,  53491.8722 ,  33811
DATA  17445 ,  53410.1161 ,  33945
DATA  12113 ,  67520.7723 ,  33999
DATA  39442 ,  47160.1713 ,  34110
DATA  31277 ,  87835.2899 ,  33945
DATA  23175 ,  77160.4895 ,  33879
DATA  31277 ,  31465.4615 ,  33841
DATA  17445 ,  93647.7032 ,  33945
DATA  31277 ,  47161.3011 ,  33973
DATA  23175 ,  13168.8846 ,  33841
DATA  17445 ,  67318.7608 ,  34070
DATA  12113 ,  13372.5802 ,  34101
DATA  23175 ,  70081.2747 ,  34098
DATA  17445 ,  13372.5821 ,  33822
DATA  12113 ,  67222.6332 ,  33755
DATA  39442 ,  89218.1354 ,  33750
DATA  31277 ,  53810.7901 ,  33805
DATA  23175 ,  84034.6565 ,  33945
DATA  31277 ,  89218.1567 ,  34073
DATA  17445 ,  78814.2819 ,  34141
DATA  31277 ,  67520.7721 ,  33993
DATA  10324 ,  67339.8196 ,  33900
DATA  21905 ,  39439.3236 ,  33850
DATA  20202 ,  15561.1276 ,  33859
DATA  22222 ,  15501.2347 ,  33950

' Record display routine.
' Displays current record from active table on the form
' corresponding to that table.
'
SUB DisplayRecord ()
    ' Setup error handling for display errors.
    ON LOCAL ERROR GOTO DisplayError
    
    SELECT CASE BigRec.TableNum
    ' Display record from BookStock table on the BookStock form.
    CASE cBookStockTableNum
        ' Check if table contains records.
        IF LOF(cBookStockTableNum) > 0 THEN
            ' Get the current record.
            RETRIEVE cBookStockTableNum, BigRec.Inventory

            ' Determine if book is checked out.
            SETINDEX cBooksOutTableNum, "IDIndexBO"
            SEEKEQ cBooksOutTableNum, BigRec.Inventory.IDnum

            ' If book is checked out, update status to reflect it.
            IF NOT EOF(cBooksOutTableNum) THEN
                RETRIEVE cBooksOutTableNum, BigRec.OutBooks
                frmBookStock.lblStatus.Caption = "Status:   OUT"
                frmBookStock.lblDueDate.Caption = "Due Date: " + FORMAT$(BigRec.OutBooks.DueDate, "mm/dd/yy")
                frmBookStock.cmdCheck.Caption = "Check In..."
            ' Book is not checked out.
            ELSE
                frmBookStock.lblStatus.Caption = "Status:   IN"
                frmBookStock.lblDueDate.Caption = "Due Date:"
                frmBookStock.cmdCheck.Caption = "Check Out..."
            END IF
        ' Table contains no records.
        ELSE
            BigRec.Inventory.Title = ""
            BigRec.Inventory.Author = ""
            BigRec.Inventory.Publisher = ""
            BigRec.Inventory.Price = -1
            BigRec.Inventory.Edition = -1
            BigRec.Inventory.IDnum = -1
            frmBookStock.lblStatus.Caption = "Status:   "
            frmBookStock.lblDueDate.Caption = "Due Date:"
        END IF

        ' Display contents of BigRec.Inventory (current record) on the form.
        frmBookStock.txtTitle.Text = RTRIM$(BigRec.Inventory.Title)
        frmBookStock.txtAuthor.Text = RTRIM$(BigRec.Inventory.Author)
        frmBookStock.txtPublisher.Text = RTRIM$(BigRec.Inventory.Publisher)
        IF BigRec.Inventory.Price = -1 THEN
            frmBookStock.txtPrice.Text = ""
        ELSE
            frmBookStock.txtPrice.Text = LTRIM$(STR$(BigRec.Inventory.Price))
        END IF
        IF BigRec.Inventory.Edition = -1 THEN
            frmBookStock.txtEdition.Text = ""
        ELSE
            frmBookStock.txtEdition.Text = LTRIM$(STR$(BigRec.Inventory.Edition))
        END IF
        IF BigRec.Inventory.IDnum = -1 THEN
            frmBookStock.txtID.Text = ""
        ELSE
            frmBookStock.txtID.Text = LTRIM$(STR$(BigRec.Inventory.IDnum))
        END IF

        BookRecordChanged = FALSE   ' Reset record changed flag.

    ' Display record from CardHolders table on the CardHolders form.
    CASE cCardHoldersTableNum
        ' Check if table contains records.
        IF LOF(cCardHoldersTableNum) > 0 THEN
            ' Get the current record.
            RETRIEVE cCardHoldersTableNum, BigRec.Lendee
        ELSE
            BigRec.Lendee.TheName = ""
            BigRec.Lendee.Street = ""
            BigRec.Lendee.City = ""
            BigRec.Lendee.State = ""
            BigRec.Lendee.Zip = -1
            BigRec.Lendee.CardNum = -1
        END IF

        ' Display contents of BigRec.Lendee (current record) on the form.
        frmCardHolder.txtName.Text = RTRIM$(BigRec.Lendee.TheName)
        frmCardHolder.txtStreet.Text = RTRIM$(BigRec.Lendee.Street)
        frmCardHolder.txtCity.Text = RTRIM$(BigRec.Lendee.City)
        frmCardHolder.txtState.Text = RTRIM$(BigRec.Lendee.State)
        IF BigRec.Lendee.Zip = -1 THEN
            frmCardHolder.txtZip.Text = ""
        ELSE
            frmCardHolder.txtZip.Text = LTRIM$(STR$(BigRec.Lendee.Zip))
        END IF
        IF BigRec.Lendee.CardNum = -1 THEN
            frmCardHolder.txtCardNum.Text = ""
        ELSE
            frmCardHolder.txtCardNum.Text = LTRIM$(STR$(BigRec.Lendee.CardNum))
        END IF

        CardRecordChanged = FALSE   ' Reset record changed flag.
    END SELECT

    EXIT SUB

' Display error handling routine.
DisplayError:
    RESUME NEXT                     ' Ignore errors and continue.
END SUB

' Common Key handling routine.
' Traps up arrow, down arrow, home, and end keys used to
' navigate active ISAM table.  Called from each
' control's individual KeyDown event procedure to
' save code duplication.
'
SUB KeyHandle (KeyCode AS INTEGER)
    SELECT CASE KeyCode
    ' Down arrow key - moves to next record in table.
    CASE 40
        CALL SaveRecord                 ' Save current record if changed.
        MOVENEXT BigRec.TableNum
        IF EOF(BigRec.TableNum) THEN MOVELAST BigRec.TableNum
        CALL DisplayRecord

    ' Up arrow key - moves to previous record in table.
    CASE 38
        CALL SaveRecord                 ' Save current record if changed.
        MOVEPREVIOUS BigRec.TableNum
        IF BOF(BigRec.TableNum) THEN MOVEFIRST BigRec.TableNum
        CALL DisplayRecord

    ' End key - moves to last record in table.
    CASE 35
        CALL SaveRecord                 ' Save current record if changed.
        MOVELAST BigRec.TableNum
        CALL DisplayRecord

    ' Home key - moves to first record in table.
    CASE 36
        CALL SaveRecord                 ' Save current record if changed.
        MOVEFIRST BigRec.TableNum
        CALL DisplayRecord
    END SELECT
END SUB

' ISAM file opening/creation routine.
' Attempts to open sample ISAM file 'BOOKS.MDB'.  If
' open fails or file does not exist, a new file is
' created.
'
SUB OpenFile ()
    ' Setup error handling for ISAM file open errors.
    ON LOCAL ERROR GOTO OpenError

    ' Clear screen.
    CLS

    ' Open sample ISAM file if it exists.
    IF DIR$("BOOKS.MDB") <> "" THEN
        OPEN "BOOKS.MDB" FOR ISAM Books "BookStock" AS cBookStockTableNum
        OPEN "BOOKS.MDB" FOR ISAM Borrowers "CardHolders" AS cCardHoldersTableNum
        OPEN "BOOKS.MDB" FOR ISAM BookStatus "BooksOut" AS cBooksOutTableNum

    ' Create a new file if sample can't be found.
    ' Note, this will always occur the first time this
    ' program is run since no sample file is shipped.
    ELSE
        LOCATE 3, 10
        PRINT "Sample ISAM file 'BOOKS.MDB' not found in "
        LOCATE 4, 10
        PRINT CURDIR$ + ".  Creating new 'BOOKS.MDB'.  Please wait..."

        ' Create new BOOKS.MDB sample file.
        OPEN "BOOKS.MDB" FOR ISAM Books "BookStock" AS cBookStockTableNum
        OPEN "BOOKS.MDB" FOR ISAM Borrowers "CardHolders" AS cCardHoldersTableNum
        OPEN "BOOKS.MDB" FOR ISAM BookStatus "BooksOut" AS cBooksOutTableNum

        ' Create table indexes.
        CREATEINDEX cBookStockTableNum, "TitleIndexBS", 0, "Title"
        CREATEINDEX cBookStockTableNum, "AuthorIndexBS", 0, "Author"
        CREATEINDEX cBookStockTableNum, "PubIndexBS", 0, "Publisher"
        CREATEINDEX cBookStockTableNum, "IDIndex", 1, "IDnum"     ' Note unique index
        CREATEINDEX cBookStockTableNum, "BigIndex", 0, "Title", "Author", "IDnum"
        CREATEINDEX cBooksOutTableNum, "IDIndexBO", 0, "IDnum"
        CREATEINDEX cBooksOutTableNum, "CardNumIndexBO", 0, "CardNum"
        CREATEINDEX cCardHoldersTableNum, "NameIndexCH", 0, "TheName"
        CREATEINDEX cCardHoldersTableNum, "StateIndexCH", 0, "State"
        CREATEINDEX cCardHoldersTableNum, "ZipIndexCH", 0, "Zip"
        CREATEINDEX cCardHoldersTableNum, "CardNumIndexCH", 1, "CardNum"  ' Unique index

        READ count%
        FOR i% = 1 TO count%
            READ BigRec.Lendee.TheName, BigRec.Lendee.Street, BigRec.Lendee.City, BigRec.Lendee.State, BigRec.Lendee.Zip, BigRec.Lendee.CardNum
            INSERT cCardHoldersTableNum, BigRec.Lendee
        NEXT i%
        READ count%
        FOR i% = 1 TO count%
            READ BigRec.Inventory.Title, BigRec.Inventory.Author, BigRec.Inventory.Publisher, BigRec.Inventory.Price, BigRec.Inventory.Edition, BigRec.Inventory.IDnum
            INSERT cBookStockTableNum, BigRec.Inventory
        NEXT i%
        READ count%
        FOR i% = 1 TO count%
            READ BigRec.OutBooks.CardNum, BigRec.OutBooks.IDnum, BigRec.OutBooks.DueDate
            INSERT cBooksOutTableNum, BigRec.OutBooks
        NEXT i%
    END IF

    EXIT SUB

' File open error handling routine.
OpenError:
    SELECT CASE ERR
    ' Correct ISAM support not loaded.
    CASE 73:
        LOCATE 6, 10
        PRINT "ISAM support not available.  Exit and load PROISAMD.EXE."
        END

    ' General handling for all other errors.
    CASE ELSE
        LOCATE 6, 10
        PRINT "Error: " + ERROR$ + "."
        LOCATE 7, 10
        PRINT "Please correct the problem then restart the program."
        LOCATE 8, 10
        PRINT "To create a new sample ISAM file, delete 'BOOKS.MDB' from"
        LOCATE 9, 10
        PRINT CURDIR$ + " then restart the program."

        END
    END SELECT
END SUB

' Record update routine.
' Checks for changes to current record and prompts
' user to save them.
'
SUB SaveRecord ()
    ' Setup error handling for save errors.
    ON LOCAL ERROR GOTO SaveError

    ' Save changes to BookStock record only if record
    ' changed and active table is BookStock table.
    IF BookRecordChanged AND BigRec.TableNum = cBookStockTableNum THEN
        ' Prompt to save changes.
        x% = MSGBOX("Save updated record?", 4, frmBooklook.Caption)

        ' Get changed values from textboxes and update record.
        IF x% = 6 THEN
            BigRec.Inventory.Author = frmBookStock.txtAuthor.Text
            BigRec.Inventory.Edition = VAL(frmBookStock.txtEdition.Text)
            BigRec.Inventory.IDnum = VAL(frmBookStock.txtID.Text)
            BigRec.Inventory.Price = VAL(frmBookStock.txtPrice.Text)
            BigRec.Inventory.Publisher = frmBookStock.txtPublisher.Text
            BigRec.Inventory.Title = frmBookStock.txtTitle.Text
            UPDATE BigRec.TableNum, BigRec.Inventory
        END IF

        BookRecordChanged = FALSE       ' Reset record changed flag.

    ' Save changes to CardHolders record only if record
    ' changed and active table is CardHolders table.
    ELSEIF CardRecordChanged AND BigRec.TableNum = cCardHoldersTableNum THEN
        ' Prompt to save changes.
        x% = MSGBOX("Save updated record?", 4, frmBooklook.Caption)

        ' Get changed values from textboxes and update record.
        IF x% = 6 THEN
            BigRec.Lendee.TheName = frmCardHolder.txtName.Text
            BigRec.Lendee.Street = frmCardHolder.txtStreet.Text
            BigRec.Lendee.City = frmCardHolder.txtCity.Text
            BigRec.Lendee.State = frmCardHolder.txtState.Text
            BigRec.Lendee.Zip = VAL(frmCardHolder.txtZip.Text)
            BigRec.Lendee.CardNum = VAL(frmCardHolder.txtCardNum.Text)
            UPDATE cCardHoldersTableNum, BigRec.Lendee
        END IF

        CardRecordChanged = FALSE           ' Reset record changed flag.
    END IF

    EXIT SUB

' Save error handling routine.
SaveError:
    SELECT CASE ERR
    CASE 86                             ' Duplicate index
        MSGBOX ERROR$, 0, frmBooklook.Caption
        EXIT SUB
    CASE ELSE                           ' Ignore other errors and continue.
        RESUME NEXT
    END SELECT
END SUB

