�  ��	 
�  4!  I�     �)   �     
;   �     	  �E 
     5   �     �g 
 	    (           	  �� 
         	  � 
 &         	  � 
 1    	   (   �� 
 >       3    �  
 G       @   Path  
 lblMessage       Destination:   inDrive   outPath  	 &Continue   E&xit  T frmPathb	
LblMessagemTxtPathz		LblPrompt�	
LblinDrive�	
LbloutPath�CmdConTinue  CmdExitPP��$ ��"  � �   q � �     e   � �           V                   �                       "  �  IsValidPath   DestPath�  DefaultDrive�  CmdContinue_Click   temp   txtPath Text�  
LblinDrive   tag   
LblOutPath   
LblMessage   frmPath   caption   selStart   	selLength   cmdExit_Click�  �     H-  � (    Visual Basic for MS-DOS Setup Toolkit  �      � #    SETUPPTH.FRM - Setup paths form.o  �      � .    Refer to module-level comments in SETUP.BAS  � 0    for more information about the Setup Toolkit.  �      � 3    The default Visual Basic library (VBDOS.LIB) and-  � 3    Quick library (VBDOS.QLB) are required to create-  � 7    and run your Setup program.  Use the /L command-line-  � :    switch to use VBDOS.QLB in the programming environment.  �      � 0    Copyright (C) 1982-1992 Microsoft Corporation  �      � :    You have a royalty-free right to use, modify, reproduce  � D    and distribute the sample applications and toolkits provided with  � 8    Visual Basic for MS-DOS (and/or any modified version)  � ;    in any way you find useful, provided that you agree thati  � :    Microsoft has no warranty, obligations or liability for  � .    any of the sample applications or toolkits.  �     H-    �    D  V � e     q       	  ��������       CmdContinue_Click 0�  � *    Click event for Continue command button  � &    Set status flag and hide Path form.  v  �     }���    � 2   Determine if path is valid and change format to �    match "X:\dir\dir\dir\"  �  � �  �  �  � n  V a     �  �  �   m continue �  �    � ��  I ��  m Invalid path: �  d �  � �   � ��   d �  �    �  � -�� �   P   Q 	  ��������   ��   cmdExit_Click 0�   � &    Click event for Exit command button  � &    Set status flag and hide Path form.  v      m exit �  �   � ��   Q 	  ��������   �� 