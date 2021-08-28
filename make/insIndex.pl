use strict;
use warnings;
use utf8;

use Encode; 

binmode STDIN,  ':encoding(cp932)';
binmode STDOUT, ':encoding(cp932)';
binmode STDERR, ':encoding(cp932)';
	if (@ARGV != 2){ die "引数を2つ指定して下さい\n"};
  	my $mstfile = $ARGV[0];
  	my $addfile = $ARGV[1];
  	my $otfile = "new_index.html";

	my $true	 = "1";
	my $false	 = "0";	

	print "入力マスタファイル=$mstfile, 入力リンクファイル=$addfile\n";
	open(INMAST,"<",$mstfile) or die("error :$!");
	open(INTEMP,"<",$addfile) or die("error :$!");
	open(OTDD,">",$otfile) or die("error :$!");
	

	my	$f_mast_end	= $false;
	my	$f_insf_end	= $false;
	my	$line		= "";
	my	$ladd		= "";

	my	$old_update_day	= "";
	my	$old_update_hizuke	= "";
	my	$update_day	= "";
	my	$title		= "";


	&read_mast_rtn();
	&read_temp_rtn();
#最新の日は:2021.04.03日
#<br>2021年04月04日 (日）<FONT color="red">ネットのニュース</FONT>

	until(( $ladd	=~/^<br>\d{4}年\d{2}月\d{2}日/)			#
		||( $f_insf_end	==	$true)){
			&read_temp_rtn();
	}	
#	if( $ladd	=~/^<br>(\d{4})年(\d{2})月(\d{2})日.*>(.*)</FONT>/){			#
#		print "追加の日は:$1.$2.$3日 title=$4","\n";
	if( $ladd	=~/^<br>(\d{4})年(\d{2})月(\d{2})日/){			#
#		$update_day	= ":".$1.".".$2.".".$3";
		$update_day	= ":$1.$2.$3";
#		print "追加の日は:$1.$2.$3日 ","\n";
		print "追加の日は",$update_day,"\n";
		if( $ladd	=~/\">(.*)<\/FONT>/){			#
			$title = $1;
			print "タイトルは",$title,"\n";
		}
	}	



#最新の日は:2021.04.03日
	until(( $line	=~/^最新の日は:\d{4}\.\d{2}\.\d{2}日/)			#
		||( $f_mast_end	==	$true)){
		&write_rtn();
		&read_mast_rtn();
	}	
	if( $line	=~/^最新の日は:(\d{4})\.(\d{2})\.(\d{2})日/){			#
		$old_update_day	= ":$1.$2.$3";
		$old_update_hizuke	= "<br>$1年$2月$3日";
		print "最新の日は:$1.$2.$3日","\n";
		print "前の最新の日は:$old_update_day","\n";
		$line=~ s/$old_update_day/$update_day/;
		&write_rtn();

		&read_mast_rtn();
		&write_rtn();											#<br>
		&read_mast_rtn();
		&write_rtn();											#最新:
		&read_mast_rtn();
		$line=$title."\n";
		&write_rtn();											#新しいタイトル:
		&read_mast_rtn();
	}	
#<a name="label"></a>
	until(( $line	=~/<a name="label">/)			#
		||( $f_mast_end	==	$true)){
		&write_rtn();
		&read_mast_rtn();
	}	

	if(  $line	=~/<a name="label">/){
		&write_rtn();
		&read_mast_rtn();
		&write_rtn();											#<br>

		until( $f_insf_end	==	$true){
			$line		= $ladd;
			&write_rtn();	
			&read_temp_rtn();
		}	
		&read_mast_rtn();

	}		

	until( $f_mast_end	==	$true){

		if( $line	=~/^$old_update_hizuke/){			#
			$line=~ s/red/blue/;						#<FONT color="red">-> 
		}
		&write_rtn();
#
		&read_mast_rtn();
	}	

	close	INMAST;
	close	INTEMP;
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
sub read_temp_rtn{
	if(!eof INTEMP){
		$ladd = <INTEMP>;
		
#		chomp	$ladd;
		$ladd =   decode('utf8', $ladd); 
		
		if($ladd=~/<\/body>/){
			$f_insf_end	= $true;
		}
	}else{
		$f_insf_end	= $true;
	}
}
sub write_rtn{
		
		$line =   encode('utf8', $line); 
		print OTDD	$line;
}
