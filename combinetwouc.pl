open(file,$ARGV[0]);
while($line=<file>) {
	chomp($line);
	if(substr($line,0,1) ne "#") {
		@vs = split(/\t/,$line);
		if($vs[0] eq "H" || $vs[0] eq "S") {
			$hash1st{$vs[8]} = "Cluster$vs[1]";
		}
	}
}
close file;

open(file,$ARGV[1]);
while($l=<file>) {
	chomp($l);
	if(substr($l,0,1) ne "#") {
		@vs = split(/\t/,$l);
		if($vs[0] eq "H" || $vs[0] eq "S") {
			$hash2nd{$vs[8]} = $vs[1];
		}
	}
}
close file;

for (keys %hash1st ) {
	if(exists($hash2nd{$hash1st{$_}})) {
		print "$_ $hash2nd{$hash1st{$_}}\n";
	}
}
