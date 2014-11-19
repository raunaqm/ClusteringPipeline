# USAGE perl filterbycounts.pl <ucfile> <thresholdvalue> <consensusfile>
# Filter out the cluster numbers that are below a certain threshold value and only output those clusters which are above a certain threshold
#
use lib "/i3c/alisa/rom5161/rh6/perl/lib/perl5";
use Bio::SeqIO;
open(file,$ARGV[0]);
while($line = <file>){
	if(substr($line,0,1) ne "#"){
		@vals = split(/\t/,$line);
		if($vals[0] eq "S" || $vals[0] eq "H") {
			$hash{$vals[1]}++;
		}
	}
}
close file;
$L = $ARGV[1];
$seqio = Bio::SeqIO->new(-file=>"$ARGV[2]",-format=>"fasta");
while($obj=$seqio->next_seq) {
	$id=$obj->id;
	$id = substr($id,7);
	$seq = $obj->seq;
	$id_seq{$id} = $seq;
}
for $k(sort {$hash{$b}<=>$hash{$a}} keys %hash) {
	if($hash{$k}>$L){
		print ">Cluster$k\n";
		print "$id_seq{$k}\n";
	}
}

