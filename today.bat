set makedir=%~dp0
set htmldir=%makedir:\make=%
echo %htmldir%
cd "%USERPROFILE%\My Documents"
set myDocDir=%USERPROFILE%\Documents

set PERL5LIB=%~dp0
perl today.pl def_HTML5_index.html tmp_edit.html 

xcopy /e /d %htmldir%\image      %myDocDir%\urugai27.github.io\image
xcopy /e /d %htmldir%\link       %myDocDir%\urugai27.github.io\link
xcopy /e /d %htmldir%\Reimage    %myDocDir%\urugai27.github.io\Reimage
xcopy /y /d %htmldir%\index.html %myDocDir%\urugai27.github.io\index.html

xcopy /e /d %htmldir%\audio      %myDocDir%\urugai27.github.io\audio

