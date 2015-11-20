 #!/usr/bin/perl
 #"mp3"

if (@ARGV.length != 0){
    $filepath = @ARGV[0];
}
else{
    print "Please enter a path to Mp3 file.\n";
    $filepath = <STDIN>;
}
open $file, '+<', $filepath or die "Mp3 file isn't exist\n";
print "File opened!\n";
$size = -s $file;
cui();

sub cui{
    #Flag for chousing version of IDv3
    my $flag = 1;
    while ($flag){
    #Flag for level2 menu
    my $flag1 = 1;
        print "Which version of the tag you want to view?
[1] ID3v1
[2] ID3v2
[3] Exit\n";
        my $menu = <STDIN>;
        $menu += 0;
        if ($menu eq 1){ 
            id3v1_pars();
            id3v1_show();
            while ($flag1){
                my $flag2 = 1;
                print "        Option:
                [1] Edit field
                [2] Return for re-select version of IDv3
                [3] Exit\n";
                $menu = <STDIN>;
                $menu += 0;
                if ($menu eq 1){
                    while($flag2){
                        print "Сhoose one number of tag (1...6) or 0 for exit\n";
                        $menu = <STDIN>;
                        $menu += 0;
                        if ($menu eq 6){
                            id3v1_edit_genre();
                            rescan();
                            $flag2 = 0;
                        }
                        elsif (($menu >0) and ($menu < 6)){
                            id3v1_edit($menu);
                            rescan();
                            $flag2 = 0;
                        }
                        elsif ($menu eq 0){
                            exit 1;
                        }
                        else{print "Wrong number of tag! Try again!\n"}
                    }
                }
                elsif ($menu eq 2){
                    undef @tags;
                    $flag1 = 0;
                }
                elsif ($menu eq 3){
                    exit 1;
                }
            }
        }
        elsif ($menu eq 2){
            id3v2_pars();
        }
        elsif ($menu eq 3){
            exit 1;
        }
    }
 }

 sub id3v1_pars{
    seek ($file, $size - 128, 0);
    read ($file, my $buf, 3);
    if ($buf eq 'TAG'){
        print "Tags was found!\n";
        #Array for saving tags
        our @tags;
        our %offset =(
        1 => 30,
        2 => 30,
        3 => 30,
        4 => 4,
        5 => 30,
        6 => 1);
        
        my $i = 1;
        while ($i<7){
            read($file, $buf, $offset{$i});
            push @tags, $buf;
            $i += 1;
        }
    }
    else {
        print "ID3v1 tag broken or not exist!\n";
        exit 2;
    }
 }

