use strict;
use warnings;
use utf8;

use Encode; 

binmode STDIN,  ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';
	if (@ARGV != 2){ die "引数を2つ指定して下さい\n"};
  	my $infile = $ARGV[0];
  	my $linfile = $ARGV[1];
  	my $otfile = "index.html";

	my $true	 = "1";
	my $false	 = "0";	
#2021.07.02     作成時刻を都度設定する
	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime;


	print "入力マスタファイル=$infile, 入力リンクファイル=$linfile\n";
	open(INMAST,"<",$infile) or die("error :$!");
	open(INLINK,"<",$linfile) or die("error :$!");
	open(OTDD,">",$otfile) or die("error :$!");
	

	my	$f_mast_end	= $false;
	my	$f_link_end	= $false;
	my	$line		= "";
	my	$link		= "";


	&read_mast_rtn();
	&read_link_rtn();

#	タイトルと日付を抽出する
	my	$LABEL_DAY		= "";
	my	$TODAY_TITLE	= "";
	

	until(( $link	=~/^<br>\d{4}年\d{2}月\d{2}日/)			#
		||( $f_link_end	==	$true)){
			&read_link_rtn();
	}	
	if( $link	=~/^<br>(\d{4})年(\d{2})月(\d{2})日/){			#
		$LABEL_DAY	= "$1$2$3";
		print "ある日は",$LABEL_DAY,"\n";
		if( $link	=~/\">(.*)<\/FONT>/){			#
			$TODAY_TITLE = $1;
			print "タイトルは",$TODAY_TITLE,"\n";
		}
	}	
#			一度クローズして再度日付のところまで読み飛ばす	#
	close	INLINK;
	open(INLINK,"<",$linfile) or die("error :$!");
	$f_link_end	= $false;
	$link		= "";
	&read_link_rtn();
	until(( $link	=~/^<br>\d{4}年\d{2}月\d{2}日/)			#
		||( $f_link_end	==	$true)){
			&read_link_rtn();
	}	

	until(( $line	=~/^<\/body>/)			#
		||( $f_mast_end	==	$true)){

		$line	=~ s/＃LABEL_DAY/$LABEL_DAY/;
		$line	=~ s/＃TODAY_TITLE/$TODAY_TITLE/;

		&write_rtn();
		&read_mast_rtn();
	}	
#	ある日のデータを新たに出力する 	#
#	until( $f_link_end	==	$true){
	until(( $link	=~/^<\/body>/)			
		||( $f_link_end	==	$true)){
			$line		= $link;
#HTML5 への変換
			if($line	=~/^<br>(\d{4})年(\d{2})月(\d{2})日/){			#
				$line	=~ s/<FONT color=\"red\">/<span class="today_title">/;
					$line	=~ s/<\/FONT>/<\/span>/;
			}
#	<a name="label20210622"></a>	-> <a name="label20210622"  id="label20210619"></a>

			if($line	=~/<a name=\"label(\d{8})/){			
#				$line	=	"<a name=\"label$1\" id=\"label$1\"></a>\n";		#2021.06.24 
				$line	=	"<a id=\"label$1\"></a>\n";
			}
#2021.06.25 外部リンク　font 設定を css へ　変更
			$line	=~ s/<FONT color=\"magenta\">/<span class="External_link">/;
			$line	=~ s/<\/FONT>/<\/span>/;
#<-			
#編集時刻を置き換える	<br>16:15
			if($line	=~/^<br>(\d{2}):(\d{2})$/){			#
					printf OTDD "<br>%02d:%02d\n",$hour,$min;
			}else{
				&write_rtn();	
			}
#<-			
			&read_link_rtn();
	}	

	$line	=	"</body>\n";

	until( $f_mast_end	==	$true){

		&write_rtn();
#
		&read_mast_rtn();
	}	

	close	INMAST;
	close	INLINK;
	close	OTDD;

sub read_mast_rtn{
	if(!eof INMAST){
		$line = <INMAST>;
		
#		chomp	$line;
		$line =   decode('utf8', $line);  
			
	}else{
		$f_mast_end	= $true;
	}
}
sub read_link_rtn{
	if(!eof INLINK){
		$link = <INLINK>;
		
#		chomp	$link;
		$link =   decode('utf8', $link);  
			
	}else{
		$f_link_end	= $true;
	}
}
sub write_rtn{
		
		$line =   encode('utf8', $line); 
		print OTDD	$line;
}
