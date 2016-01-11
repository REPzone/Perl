#!/usr/bin/perl 
#Cmd
use cmd;
print "$^O\n";
my $flag = 1;
print  "Print shell command\n";
while($flag){
    my $com = <STDIN>;
    if ($com ne ''){
        cmd::execute($com);
        print "If you want quit print 'quit' or  print new command \n";
        my $com= <STDIN>;
        chomp $com;
        if ($com eq 'quit'){
            $flag = 0;
            print "Exit...";
        }
    }
}