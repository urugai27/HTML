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
	my	$write_sw	= $true;
	
	my	$past_seq		= 0;
	my	$new_content	= "";


	&read_rtn();

	&Log_read_rtn();


	while( $f_in_end	==	$false){

		if($line	=~/^<FONT size="4" color="purple"><h2> うるがいの話 過去の書き込み一覧 <\/h2> 　<\/FONT>/){
 			print "Log Insert Heatt \n";

			&write_rtn();
	
			&Insert_write_rtn();
 			
		}else{
			&write_rtn();
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
sub Insert_write_rtn{

#<br>
		print OTDD	"<br>\n";
#<td align="left"><a href="past12.html" target="_blank"><font size="2">
		print OTDD	'<td align="left"><a href="past';
		print OTDD	$past_seq;
		print OTDD	'.html" target="_blank"><font size="2">';
		print OTDD	"\n";

#<span class="f14">過去１２回目 2021.7.31 (鳥) から 2021.10.07 (カローラ) まで
		print OTDD	'<span class="f14">過去';
		$past_seq =~ tr/0-9A-Za-zｱ-ﾝ/０-９Ａ-Ｚａ-ｚア-ン/;					#半角を全角へ
		print OTDD	$past_seq;
		print OTDD	"回目";
		print OTDD	$new_content;
		print OTDD	"\n";

#</span></font></a></td>
		print OTDD	'</span></font></a></td>';
		print OTDD	"\n";
}
