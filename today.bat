set htmldir=%~dp0
echo %htmldir%
set myDocDir=%USERPROFILE%\Documents

set PERL5LIB=%~dp0
perl today.pl def_HTML5_index.html tmp_edit.html 

del %myDocDir%\urugai27.github.io\image\*.*
del %myDocDir%\urugai27.github.io\link\*.*
del %myDocDir%\urugai27.github.io\Reimage\*.*

xcopy /e /d %htmldir%\image      %myDocDir%\urugai27.github.io\image
xcopy /e /d %htmldir%\link       %myDocDir%\urugai27.github.io\link
xcopy /e /d %htmldir%\Reimage    %myDocDir%\urugai27.github.io\Reimage
xcopy /y /d %htmldir%\index.html %myDocDir%\urugai27.github.io\index.html

xcopy /e /d %htmldir%\audio      %myDocDir%\urugai27.github.io\audio

