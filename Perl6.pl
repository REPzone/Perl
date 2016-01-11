#!/usr/bin/perl 
#Email

#$\=$/;


if (@ARGV.length != 0){
    $path = @ARGV[0];
    print "Path to file:\n" . $path . "\n";
}
else{
    print "Enter path to file:\n";
    $path = <STDIN>;
}

open $path, '<', $path or die "Config file isn't exist";
my $mails;
while (<$path>){
    chomp;
    $_ = ~ /.*mailto:([a-zA-Z0-9\-\_]+\@[0-9a-zA-Z]+\.[a-z]+).+([-+]\w+)/g;
    #if ($temp)
    #print 121212;
    if ($1 ne ''){
        $mails{$1} = $2;
    }
    foreach my $mail (keys %mails){
        print "$mail\t->\t$mails{$mail}\n";
    }
}