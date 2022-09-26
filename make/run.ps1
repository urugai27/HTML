date
python	ImgSize.py
python	reSize.py
set PERL5LIB=%~dp0
perl PastCheck.pl	old_index.html
perl link.pl		RefLink.cpp link_index.html

