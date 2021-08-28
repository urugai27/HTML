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
  	my $otfile = "temp_index.html";

	my $true	 = "1";
	my $false	 = "0";	

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

	until(( $line	=~/^<br>\d\d:\d\d/)
		||( $f_mast_end	==	$true)){
		&write_rtn();
		&read_mast_rtn();
	}	
	if( $line	=~/^<br>\d\d:\d\d/){
		&write_rtn();

		until( $f_link_end	==	$true){
			$line		= $link;
			&write_rtn();	
			&read_link_rtn();
		}	
		&read_mast_rtn();

	}		

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
