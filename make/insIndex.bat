set makedir=%~dp0
set htmldir=%makedir:\make=%
copy D:\homepage\index.html	%htmldir%\old_index.html
copy %htmldir%\tmp_edit.html temp_index.html

set PERL5LIB=%~dp0
perl insIndex.pl old_index.html temp_index.html
del  temp_index.html

