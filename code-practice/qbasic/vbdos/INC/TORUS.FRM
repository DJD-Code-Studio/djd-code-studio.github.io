�  ��	 
   L   ��    �)   �    5    �      �E 
 �       �  	  �a 
 	       �   @�� 
           �    �� 
               	  �� 
 (           �� 
 *          ,     @�
 3          �  	  �
 G        5  	  �?
 I          K    
 @�_
 R          �  	  �{
 g     	  T    ��
 i    + 
     k     @��
 r    1      �  	  ��
 �       t    ��
 �    +      �     @�
 �    1      �    �7
 �       �    �^
 �    +                 	  �z
 �       �  	  ��
 �    (
   �    ��
 �       �  	  �  
 �       �   Torus Graphics Example   &Make The Torus!   &Thickness:       Text1 &Panels/Section:     Text1   &Sections/Torus:     Text1   &Horizontal Tilt:     Text1   &Vertical Tilt:     Text1   &Bordered Tiles     S&creen Mode:       E&xit      � frmTorus�CmdTorus�	lblThickCaption vscThicktxtThick	lblPanelCaption+txtPanel7vscPanelL	lblSectionCaptionZ
txtSectionh
vscSection}	lblXDegreeCaption�
txtXDegree�
vscXDegree�	lblYDegreeCaption�
txtYDegree�
vscYDegree�chkBord�cboScrn�	lblScrnCaption�	lblCalcCmdExit  	
lblCalcMsg          P��$ ���x   �   � V   �� � ��  �� �    � 0�c �  � u      �n �                   �  �  	GetConfig   TorMain^ KEY_UP- KEY_DOWN 	THICK_MIN 	THICK_MAX  
THICK_INIT   	PANEL_MINN 	PANEL_MAX? 
PANEL_INITY SECTION_MIN� SECTION_MAXj SECTION_INIT XDEGREE_MIN XDEGREE_MAX   XDEGREE_INIT� YDEGREE_MIN� YDEGREE_MAX! YDEGREE_INIT� BORD_YESG BORD_NO� 	BORD_INIT� Cmdexit_Click frmTorus cmdTorus_Click   	Form_Load9 top  screen0 height   left   width   vscThick   Min� Max   value   txtThick   Textc vscPanelU txtPanel� 
vscSection� 
txtSectionq 
vscXDegree 
txtXDegreel 
vscYDegree   
txtYDegree� chkBord� txtPanel_KeyDown   KeyCode   Shift  PanelNoChange� txtSection_KeyDown  SectionNoChange txtThick_KeyDown  NoChangeC txtXDegree_KeyDown  XDegreeNoChange   txtYDegree_KeyDown  YDegreeNoChange vscPanel_Change� vscSection_Change� vscThick_Change� vscXDegree_Change   vscYDegree_Change  �     H-  � 1    Visual Basic for MS-DOS Torus Graphics Program-  �      � 4    Graphics program that demonstrates using graphics  � 9    with forms.  Form-based interface provides information-  � '    for creating a graphic Torus figure.o  �      � 0    Copyright (C) 1982-1992 Microsoft Corporation  �      � :    You have a royalty-free right to use, modify, reproduce  � D    and distribute the sample applications and toolkits provided with  � 8    Visual Basic for MS-DOS (and/or any modified version)  � ;    in any way you find useful, provided that you agree thati  � :    Microsoft has no warranty, obligations or liability for  � .    any of the sample applications or toolkits.  �     H-    D  V      D  c        �     Constants for key trapping-  # e&  n   # e(  x     �     Constants for Torus limits-  # d �   # d% �   # d �     # d �   # e  �   # d! �     # d �   # e  �   # e  �     # d   # eh   # e<       # d 0  # eh ?  # e�  N    # d ^  # d j  #  ^ u  	  ��������1       Cmdexit_Click 0z   � 1    Click event procedure for Exit command button.-  �     Unloads form to end program.i  v  �     ��  Q 	  ��������   ��   cmdTorus_Click 0�   � 2    Click event procedure for Torus command button.  � .    Invokes torus creation and display routine.  v  �    7   c   Q 	  ��������   ��  	 Form_Load 0  � !    Load event procedure for form.p  � +    Gets video configuration and initializesn  �      textbox and scrollbar values.  v  �    8   V     � � �wnd	` �  � � �wnd	` �    �  � �  �  � �  �  �   � �      �  ! �  �  ! �  �  !   � � -     �  9 �  �  9 �  �  9   � � G      U �   U �    U    � c     0 q �  ? q �  N q   N�      u �   Q 	  ��������$   ��   txtPanel_KeyDown 0z  � '    Keydown event procedure for textbox.  � 4    Traps up arrow and down arrow keys to increase or  �     decrease current value.  v  �  �     �        � @   error means value is out of range of scrollbar, so do nothing ��    �t �� � 	   Key Upm  n ;     ! d  !  �    Key Down  x ;     ! dw !  R    ��� U ��  Q 	  h������   ��   txtSection_KeyDown 0z  � '    Keydown event procedure for textbox.   � 4    Traps up arrow and down arrow keys to increase or  �     decrease current value.  v  �  �     �        � @   error means value is out of range of scrollbar, so do nothing ��    �t �� � 	   Key Upm  n ;     9 d  9  �    Key Down  x ;     9 dw 9  R    ��� U ��  Q 	  h������   ��   txtThick_KeyDown 0z  � '    Keydown event procedure for textbox.   � 4    Traps up arrow and down arrow keys to increase or  �     decrease current value.  v  �  �     �        � @   error means value is out of range of scrollbar, so do nothing �    �t �� � 	   Key Upm  n ;     � d  �  �    Key Down  x ;     � dw �  R    �� U ��  Q 	  h������   ��   txtXDegree_KeyDown 0z  � '    Keydown event procedure for textbox.   � 4    Traps up arrow and down arrow keys to increase or  �     decrease current value.  v    �     �        � @   error means value is out of range of scrollbar, so do nothing �0    �t �� � 	   Key Upm  n ;     U d  U  �    Key Down  x ;     U dw U  R    ��0 U ��  Q 	  h������   ��   txtYDegree_KeyDown 0z  � '    Keydown event procedure for textbox.   � 4    Traps up arrow and down arrow keys to increase or  �     decrease current value.  v  C  �     �        � @   error means value is out of range of scrollbar, so do nothing �Y    �t �� � 	   Key Upm  n ;     q d  q  �    Key Down  x ;     q dw q  R    ��Y U ��  Q 	  h������   ��   vscPanel_Change 0�   � (    Change event procedure for scrollbar.  � 1    Sets textbox value to current scrollbar value.,  v  l     ! � -   Q 	  ��������   ��   vscSection_Change 0�   � (    Change event procedure for scrollbar.  � 1    Sets textbox value to current scrollbar value.,  v       9 � G   Q 	  ��������   ��   vscThick_Change 0�   � (    Change event procedure for scrollbar.  � 1    Sets textbox value to current scrollbar value.,  v  �     � �    Q 	  ��������   ��   vscXDegree_Change 0�   � (    Change event procedure for scrollbar.  � 1    Sets textbox value to current scrollbar value.,  v  �     U � c   Q 	  ��������   ��   vscYDegree_Change 0�   � (    Change event procedure for scrollbar.  � 1    Sets textbox value to current scrollbar value.,  v  �     q �    Q 	  ��������   �� 