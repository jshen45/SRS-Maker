   M S B A M L   `   `   `  ����  	SRS Maker    SRS_Maker.View.OS_CORE   5      W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      .��5      � .+�5   
   �� $��Tasks��6   $
��Left=�6"   $	��Top=�6=   $
��1000��6U   $��0q�6b   .��5	      � .+�5
      �� 
�������$��1q�61   $
��Left=�6E   $	��Top=�6`   $	��130��6x   $	��400��6�   ._�5      � $��5q�6   .+�5      �� $��Stack��6    $
��Left=�60   $��0q�6K   $	��Top=�6V   �� 5      $��FG1 Task��6    $��0,30,0,0q�63   $
��Left=�6E   $	��Top=�6`   $��9.333(�6x   �� 5      $��FG2 Task��6    $��0,80,0,0q�63   $
��Left=�6E   $	��Top=�6`   $��9.333(�6x   �� 5      $��(Low Power Task)��6    $��	40,82,0,0q�6;   $
��Left=�6N   $	��Top=�6i   $��7(�6�   �� 5      $��Background Task��6    $��	0,130,0,0q�6:   $
��Left=�6M   $	��Top=�6h   $��9.333(�6�   �� 5      $��Event Manager��6    $��	0,180,0,0q�68   $
��Left=�6K   $	��Top=�6f   $��9.333(�6~   �� 5      -   5          ��Name$  TextBox_Stack_FG1��5   "   $��6,50,0,0q�6=   $
��Left=�6O   $	��Top=�6j   $	��100��6�   �� 5      -   5        $  TextBox_Stack_FG2��5   "   $��	5,100,0,0q�6=   $
��Left=�6P   $	��Top=�6k   $	��100��6�   �� 5      -   5        $  TextBox_Stack_Event��5   "   $��	5,150,0,0q�6?   $
��Left=�6R   $	��Top=�6m   $	��100��6�   �� 5      -   5        $  TextBox_Stack_BG��5   "   $��	5,200,0,0q�6<   $
��Left=�6O   $	��Top=�6j   $	��100��6�   5      5      &   System.Windows.Controls.DataGrid  5      -   5          Name$ DataGrid_Task��5      $
��Left=�62   $��	135,0,0,0q�6M   $	��Top=�6`   $	��400��6x   $	��700��6�   $��1q�6�   
�������   AutoGenerateColumns .  ��6�   �� *SwpTaskList+   Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$
 Name��6-      Width5  /System.Windows.Controls.DataGridLengthConverter$	 200 6T   1  +System.Windows.Controls.DataGridBoundColumn   Binding 6;   �� *Name+6T     5      $ Priority��6-   $ 60 6\    6?   �� *
Priority+6\     5      $! Offset (Only Periodic Task)��6-   $ 76 6r    6R   �� *AlarmOffset+6r     5      $  Cycle (Only Periodic Task)��6-   $ 70 6p    6Q   �� *
AlarmCycle+6p   4  .System.Windows.Controls.DataGridCheckBoxColumn  5      $ 
Preemptive��61   $ 40 6d    6E   �� *
Preemptive+6d     5       $ 
Auto Start��61   $ 40 6c    6E   �� *	AutoStart+6c   5"      5#      5$      �� 5%   
   $��Debugging Feature��6   $
��left=�6.   $��	0,444,0,0q�6I   $	��Top=�6\   $
��1000��6t   .��5&      � $��	5,10,5,10q�6   .+�5'      �� -   5         ��Name$ CpuLoad��5'      $��CPU Load��6,   $
��Left=�6?   $��0,0,0,0q�6Z   $	��Top=�6k   �� 5(      -   5        $ ItLoad��5(      $��Interrupt Load��6+   $
��Left=�6D   $��86,0,0,0q�6_   $	��Top=�6q   �� 5)      -   5        $ 
StackDepth��5)      $��Stack Depth��6/   $
��Left=�6E   $��	196,0,0,0q�6`   $	��Top=�6s   �� 5*      -	   5        $ TaskMonitoring��5*      $��Task Monitoring��63   $
��Left=�6M   $��	294,0,0,0q�6h   $	��Top=�6{   5+      5,      �� 5-   
   $��Watchdog Manager��6   $
��Left=�6-   $��0,526,0,-10q�6H   $	��Top=�6]   $
��1000��6u   .��5.      � $��	5,10,5,10q�6   .+�5/      �� -
   5        $ CheckBox_InternalWatchDog��5/      $��Internal Watchdog��6>   $
��Left=�6Z   $��0,0,0,0q�6u   $	��Top=�6�   6�   �� 50      $��Time-Out(ms)��6   $
��Left=�6/   $��
150,-4,0,0q�6J   $	��Top=�6^   �� 51      -   5        $%  TextBox_InternalWatchDogTimeOut��51      $
��Left=�6C   $��23��6^   $��
237,-4,0,0q�6j    �� TextWrapping$
 Wrap=�6~   $	��Top=�6�   $��70��6�   {�.  6�   �� 52      -   5        $ CheckBox_ExternalWatchDog��52      $��External Watchdog��6>   $
��Left=�6Z   $��0,30,0,0q�6u   $	��Top=�6�   6�   �� 53      $��Trigger Pin��6   $
��Left=�6.   $��
309,27,0,0q�6I   $	��Top=�6]   �� 54      $��Time-Out(ms)��6   $
��Left=�6/   $��
150,27,0,0q�6J   $	��Top=�6^   �� 55      -   5        $%  TextBox_ExternalWatchDogTimeOut��55      $
��Left=�6C   $��23��6^   $��
237,27,0,0q�6j   $
 Wrap=�6~   $	��Top=�6�   $��70��6�   {�.  6�   �� 56      -   5        	 ��Name$	 ExternalWatchdogTogglePin��56      $
��Left=�6>   $��
379,27,0,0q�6Y   $	��Top=�6m   $��99��6�   {�.  6�   57      58      5:      5;      