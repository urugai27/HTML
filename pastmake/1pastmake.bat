set makedir=%~dp0
set htmldir=%makedir:\pastmake=%

set dirHomepage=D:\homepage
if "%COMPUTERNAME%" == "DESKTOP-7QG32IQ"  set dirHomepage=C:\Users\ATHUSHI\homepage

copy %dirHomepage%\index.html	%htmldir%\pastmake\old_index.html

copy %dirHomepage%\LogPast.html %htmldir%\pastmake\old_LogPast.html


