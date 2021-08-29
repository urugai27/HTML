set makedir=%~dp0
set htmldir=%makedir:\make=%
echo %htmldir%
copy %htmldir%\tmp_edit.html tmp_edit.html
copy %htmldir%\link_index.html link_index.html

set PERL5LIB=%~dp0
perl inslink.pl tmp_edit.html link_index.html
copy temp_index.html %htmldir%\tmp_edit.html
del tmp_edit.html
del link_index.html
del temp_index.html
