html の自動化

2021.08.28   PC2 とHTML　を共有化するため Github へ登録を増やす

	20210828_back.gitignore	に修正前を退避

2021.03.12 
作業は make ホルダで行う（検証作業のため、Homepageと同じフォルダ構成にする）

1.テキストの場合
	
	①TEXT.cpp に内容を編集する
	②html.bat を実行
	
２.写真がある場合
	
	
2021.06.16	hmlt5へ見直す

FONT の廃止

<br>2021年06月13日 (日）<FONT color="red">楽譜が読めない</FONT>
<br>2021年06月13日 (日）<span style="color:red">楽譜が読めない</span>
インライン要素であれば、文章中に入っていても
<br>2021年06月13日 (日）<span class="today_title">楽譜が読めない</span>
.today_title {
    color:red
}
<link rel=”stylesheet” href=”css/today.css”><!–リセットcssを先に読み込み–>

<Font Size="5">
<span style="font-size:12px">

<span>とは 「SPAN」とは、単体では特に意味を持たないタグですが、
<span>～</span>で囲った部分をインライン要素としてグループ化することができるタグです。
 グループ化することで、指定した範囲にスタイルシートを適用したりすることができます。
<SPAN STYLE="COLOR : RED">～</SPAN>
<span style="color:red">	

同じページ内にリンクする（旧方式）
https://www.tagindex.com/html_tag/link/a_name.html

