# Open the fasta file and trim reads to a certain length
# Reads of length less than the threshold are ignored.  
# perl trim_to_bases.pl <fasta> <length> <write_file>

$fasta_file = $ARGV[0];
$L = $ARGV[1];
$fwdback=$ARGV[2]; # s or e to indicate whether trim from begining or from the end
open(file,$fasta_file);
open(wrfile,">$ARGV[3]");
$read="";
$total=0; $count=0;
while($l=<file>)
{
	chomp($l);
	if(substr($l,0,1) ne ">")
	{
		$read=$read.$l;
	}else
	{
		$total++;
		if(length($read)>=$L)
		{
			if($fwdback eq "e") {
				$rr= substr($read,0,$L); # trim the read to the desired length
			}
			else 
			{
				$rr= substr($read,-$L); #trim from the begining. 
			}
			print wrfile $id."\n";
			print wrfile $rr."\n";
			$count++;
		}
		$id=$l;
		$read="";
	}
}

if(length($read)>=$L)
{
	$count++;
	$rr=substr($read,0,$L);
	print wrfile $id."\n";
	print wrfile $rr."\n";
}
close file;
close wrfile;
print "trimmed reads $count out of $total\n";
