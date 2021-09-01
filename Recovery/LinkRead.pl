use strict;
use warnings;
use utf8;

use Cwd;	#	2021.08.29 カレントディレクトリの取得	
	my $wd = Cwd::getcwd();
	print $wd, "\n";
	my $htmldir = $wd;
	$htmldir =~ s/make//;

use Encode; 

binmode STDIN,  ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';

  	my $indir  = "./Link";
  	my $infile = "";
  	my $otfile = "tmp_RefLink.cpp";

	my $true	 = "1";
	my $false	 = "0";	

	my	$f_in_end	= $false;
	my	$line		= "";

	my	$imgsrc		= "";
	my	$imgTitle	= "";
	my	$imgwidth	= 0;
	my	$imgheight	= 0;
	my	$imgKata	= "pv";							#型 デフォルトは縦
	my	$small_imgwidth	= 0;


	open(OTDD,">",$otfile) or die("error :$!");

# ディレクトリオープン
	opendir(DIRHANDLE, $indir);
# ディレクトリエントリの取得
	foreach(readdir(DIRHANDLE)){
			next if /^\.{1,2}$/;    # '.'や'..'をスキップ
#			print "$_\n";
			$infile = $_;
			$infile = $indir."\\".$infile;
			print "$infile\n";
			open(INDD,"<",$infile) or die("error :$!");

			$f_in_end	= $false;

			&read_rtn();

			while( $f_in_end	==	$false){
#<img src="../image/20210831_1Run.JPG"  alt="いつ木に着根したか忘れた蘭の、初めて付けた蕾"  width="720" height="540" border="0" />
#20210831_1Run,ps,つぼみ,いつ木に着根したか忘れた蘭の、初めて付けた蕾,4032,3024,133,100,720,540

				if($line	=~/img src="\.\.\/image\/(\d{8}_\d{1}.*)\.JPG"/){			#
					$imgsrc		= $1;
					print "$imgsrc\n";

					if($line	=~/alt="(.*)"  width="(\d{3,4})" height="(\d{3,4})"/){			#
#		
#							print "$1  $2 $3 \n";

							$imgTitle	= $1;
							$imgwidth	= $2;
							$imgheight	= $3;

							if	($imgwidth	>= $imgheight){
								$imgKata	= "ps";							#型を横型に設定する
							}			
							
					}
				}
#
				&read_rtn();
			}

			$small_imgwidth	= int(($imgwidth / $imgheight) * 100);

			
			$line = $imgsrc.",".$imgKata.","."RCV,".$imgTitle.",".$imgwidth.",".$imgheight.",".$small_imgwidth.","."100".",".$imgwidth.",".$imgheight."\n";

			&write_rtn();

			close	INDD;


	}
# ディレクトリクローズ
	closedir(DIRHANDLE);

	close	OTDD;
sub read_rtn{
	if(!eof INDD){
		$line = <INDD>;
		$line =   decode('utf8', $line);  
		
	}else{
		$f_in_end	= $true;
	}
}
sub write_rtn{
#		$line =   encode('shiftjis', $line); 
		$line =   encode('utf8', $line); 
		print OTDD	$line;
}

