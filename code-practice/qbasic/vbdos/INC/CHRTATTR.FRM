�  ��	 
�  �  C�     �)       
A    �     	  �E 
          
  �e 
                 	  �� 
 %         
  � 
 '                 �� 
 )    (      +     �� 
 7    

   2    �  
 A    
 
   9  	 ChartData Cancel lblItems     lblData       Text1 O&K   Cancel  X frmChrtAttributesd	lblItemsp
lstItems{	lbldata�
lstData�txtTitle�cmdOK  	cmdCancel        ���$ ���� g � �   �   �   g�   1  V       
       � � � �     u J                    �     ChartDataType   
DataNeeded= 	DataIndex   TitleNeeded   Title   ChartDataBlock   saveFile   savePath  	ChartData   FALSE   TRUE cmdCancel_Click   frmChrtAttributes   Tags cmdOK_ClickU lstData_Click   lstItems   	ListIndex   lstData   lstItems_Click{ txtTitle   Text   txtTitle_ChangeR  �     H-  � 0    Visual Basic for MS-DOS Presentation Graphics  �     ToolKit Demo ProgramD  �      � '    CHRTATTR.FRM - Chart attribute form.   �      � 1    Chart demo is a menu-driven, Multiple Document   � 3    Interface (MDI) program that demonstrates how to   � =    use the Presentation Graphics Toolkit to create and modify-  � 9    charts. Refer to module-level comments in CHRTDEMO.FRMd  � 2    for more information about this sample program.  �      � 0    Copyright (C) 1982-1992 Microsoft Corporation  �      � :    You have a royalty-free right to use, modify, reproduce  � D    and distribute the sample applications and toolkits provided with  � 8    Visual Basic for MS-DOS (and/or any modified version)  � ;    in any way you find useful, provided that you agree thati  � :    Microsoft has no warranty, obligations or liability for  � .    any of the sample applications or toolkits.  �     H-      �V   g      u      �      � | @ 
    ��     � �� � �  @ chart file   � � � �  @ chart file   � 2�  V +    �     # d �   #  � t �   	  �������$       cmdCancel_Click 0z   � 7    Hides the form and sets Cancel Tag for return value.-  �      v  �     m Cancel �  
  � ��   Q 	  ��������   ��   cmdOK_Click 0n   � 4    Hides the form and sets OK flag for return value.  �      v      m OK 
  � ��   Q 	  ��������   ��   lstData_Click 0d   � -    Process click on chart attribute list box.   v        J = 1 =  �  u   Q 	  ��������   ��   lstItems_Click 0�   � 2    Process click on chart items list box and store  � 0    corresponding information in ChartData array.  v  U     1 =  �  g a �    1 =  �  u  J = I �    1 =  �  �  g s P   Q 	  ��������	   ��   txtTitle_Change 0h   � 2    Process changes in text field for chart titles.  v  {     g s 1 =  �  �   Q 	  ��������   �� 