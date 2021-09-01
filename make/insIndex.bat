set makedir=%~dp0
set htmldir=%makedir:\make=%

set dirHomepage=D:\homepage
if "%COMPUTERNAME%" == "DESKTOP-7QG32IQ"  set dirHomepage=C:\Users\ATHUSHI\homepage

copy %dirHomepage%\index.html	%htmldir%\make\old_index.html

copy %htmldir%\tmp_edit.html temp_index.html

set PERL5LIB=%~dp0
perl insIndex.pl old_index.html temp_index.html
del  temp_index.html

