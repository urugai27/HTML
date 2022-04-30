作成 2022.04.28

1.過去ログ対象の元ネタをフォルダー内に取り込む

		1pastmake.bat
		
2.過去ログ対象になる日付をパラメタに与え、切り離しを行う

		2pastinc.bat				

	→	"<a name=""label20211217"
	
3.新しい LogPast.html を作成する(makelog_otdd.cpp)	

		3makeLog.bat
		
4.新しい index.html を作成する		
		
		4makeindex.bat

5.新しい past@@.html を作成する		

		5makePast.bat
		
6.置換対象フォルダへコピーする

		copy %htmldir%\pastmake\makePast_otdd.cpp	%htmldir%\pastmake\new\past13.html
		↑\new\past13.html を新しいpastへ変更する

		6RepCopy.bat						

7. 本番環境 Homepage へ手作業で反映させる

		new フォルダ(index.html,LogPast.html,past13.html)

#------------------------------( リンク先の戻る index.html  → past13.html へ変換する  )------------------------------#

A.homepageフォルダは以下のlink ディレクトリ情報を抽出する

		フォルダRepLink 置換されたlink を空にするか都度判断（通常は空にする)
		
		ALinkInfo.bat
		
		
B.homepageフォルダは以下のlink ディレクトリ情報を抽出する

		perl LinkInc.pl	 pastinc_History.cpp  dir_Link.cpp  LinkInc_otdd.cpp
						↑変換対象範囲を確認すること！
		
		BLinkInc.bat

C.Linkのファイルを置換する

		CLinkRep.bat
		
D.     置換対象フォルダへ入れ替える（手作業）

		RepLinkフォルダを吸い上げて、\homepage\link（本番） へ置き換える

