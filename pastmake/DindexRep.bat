set htmlmakedir=E:\HTML\make
if "%COMPUTERNAME%" == "DESKTOP-7QG32IQ"  set htmlmakedir=C:\Users\ATHUSHI\Desktop\HTML\make


copy %htmlmakedir%\old_index.html  %htmlmakedir%\old_index_pastmake.html

set dirHomepage=D:\homepage
if "%COMPUTERNAME%" == "DESKTOP-7QG32IQ"  set dirHomepage=C:\Users\ATHUSHI\homepage


copy %dirHomepage%\index.html	%htmlmakedir%\old_index.html



