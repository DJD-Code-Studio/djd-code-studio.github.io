' Procedure declarations for SDI NotePad program.
'
DECLARE SUB mnuFileNew_Click ()
DECLARE SUB mnuFileSave_Click ()
DECLARE SUB mnuFileSaveAs_Click ()
DECLARE SUB AddFileToMenu ()
DECLARE FUNCTION OpenFile (QualifiedName AS STRING) AS INTEGER
DECLARE FUNCTION SaveChanges () AS INTEGER
DECLARE SUB mnuSearchFind_Click ()
DECLARE SUB SetWordWrap ()

