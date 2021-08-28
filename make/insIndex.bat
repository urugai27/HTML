copy C:\Users\ATHUSHI\homepage\index.html	C:\Users\ATHUSHI\Desktop\HTML\make\old_index.html
copy C:\Users\ATHUSHI\Desktop\html\tmp_edit.html temp_index.html

set PERL5LIB=C:\Users\ATHUSHI\Desktop\html\make
perl insIndex.pl old_index.html temp_index.html
del  temp_index.html

