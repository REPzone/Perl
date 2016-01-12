#!/usr/bin/perl 
#"tac"

#$\=$/;

$bsize = 512;
$tail_size = 0;
$tail_data = '';
$tail_data_old ='';
@string;
my @tmp;
if (@ARGV.length != 0){
    $path = @ARGV[0];
    open($fn, "<", $path) or die "ERROR: Path not correct!";
}
else{
    print "ERROR: No file path!";
    exit 1;
}

$size = -s $fn;
#close $fn;
print $size;

if ($size < $bsize){
    print reverse <>;
}
else{
    open $fh, '<', $path or die "Error while opening file\n";
    seek ($fh, $size, 0);
    while ($size > 0){
        my $rsize = ($bsize, $size)[$bsize > $size];
        my $data = '';
        my $flag = 1;
        seek ($fh, $size-$rsize, 0);
        read $fh, $data, $rsize;
        my @spl = reverse split //, $data;

        for $key (@spl){
             if ($key eq "\n"){
                print join /''/, reverse @tmp;
                print "\n";            
                @tmp = ();
            }
        else {
            push @tmp, $key;
        }
    }

        $size -= $rsize;
    }
    print join /''/, reverse @tmp;
    print "\n";

}

print $rsize;

=old_else
#seek ($fn, $file_size, 0);
    $flag = 1;
    #while ($file_size > 0){
        seek ($fn, $file_size - ($buf_size - $tail_size), 0);
        read $fn, $data, ($buf_size - $tail_size);
        $i = 0;
        print $data;
        foreach $x (split //, $data){
            if ($x eq "\n"){
                @string[i] = @string[i].$x;
                $i += 1;
            }
            else{
                @string[i] = @string[i].$x;
            }
        }
        @string_reverse = reverse(@string);
        $tail_data = pop @string_reverse;
        print @string_reverse;
    #}
=cut

=sht


            #print $x;
            push @string, $x;
        }
        $temp = pop @string;
        @string_reverse = reverse(@string);
        $tail_data =  pop @string_reverse;
        $temp = $temp
        #print $tail_data;
        #tail_sub();
        print join("\n", @string_reverse);
        $tail_size = length($tail_data);
        $buf_size +=  $buf_size;


sub tail_sub{
    my $temp = pop @string;
    foreach my $x (split){}
}

if (($tail_data ne '') and $flag){
    push @string,  $x .$tail_data;
    $flag = 1;
}





foreach $x (split //, $data){
            if ($x eq "\n"){
                @string[$i] = @string[$i] . $x;
                $i += 1;
                #print $i . "\n"
                #print 121313;
            }
            else{
                #print 99999999;
                @string[$i] = @string[$i] . $x;
            }
        }
        @string_reverse = reverse(@string);
        $tail_data = pop @string_reverse;
        $tail_data_temp = $tail_data;
        if ($tail_data_temp = ~/\n/){
            #print 1;
            print $tail_data;
            $tail_data_old = $tail_data;
            $tail_size = length($tail_data);
        }
        else{
            $tail_data = $tail_data . $tail_data_old;
            $tail_size = 0;
            push @string_reverse, $tail_data;
            $tail_data_old = $tail_data;
        }
        print join("\n", @string_reverse);
        $buf_size +=  $buf_size;
        undef @string;
    }
}
=cut
