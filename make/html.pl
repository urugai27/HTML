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
#2021.03.12	絶対アドレスに変更する;	
	$otfile	=	"C:\\Users\\ATHUSHI\\Desktop\\html\\".$otfile;	
	open(OTDD,">",$otfile) or die("error :$!");
	
#	@youbi = ('日', '月', '火', '水', '木', '金', '土');
	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime;
	$year += 1900;
	$mon += 1;
	my @day_of_week = qw/日 月 火 水 木 金 土/;

#	print "$year年$mon月$mday日($youbi[$wday]) $hour時$min分$sec秒\n";
#	print $year,"年",$mon,":",$mday,"\n";
	printf "%04d年%02d月%02d日(%s)\n",$year,$mon,$mday,$day_of_week[$wday];
#	print "曜日は" . $day_of_week[$wday] . "曜日です。\n\n";
	printf "%02d:%02d\n",$hour,$min;

	my	$f_in_end	= $false;
	my	$line		= "";
	my	$tmp_line	= "";
	my	$title	= "";

	&read_rtn();

	&head_write_rtn();

	&read_rtn();

	while( $f_in_end	==	$false){

		print OTDD	"<br>";
#
		&write_rtn();
#
		&read_rtn();
	}	

	&term_write_rtn();

	close	INDD;
	close	OTDD;

sub read_rtn{
	if(!eof INDD){
		$line = <INDD>;
		$line =   decode('utf8', $line);  
		
#		print "read \n";
	}else{
# 		print "read owari \n";
		$f_in_end	= $true;
	}
}
sub write_rtn{
#		$line =   encode('shiftjis', $line); 
		$line =   encode('utf8', $line); 
		print OTDD	$line;
}
sub head_write_rtn{
		print OTDD	"<html>\n";
		print OTDD	"<head>\n";
		print OTDD	"</head>\n";
		print OTDD	"<body>\n";

#		printf OTDD "%04d年%02d月%02d日(%s)\n",
#			$year,$mon,$mday,$day_of_week[$wday];
		printf OTDD "<br>%04d",$year;
		print  OTDD encode('utf8',"年"); 
		printf OTDD "%02d",$mon;
		print  OTDD encode('utf8',"月"); 
		printf OTDD "%02d",$mday;
		print  OTDD encode('utf8',"日");
		print  OTDD " (";
		print  OTDD encode('utf8',$day_of_week[$wday]);
		print  OTDD encode('utf8',"）");
		print OTDD "<FONT color=\"red\">";

		if($line	=~/title:(.*)/){
			$title	= $1;
		}	
		print OTDD encode('utf8',$title);
		print OTDD "</FONT>\n";

#<a name="label20210222"></a>
		printf OTDD "<a name=\"label%04d%02d%02d\"></a>\n",$year,$mon,$mday;
		 
		printf OTDD "<br>%02d:%02d\n",$hour,$min;


}
sub term_write_rtn{
		print OTDD	"<br>\n";
		print OTDD	"</body>\n";
		print OTDD	"</html>\n";
}