sub id3v1_show{
    my %tag_name =(
        1 => "Title:" ,
        2 => "Artist:",
        3 => "Album:",
        4 => "Year:",
        5 => "Comment:",
        6 => "Genre:");
    our %genre_name =(
        0 => "Blues",
        1 => "Classic Rock",
        2 => "Country",
        3 => "Dance",
        4 => "Disco",
        5 => "Funk",
        6 => "Grunge",
        7 => "Hip-Hop",
        8 => "Jazz",
        9 => "Metal",
        10 => "New Age",
        11 => "Oldies",
        12 => "Other",
        13 => "Pop",
        14 => "R&B",
        15 => "Rap",
        16 => "Reggae",
        17 => "Rock",
        18 => "Techno",
        19 => "Industrial",
        20 => "Alternative",
        21 => "Ska",
        22 => "Death Metal",
        23 => "Pranks",
        24 => "Soundtrack",
        25 => "Euro-Techno",
        26 => "Ambient",
        27 => "Trip-Hop",
        28 => "Vocal",
        29 => "Jazz+Funk",
        30 => "Fusion",
        31 => "Trance",
        32 => "Classical",
        33 => "Instrumental",
        34 => "Acid",
        35 => "House",
        36 => "Game",
        37 => "Sound Clip",
        38 => "Gospel",
        39 => "Noise",
        40 => "Alternative Rock",
        41 => "Bass",
        42 => "Soul",
        43 => "Punk",
        44 => "Space",
        45 => "Meditative",
        46 => "Instrumental Pop",
        47 => "Instrumental Rock",
        48 => "Ethnic",
        49 => "Gothic",
        50 => "Darkwave",
        51 => "Techno-Industrial",
        52 => "Electronic",
        53 => "Pop-Folk",
        54 => "Eurodance",
        55 => "Dream",
        56 => "Southern Rock",
        57 => "Comedy",
        58 => "Cult",
        59 => "Gangsta",
        60 => "Top 40",
        61 => "Christian Rap",
        62 => "Pop/Funk",
        63 => "Jungle",
        64 => "Native US",
        65 => "Cabaret",
        66 => "New Wave",
        67 => "Psychadelic",
        68 => "Rave",
        69 => "Showtunes",
        70 => "Trailer",
        71 => "Lo-Fi",
        72 => "Tribal",
        73 => "Acid Punk",
        74 => "Acid Jazz",
        75 => "Polka",
        76 => "Retro",
        77 => "Musical",
        78 => "Rock & Roll",
        79 => "Hard Rock",
        80 => "Folk",
        81 => "Folk-Rock",
        82 => "National Folk",
        83 => "Swing",
        84 => "Fast Fusion",
        85 => "Bebob",
        86 => "Latin",
        87 => "Revival",
        88 => "Celtic",
        89 => "Bluegrass",
        90 => "Avantgarde",
        91 => "Gothic Rock",
        92 => "Progressive Rock",
        93 => "Psychedelic Rock",
        94 => "Symphonic Rock",
        95 => "Slow Rock",
        96 => "Big Band",
        97 => "Chorus",
        98 => "Easy Listening",
        99 => "Acoustic",
        100 => "Humour",
        101 => "Speech",
        102 => "Chanson",
        103 => "Opera",
        104 => "Chamber Music",
        105 => "Sonata",
        106 => "Symphony",
        107 => "Booty Bass",
        108 => "Primus",
        109 => "Porn Groove",
        110 => "Satire",
        111 => "Slow Jam",
        112 => "Club",
        113 => "Tango",
        114 => "Samba",
        115 => "Folklore",
        116 => "Ballad",
        117 => "Power Ballad",
        118 => "Rhythmic Soul",
        119 => "Freestyle",
        120 => "Duet",
        121 => "Punk Rock",
        122 => "Drum Solo",
        123 => "Acapella",
        124 => "Euro-House",
        125 => "Dance Hall",
        126 => "Goa",
        127 => "Drum & Bass",
        128 => "Club-House",
        129 => "Hardcore",
        130 => "Terror",
        131 => "Indie",
        132 => "BritPop",
        133 => "Negerpunk",
        134 => "Polsk Punk",
        135 => "Beat",
        136 => "Christian Gangsta Rap",
        137 => "Heavy Metal",
        138 => "Black Metal",
        139 => "Crossover",
        140 => "Contemporary Christian",
        141 => "Christian Rock",
        142 => "Merengue",
        143 => "Salsa",
        144 => "Thrash Metal",
        145 => "Anime",
        146 => "JPop",
        147 => "Synthpop",
        148 => "Rock/Pop");
    my $i = 1;
    while (my $tag = @tags[$i-1]){
        if ($i ne 6){
            print "[$i] $tag_name{$i} $tag\n";
        }
        else{
            print "[6] $tag_name{$i} $genre_name{ord($tag)}\n";
        }
        $i +=1;
    }
}

sub id3v1_edit{
    my ($tag) = @_;
    print "Old tag: @tags[$tag-1]\nType new tag (max $offset{$tag} characters)\n";
    my $new_tag = substr(<STDIN>, 0, $offset{$tag});
    chomp $new_tag;
    my $temp = length($new_tag);
    while ($temp < $offset{$tag}) {
        $new_tag = $new_tag . chr(0);
        $temp += 1;
    }
    my $i = 1;
    $temp = 0;
    while($i<$tag){
        $temp += $offset{$i};
        $i += 1;
    }
    seek ($file, $size - 125 + $temp, 0);
    #read ($file, $buf, $offset{$tag});
    print $file $new_tag;
    reopen();
}

sub id3v1_edit_genre{
    print "Show list of genre? (y/n)\n";
    my $answ = <STDIN>;
    chomp $answ;
    my $flag = 1;
    while ($flag){
        if ($answ eq "y"){
            my $i = 1;
            print "№     Genre\n";
            while ($i<149){
                print "$i     $genre_name{$i}\n";
                $i += 1;
            }
        }
        elsif($answ eq "n"){}
        else{
            print 'Not correct answer! Try again.'
        }
        my $flag1 = 1;
        while ($flag1){
            print "Type a new num of genre\n";
            $new_genre = <STDIN>;
            chomp $new_genre;
            if (($new_genre<148) and ($new_genre>1)){
                seek($file, $size - 1, 0);
                print $file chr($new_genre);
                reopen();
                $flag = 0; 
                $flag1 = 0;
            }
                else{
                    print "Bad number of genre";
                }
        }
    }
}

sub reopen{
    close $file;
    print "Change saved\n";
    open $file, '+<', $filepath or die "Mp3 file isn't exist\n";
}

sub rescan{
    undef @tags;
    id3v1_pars();
    id3v1_show();
}