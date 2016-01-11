 package cmd;

 sub execute{
    my $com = shift;
    date();
    if ($date ne ''){
        print 1;
        system($date);
    }
    system("echo 'Command: $com "."Log:\n' >> log.txt");
    print 2;
    chomp $com;
    system($com . " >> log.txt");
    print 3;
 }

sub date{
    if ($^O eq 'linux'){
        our $date = "date >> log.txt";
    }
    elsif ($^O eq 'MSWin32'){
        our $date = "GetSystemTime >> log.txt";
    }
    else {
        our $date = "";
    }
}

1;