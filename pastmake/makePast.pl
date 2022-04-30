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
	my	$date_from		= "";



	&Log_read_rtn();

#-------------( 始まりの記述を定義ファイルを読み込み展開する )----------------------------------------#
	open(INDEFS,"<","makelog_start_def.cpp") or die("error :$!");
	while (my $defSrec = <INDEFS>) {
			$defSrec =   decode('utf8', $defSrec);  
#	<title>うるがいの話 過去の書き込み１３</title>			
			if($defSrec	=~/<title>うるがいの話 過去の書き込み◆◆<\/title>/){
 				print "Log tile Heatt \n";
 				$defSrec =~ s/◆◆/$past_seq/;

 		}	
#<FONT size="5" color="purple"><h3> うるがいの話 過去の書き込み１３回目 </h3> </FONT>
			if($defSrec	=~/^<FONT size="5" color="purple"><h3> うるがいの話 過去の書き込み◆◆回目 <\/h3> <\/FONT>/){
 				print "Log tile h3 title \n";
 				$defSrec =~ s/◆◆/$past_seq/;
 		}	
#<br>このページの一番古い日は:2021年10月08日
			if($defSrec	=~/^<br>このページの一番古い日は:####年##月##日/){
 				print "Log tile mast Old day \n";
 				$defSrec =~ s/####年##月##日/$date_from/;
			}	
			
			$line =   $defSrec; 
			&write_rtn();
	}

	&read_rtn();


	while( $f_in_end	==	$false){

		&write_rtn();
#
		&read_rtn();
	}	

#-------------( 終わりの記述を定義ファイルを読み込み展開する )----------------------------------------#
	open(INDEFE,"<","makelog_end_def.cpp") or die("error :$!");
	while (my $defErec = <INDEFE>) {
			$line =   $defErec; 
			&write_rtn();
	}


	close	LOGDD;
	close	INDD;
	close	OTDD;

sub Log_read_rtn{
	if(!eof LOGDD){
		$logrec = <LOGDD>;
		$logrec =   decode('utf8', $logrec);  

#13 2021.10.08 (震度５強)  から 2021.12.17 (小節番号)  まで
		if($logrec	=~/^(\d{2,}) (\d{4}).(\d{2}).(\d{2})/){
			$past_seq = $1;
			$date_from	 = $2."年".$3."月".$4."日";
			$past_seq	 =~ tr/0-9A-Za-zｱ-ﾝ/０-９Ａ-Ｚａ-ｚア-ン/;					#半角を全角へ
 			print "Log_read new $past_seq \n";
 			print "Log_read from $date_from \n";
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
		$line =   encode('utf8', $line); 
		print OTDD	$line;
}
