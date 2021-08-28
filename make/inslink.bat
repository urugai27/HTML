copy C:\Users\ATHUSHI\Desktop\html\tmp_edit.html tmp_edit.html
copy C:\Users\ATHUSHI\Desktop\html\link_index.html link_index.html

set PERL5LIB=C:\Users\ATHUSHI\Desktop\html\make
perl inslink.pl tmp_edit.html link_index.html
copy temp_index.html C:\Users\ATHUSHI\Desktop\html\tmp_edit.html
del	tmp_edit.html
del	link_index.html
del	temp_index.html
