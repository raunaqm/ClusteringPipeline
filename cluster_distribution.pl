#Compute the read distribution of the clusters in second run file using the .cur file
# USAGE perl cluster_distribution.pl <.cur file>  
open(file,$ARGV[0]);
%hist = ();
while($l=<file>)
{
	chomp($l);
	($k,$cluster) = split(/ /,$l);
	$hist{$cluster}++; #increase the number of reads in cluster k by 1
}
close file;

for $k(sort {$a<=>$b} keys %hist)
{
	print "$k $hist{$k}\n";
}

