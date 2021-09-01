# 2021.09.01  link情報より link_index.html を作成する
use strict;
use warnings;
use utf8;


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

	my	$f_defin_end	= $false;
	my	$defline	= "";


	my	$linkdd	=	"";
	my	$hizuke	=	"";

	&read_rtn();
#2021.03.17 add
	print OTDD	"<br>\n";

	while( $f_in_end	==	$false){

		($picture, $form, $stitle, $comment ,$a, $b, $wsize, $d, $f, $hsize) = split(/,/, $line );
		print $picture,",", $form,",", $stitle,",", $comment,",",$wsize,",",$hsize,"\n";

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
		my	$def_href2	= "<img src=\"./Reimage/picture.JPG\" alt=\"＃メモ\" width=\"";
			$def_href2  = $def_href2.$wsize;
			$def_href2  = $def_href2."\" height=\"100\" border=\"0\" />\n";
		my	$def_href3	= "</a>\n";

		$def_href1	=~ s/picture/$picture/;
		$def_href2	=~ s/picture/$picture/;
		$def_href2	=~ s/＃メモ/$stitle/;
		
		$def_href1 =   encode('utf8', $def_href1); 
		print OTDD	$def_href1;
		$def_href2 =   encode('utf8', $def_href2); 
		print OTDD	$def_href2;
		print OTDD	$def_href3;
}
