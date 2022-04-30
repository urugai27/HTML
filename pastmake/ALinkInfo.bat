set makedir=%~dp0
set htmldir=%makedir:\pastmake=%

set dirHomepage=D:\homepage
if "%COMPUTERNAME%" == "DESKTOP-7QG32IQ"  set dirHomepage=C:\Users\ATHUSHI\homepage


WHERE /R %dirHomepage%\link\ *.* /T > %htmldir%\pastmake\dir_Link.cpp





