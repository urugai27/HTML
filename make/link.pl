# 2025.01.09  画面のデータのサイズが500KB以下の小さいサイズは縮小しない
# 2021.09.29  イメージファイルの格納アドレスを絶対アドレスからカレントディレクトリへ変更
# 2021.03.26  画面のサイズ情報を追加する
use strict;
use warnings;
use utf8;

use Cwd;	#	2021.08.29 カレントディレクトリの取得	
	my $wd = Cwd::getcwd();
	print $wd, "\n";
	my $htmldir = $wd;
	$htmldir =~ s/make//;

use Encode; 

binmode STDIN,  ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';
	if (@ARGV != 2){ die "引数を2つ指定して下さい\n"};
  	my $infile = $ARGV[0];
  	my $otfile = $ARGV[1];

	my $true	 = "1";
	my $false	 = "0";	

	print "入力ファイル=$infile, 出力ファイル=$otfile\n";
	open(INDD,"<",$infile) or die("error :$!");
#2021.03.12	絶対アドレスに変更する;	
#	$otfile	=	"C:\\Users\\ATHUSHI\\Desktop\\html\\".$otfile;	
#2021.08.29	カレントディレクトリをベースにしたアドレスに変更する;	
	$otfile	=	$htmldir.$otfile;	
	print	$otfile,"\n";
	open(OTDD,">",$otfile) or die("error :$!");
	

	my	$f_in_end	= $false;
	my	$line		= "";
	my	$tmp_line	= "";
	my	$picture;
	my	$form;
	my  $stitle;
	my 	$comment;
# 2021.03.26  画面のサイズ情報を追加する
	my  $wsize;
	my 	$hsize;
	my	$a;
	my	$b;
	my	$d;
	my	$f;
# 2025.01.08  画面のデータサイズ情報を追加する
	my	$g;

	my	$f_defin_end	= $false;
	my	$defline	= "";


	my	$linkdd	=	"";
	my	$hizuke	=	"";

	&read_rtn();
#2021.03.17 add
	print OTDD	"<br>\n";

	while( $f_in_end	==	$false){

# 2021.03.26  画面のサイズ情報を追加する
#		($picture, $form, $stitle, $comment ) = split(/,/, $line );
#		print $picture,",", $form,",", $stitle,",", $comment,"\n";
#		print $picture,",", $form,",", $stitle,",", $comment,"\n";
# 2025.01.08  画面のデータサイズ情報を追加する
#		($picture, $form, $stitle, $comment ,$a, $b, $wsize, $d, $f, $hsize) = split(/,/, $line );
		($picture, $form, $stitle, $comment ,$a, $b, $wsize, $d, $f, $hsize, $g) = split(/,/, $line );
		print $picture,",", $form,",", $stitle,",", $comment,",",$wsize,",",$hsize,"\n";

		&link_write_rtn();

		&write_rtn();
#
		&read_rtn();
	}	

	close	INDD;
	close	OTDD;

sub read_rtn{
	if(!eof INDD){
		$line = <INDD>;
		
		chomp	$line;
		$line =   decode('utf8', $line);  
#UTF-8 ファイルの BOM を取り除く正規表現	2021.03.01 
		$line =~ s/^\x{FEFF}//;	
			
#		print "read \n";
	}else{
# 		print "read owari \n";
		$f_in_end	= $true;
	}
}
sub write_rtn{
		my	$def_href1	= "<a href=\"./link/picture.html\"  target=\"_blank\">  \n";
#2021.03.26  自動設定に変更する
#		my	$def_href2	= "<img src=\"./Reimage/picture.JPG\" alt=\"＃メモ\" width=\"75\" height=\"100\" border=\"0\" />\n";
		my	$def_href2	= "<img src=\"./Reimage/picture.JPG\" alt=\"＃メモ\" width=\"";
			$def_href2  = $def_href2.$wsize;
			$def_href2  = $def_href2."\" height=\"100\" border=\"0\" />\n";
		my	$def_href3	= "</a>\n";

		$def_href1	=~ s/picture/$picture/;
		$def_href2	=~ s/picture/$picture/;
		$def_href2	=~ s/＃メモ/$stitle/;
#2021.03.26  自動設定に変更する
#		if($form	eq	"ps"){					#横長の場合
#			$def_href2	=~ s/width="75/width="133/;
#		}	
		
		$def_href1 =   encode('utf8', $def_href1); 
		print OTDD	$def_href1;
		$def_href2 =   encode('utf8', $def_href2); 
		print OTDD	$def_href2;
		print OTDD	$def_href3;
}
sub link_write_rtn{
	
#		$linkdd	=	$picture.".html";	
#2021.03.12	絶対アドレスに変更する;	
#		$linkdd	=	"C:\\Users\\ATHUSHI\\Desktop\\html\\link\\".$picture.".html";	
#2021.08.29	カレントディレクトリをベースにしたアドレスに変更する;	
		$linkdd	=	$htmldir."\\link\\".$picture.".html";

	open(LINKDD,">",$linkdd) or die("error :$!");

		$hizuke	=	substr($picture,0,8);
		
		$f_defin_end	= $false;
		$defline	= "";
		
		open(DEFDD,"<","DEF_LINK_pv.html") or die("error :$!");

			

		&def_read_rtn();

	while( $f_defin_end	==	$false){
#<img src="../image/＃ＰＩＣＴＵＲＥ.JPG"  alt="＃コメント"  width="720" height="540" border="0" />
#2021.03.26  自動設定に変更する
#		if($form	eq	"pv"){			#縦長の場合
#			$defline	=~ s/height="540/height="960/;
#		}	
		$defline	=~ s/height="540/height="$hsize/;

		$defline	=~ s/＃ＰＩＣＴＵＲＥ/$picture/;
		$defline	=~ s/＃コメント/$comment/;
		$defline	=~ s/＃ＤＡＴＥ/$hizuke/;


		$defline =   encode('utf8', $defline); 
		print LINKDD	$defline;
#
		&def_read_rtn();
	}	


	close	DEFDD

}
sub def_read_rtn{

	if(!eof DEFDD){
		$defline = <DEFDD>;
#ng		chomp	=	$defline;	
		$defline =   decode('utf8', $defline);  
#UTF-8 ファイルの BOM を取り除く正規表現	2021.03.01 
		$defline =~ s/^\x{FEFF}//;		
#		print "read \n";
	}else{
# 		print "read owari \n";
		$f_defin_end	= $true;
	}
}
