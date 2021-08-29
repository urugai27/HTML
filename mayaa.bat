set htmldir=%~dp0
echo %htmldir%
set myDocDir=%USERPROFILE%\Documents

set PERL5LIB=%~dp0
perl mayaa.pl def_mayaa_index.html tmp_edit.html

del /q %myDocDir%\urugai04.bitbucket.io\image\*.*
del /q %myDocDir%\urugai04.bitbucket.io\link\*.*
del /q %myDocDir%\urugai04.bitbucket.io\Reimage\*.*

xcopy /e /d %htmldir%\image      %myDocDir%\urugai04.bitbucket.io\image
xcopy /e /d %htmldir%\link       %myDocDir%\urugai04.bitbucket.io\link
xcopy /e /d %htmldir%\Reimage    %myDocDir%\urugai04.bitbucket.io\Reimage
xcopy /y /d %htmldir%\index.html %myDocDir%\urugai04.bitbucket.io\index.html

xcopy /e /d %htmldir%\audio      %myDocDir%\urugai04.bitbucket.io\audio


