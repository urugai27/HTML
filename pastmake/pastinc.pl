#		2023.02.19 2023.２０.２３ (２０２３年建国記念の日)の日付抽出の誤り
use strict;
use warnings;
use utf8;

use Encode; 

binmode STDIN,  ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';
	if (@ARGV != 5){ die "引数を5つ指定して下さい\n"};
  	my $infile = $ARGV[0];
  	my $otfile = $ARGV[1];
  	my $logfile = $ARGV[2];
  	my $histfile = $ARGV[3];
  	my $paradd = $ARGV[4];

	my $true	 = "1";
	my $false	 = "0";	

	print "start_logday=$paradd\n";
	print "入力ファイル=$infile, 出力ファイル=$otfile\n";
	open(INDD,"<",$infile) or die("error :$!");
	open(OTDD,">",$otfile) or die("error :$!");
	open(LOGDD,">",$logfile) or die("error :$!");
	open(HISTDD,">",$histfile) or die("error :$!");
	my	$f_in_end	= $false;
	my	$line		= "";
	my	$write_sw	= $true;
	my	$old_line	= "";
	my	$logline		= "";
	my	$Histline		= "";

	my	$date_to		= "";
	my	$title_to		= "";

	my	$date_from		= "";
	my	$title_from		= "";

	my	$past_no_sw		= $false;
	my	$past_seq		= 0;

	my	$wrap_sw		= $false;

	&read_rtn();

	while( $f_in_end	==	$false){

#<li><a href="past12.html" target="_blank"><span class="popup_help"

		if($past_no_sw eq $false){
			if($line	=~/^<li><a href="past(\d{2,})\.html"/){
				$past_seq		= $1;
				print "hitto li past $past_seq\n";
				$past_no_sw	= $true;
				++$past_seq;
			}
		}

		if($line	=~/$paradd/){
			print "hitto $paradd\n";
			$write_sw	= $false;

			$logline = $old_line;
			&log_rtn();
			
#			$Histline = $old_line;
#			&hist_rtn();

#<br>2021年12月17日 (金）<FONT color="blue">小節番号</FONT>

#			if($old_line	=~/^<br>(\d{4}).*(\d{2}).*(\d{2})/){		#2023.02.19 
			if($old_line	=~/^<br>(\d{4}).*(\d{2}).*(\d{2}).*\(/){
				$date_to	= $1.".".$2.".".$3;
				print "$date_to ";
				
			}	
			if($old_line	=~/<FONT color="blue">(.*)<\/FONT>/){
				$title_to	= $1;
				print "$title_to\n";

			}	

		}

#----------------------( 最終ブロックの書き込み再開判定  )----------------------------#
#</div><!-- /#wrap -->

		if( $line	=~/^<\/div><!-- \/#wrap -->/){
			print "hitto wrap\n";
			$wrap_sw		= $true;
			$write_sw		= $true;
		}

#


		if	($write_sw	== $true){
#

			&write_rtn();
			$old_line	= $line;


		}else{

#-----------------------(  一番古い日付とタイトル をセットする )--------------------------------#

			if($line	=~/^<br>(\d{4}).*(\d{2}).*(\d{2}).*<FONT color="blue">(.*)<\/FONT>/){
				$date_from	= $1.".".$2.".".$3;
				$title_from	= $4;
			}	

			$logline = $line;
			&log_rtn();
		}
#
		&read_rtn();
	}	

#index:data-message="過去１３回目 2021.10.08 (震度５強) から 2021.12.17 (小節番号) まで">2021.10.08</span></a></li>
#log :<span class="f14">過去１３回目 2021.10.08 (震度５強) から 2021.12.17 (小節番号) まで

	$Histline = $past_seq." ".$date_from." (".$title_from.") から ".$date_to." (".$title_to.")まで\n";
	&hist_rtn();

	close	INDD;
	close	OTDD;
	close	LOGDD;
	close	HISTDD;


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
		if($old_line ne ""){
#
			if($wrap_sw	 eq $true){
				$old_line	= $line;
			}
		
			$old_line =   encode('utf8', $old_line); 
			print OTDD	$old_line;
		}	
}
sub log_rtn{
#		$line =   encode('shiftjis', $line); 
		$logline =   encode('utf8', $logline); 
		print LOGDD	$logline;
}
sub hist_rtn{
#		print "hist_rtn\n";
		$Histline =   encode('utf8', $Histline); 
		print HISTDD $Histline;
}
