#2022.04.29 		link フォルダにあるlink.html の戻る先を過去ログへ変更する
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

	my  $linkAddres		= "";
	my  $linkDate		= 0;
	my  $linkName		= "";
	my  $RepAddres		= "";

	my	$past_html		= "";
#----------------------------------------( link　ファイルを読む　)----------------------------#
	my	$f_link_end	= $false;
	my	$linkrec	= "";
	my	$Reprec		= "";

	&Log_read_rtn();


	&read_rtn();
	while( $f_in_end	==	$false){

#      1334   2021/10/08      15:09:02  D:\homepage\link\20211008_1Tocho.html

		if($line	=~/(\d{2}:\d{2}:\d{2})  (.*html)/){
			$linkAddres	= $2;
#			print 	"linkAddres:",$linkAddres,"\n";
		}

		if($line	=~/\\link\\(\d{8})(.*html)/){
			$linkDate	= $1;
			$linkName	= $1.$2;
#			print 	"linkName: $linkName \n";
			$RepAddres		= "RepLink\\".$linkName;
#			print 	"RepAddres $RepAddres \n";


		}
#----------------( 個別のlinkファイルを読み込む )------------------#
		open(LINKDD,"<",$linkAddres) or die("error :$!");
		open(REPDD,">",$RepAddres) or die("error :$!");

		$f_link_end	= $false;
		$linkrec	= "";

		&Link_read_rtn();

		while( $f_link_end	==	$false){
		
				$Reprec =   $linkrec; 
				
				
#<td align="left"><a href="../index.html#label20211008"><font size="3"><span class="f7">戻る</span></font></a></td>
				if($Reprec	=~/^<td align="left"><a href="..\/index.html#label/){
 					print "Link Rept Heatt \n";
 					$Reprec=~ s/index.html/$past_html/;
				}
				
				&Rep_write_rtn();

				&Link_read_rtn();
		}

		close	LINKDD;
		close	REPDD;

#------------------------------------------------------------------#
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
		if($logrec	=~/^(\d{2,})/){
			$past_html = "past".$1.".html";
#<td align="left"><a href="../past13.html#label20170408"><font size="3"><span class="f7">戻る</span></font></a></td>

 			print "Log_read new $past_html \n";

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
sub Link_read_rtn{
	if(!eof LINKDD){
		$linkrec = <LINKDD>;
		$linkrec =   decode('utf8', $linkrec);  
		
	}else{
		$f_link_end	= $true;
	}

}
sub Rep_write_rtn{
#		$Reprec =   encode('shiftjis', $Reprec); 
		$Reprec =   encode('utf8', $Reprec); 
		print REPDD	$Reprec;
}
