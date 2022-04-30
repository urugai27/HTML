set makedir=%~dp0
set htmldir=%makedir:\pastmake=%

copy %htmldir%\pastmake\makeindex_otdd.cpp	%htmldir%\pastmake\new\index.html

copy %htmldir%\pastmake\makelog_otdd.cpp	%htmldir%\pastmake\new\LogPast.html

copy %htmldir%\pastmake\makePast_otdd.cpp	%htmldir%\pastmake\new\past14.html


