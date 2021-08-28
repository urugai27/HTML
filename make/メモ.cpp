手順

1.コンテンツ

①TEXT.CPP にネタを張り付ける
②html.bat を実行
③画面での動作確認
	Htmltest.exe - Web確認 でvb studioプログラムを起動	

2.画像がある場合

①画像を設定する
	例	1Misaki.JPG

②前回までのhomepageディレクトリ内の圧縮画像の資産を削除
	delImg.bat

③homepageディレクトリ内の圧縮画像を作成する

	ImgSize.bat
	reSize.bat
	
④RefLink.cpp を編集する	
	バージョンアップ	imgread.bat で元ネタtmp_RefLink.cppを作成する 
	例
	20210317_1Misaki,ps,岬１,久高島がみえる
	20210317_2Misaki,ps,岬２,展望台に観光客がいる

⑤リンクhtmlを作成する
	Link.bat
	例
	\link\20210317_1Misaki.html
	\link_index.html
	
⑥コンテンツにリンを反映させる
	inslink.bat

⑦画面での動作確認
	Htmltest.exe - Web確認 でvb studioプログラムを起動	


リンク入力データ:RefLink.cpp は ＭＳゴシック 12ポで編集を行う
	pv:縦 Vertical
	ps:横 side

入力データ:TEXT.cpp は ＭＳゴシック 12ポで編集を行う

一行の幅は 

<div style="max-width:590px"> or width:50em   1em:16px らしい

全角文字：３６文字、半角 58文字	 半角一文字は,0.62の全角（全角の半分でない！）

①綺麗に右端を揃えるには、半角を全角に変えたほうがいい
②やもえず、半角にする場合は0.62倍の比率を考慮する


Perl - 全角カナ⇔半角カナ 変換のサンプル
http://ski2011.cocolog-nifty.com/blog/2012/05/perl---20cb.html

