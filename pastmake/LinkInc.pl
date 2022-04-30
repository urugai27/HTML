#2021.08.24 		pc1とpc2 のバックアップのため 更新日付より、退避ファイルの判定を行う
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
  	my $otfile 	= $ARGV[2];

	my $true	 = "1";
	my $false	 = "0";	

	print "新履歴ファイル=$Histfile,  入力ファイル=$infile, 出力ファイル=$otfile\n";
	open(LOGDD,"<",$Histfile) or die("error :$!");
	open(INDD,"<",$infile) or die("error :$!");
	open(OTDD,">",$otfile) or die("error :$!");
	my	$f_in_end	= $false;
	my	$logrec		= "";
	my	$line		= "";
#	my	$write_sw	= $false;
	my  $linkDate		= 0;
	my  $linkName		= "";

	my	$date_from		= 0;
	my	$date_to		= 0;



	&Log_read_rtn();


	&read_rtn();
	while( $f_in_end	==	$false){

#      1183   2022/04/24      14:31:14  D:\homepage\link\20220424_2Mameka.html

		if($line	=~/\\link\\(\d{8})(.*html)/){
			$linkDate	= $1;
			$linkName	= $1.$2;
#			print 	"update:",$linkName,"\n";
		}
#
#13 2021.10.08 (震度５強) から 2021.12.17 (小節番号)まで
#		if(	($linkDate	ge	20211008)&&
#			($linkDate	le	20211217)){
		if(	($linkDate	ge	$date_from)&&
			($linkDate	le	$date_to)){
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
		if($logrec	=~/^(\d{2,}) (\d{4}).(\d{1,2}).(\d{1,2}).*(\d{4}).(\d{1,2}).(\d{1,2})/){
#			$past_seq = $1;
			$date_from	 = $2.sprintf("%02d",$3).sprintf("%02d",$4);			#書式対応  ゼロ付き2桁の月、日に編集しなおす
#ng			$date_to	 = $5.$6.$7;
			$date_to	 = $5.sprintf("%02d",$6).sprintf("%02d",$7);			#書式対応  ゼロ付き2桁の月、日に編集しなおす
 			print "Log_read from $date_from \n";
 			print "Log_read from $date_to \n";
		}				
		
		
	}else{
 		print "Log_read read owari \n";
		$f_in_end	= $true;
	}
}
sub read_rtn{
	if(!eof INDD){
		$line = <INDD>;
#		$line =   decode('utf8', $line);  
		$line =   decode('shiftjis', $line);  
		
#		print "read \n";
	}else{
# 		print "read owari \n";
		$f_in_end	= $true;
	}
}
sub write_rtn{
		$line =   encode('shiftjis', $line); 
#		$line =   encode('utf8', $line); 
		print OTDD	$line;
}
