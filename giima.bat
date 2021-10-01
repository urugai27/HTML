set htmldir=%~dp0
echo %htmldir%
set myDocDir=E:\Urugai27\public

set PERL5LIB=%~dp0
perlGiima.pl def_mayaa_index.html tmp_edit.html

del /q %myDocDir%\image\*.*
del /q %myDocDir%\link\*.*
del /q %myDocDir%\Reimage\*.*

xcopy /e /d %htmldir%\image      %myDocDir%\image
xcopy /e /d %htmldir%\link       %myDocDir%\link
xcopy /e /d %htmldir%\Reimage    %myDocDir%\Reimage
xcopy /y /d %htmldir%\index.html %myDocDir%\index.html

xcopy /e /d %htmldir%\audio      %myDocDir%\audio


