#!/usr/bin/perl
#"Words" 

if (@ARGV.length != 0){
    $filepath = @ARGV[0];
}
else{
    print "Please enter a path to txt file.\n";
    $filepath = <STDIN>;
}

open $file, '<', $filepath or die "Text file isn't exist\n";
print "File opened!\n";

$/ = "\n";

while ($words = <$file>){
    %word_hash;
    chomp $words;
    foreach $x (split(/[,.\s]/, $words)){
        if ($x ~~ %word_hash){
            $word_hash{$x} += 1;
        }
        else{
            $word_hash{$x} = 1;
        }
    }
}
for my $key ( sort { $word_hash{$b} <=> $word_hash{$a} } keys %word_hash ) {
    printf "%s : %d\n", $key, $word_hash{ $key };
}