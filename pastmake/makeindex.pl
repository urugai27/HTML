use strict;
use warnings;
use utf8;

use Encode; 

binmode STDIN,  ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';
	if (@ARGV != 3){ die "引数を3つ指定して下さい\n"};



  	my $Histfile = $ARGV[0];
  	my $infile	 = $ARGV[1];
  	my $otfile	 = $ARGV[2];

	my $true	 = "1";
	my $false	 = "0";	

	print "新履歴ファイル=$Histfile,  入力ファイル=$infile, 出力ファイル=$otfile\n";
	open(LOGDD,"<",$Histfile) or die("error :$!");
	open(INDD,"<",$infile) or die("error :$!");
	open(OTDD,">",$otfile) or die("error :$!");
	my	$f_in_end	= $false;
	my	$logrec		= "";
	my	$line		= "";
	my	$old_line	= "";

	my	$write_sw	= $true;
	
	my	$past_seq		= 0;
	my	$new_content	= "";
	
	my	$date_from		= "";

#---------( 直近３世代のうち、今回整理する 過去ログ )-----------------------#

	my	$cut_seq		= 0;
	my	$cut_past_html	= "";
	my	$cut_past_JEF	= "";

	
	&read_rtn();

	&Log_read_rtn();

	while( $f_in_end	==	$false){


		$old_line	= $line;

#		if (($line	=~/^<li><a href="(past10.html)"/)||
#			($line	=~/data-message="(過去１０回目)/)){
		if (($line	=~/^<li><a href="($cut_past_html)"/)||
			($line	=~/data-message="($cut_past_JEF)/)){
 			print "Log Cut $1  \n";
			$old_line	= $line;
		}else{
			&write_rtn();
		}
		
#<li class="this">切り出し日</li>
		if($old_line	=~/^<li class="this">切り出し日<\/li>/){
 			print "Log Insert Heatt \n";
			&insert_rtn();
 		}	
#
		&read_rtn();
	}	

	close	LOGDD;
	close	INDD;
	close	OTDD;


sub Log_read_rtn{
	if(!eof LOGDD){
		$logrec = <LOGDD>;
		$logrec =   decode('utf8', $logrec);  

#13 2021.10.08 (震度５強)  から 2021.12.17 (小節番号)  まで
		if($logrec	=~/^(\d{2,})(.*)/){
			$past_seq = $1;
			$new_content = $2;
 			print "Log_read new $past_seq \n";
 			print "Log_read new $new_content \n";
		}				

		if($logrec	=~/^.*(\d{4}.\d{2}.\d{2}).*(\d{4}.\d{2}.\d{2})/){
			$date_from = $1;
 			print "Log_read new $date_from \n";
		}				
		
#		if (($line	=~/^<li><a href="(past10.html)"/)||
#			($line	=~/data-message="(過去１０回目)/)){

		$cut_seq		= $past_seq - 3;
		$cut_past_html	= "past".$cut_seq.".html";
 		print "Log_read cut $cut_past_html \n";

		$cut_seq	 =~ tr/0-9A-Za-zｱ-ﾝ/０-９Ａ-Ｚａ-ｚア-ン/;					#半角を全角へ
		$cut_past_JEF	= "過去".$cut_seq."回目";
 		print "Log_read cut $cut_past_JEF \n";


		
	}else{
 		print "Log_read read owari \n";
		$f_in_end	= $true;
	}
}


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
sub insert_rtn{
#<li><a href="past12.html" target="_blank"><span class="popup_help"
		print OTDD	'<li><a href="past';
		print OTDD	$past_seq;
		print OTDD	'.html" target="_blank"><span class="popup_help"';
		print OTDD	"\n";

#	 data-message="過去１３回目 2021.10.08 (震度５強) から 2021.12.17 (小節番号) まで">2021.10.08</span></a></li>
		print OTDD	'	 data-message="過去';
		$past_seq =~ tr/0-9A-Za-zｱ-ﾝ/０-９Ａ-Ｚａ-ｚア-ン/;					#半角を全角へ
		print OTDD	$past_seq;
		print OTDD	"回目";
		print OTDD	$new_content;
		print OTDD	'">';
		print OTDD	$date_from;
		print OTDD	'</span></a></li>';
		print OTDD	"\n";
}
