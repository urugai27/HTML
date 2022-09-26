#	20220926	past.html の切り出し判定 入力行が、3000行を超えたら、
#				pastmakeフォルダ配下で、切り出し作業を行う
use strict;
use warnings;
use utf8;

use Encode; 

binmode STDIN,  ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';
	if (@ARGV != 1){ die "引数を2つ指定して下さい\n"};
  	my $infile = $ARGV[0];
  	my $otfile = $ARGV[1];

	my $true	 = "1";
	my $false	 = "0";	

	print "入力ファイル=$infile\n";
	open(INDD,"<",$infile) or die("error :$!");
	my	$f_in_end	= $false;
	my	$line		= "";
	my	$lineCout	= 0;

	&read_rtn();
	until( $f_in_end	==	$true){
		++$lineCout;
		if($lineCout	>	3000){		#3000行を超えたら異常終了させる
			die "3000行を超えました、切り出し作業を行って下さい！！\n"
		}

		&read_rtn();
		
	}	
	print "read 行は $lineCout でした　切り出し未満です\n";
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
