#!/usr/bin/perl
#"Backup"
use File::Basename;

$\ = $/;
@dir;
@bupdir;
#Backup location
$bup = "./backup";

if (@ARGV.length != 0){
  $config = @ARGV[0];
  open $config, '<', $config or die "Config file isn't exist";
  prepare();
  backup();
}
else{
  print "Config file isn't exist.\n Please enter a path to folder for backup.\n";
  $path = <STDIN>;
}

#print "Path to folders for backup: " . $path;
#print "Path to backup: " . $dest;


sub oldcopy{
  my ($base, $temp) = @_;
  rename ($bup . "/" . $base,$bup . "/" . $base . ".old");
  system ("cp", "-r", $temp, $bup . "/" . $base);
}

sub zip {
  my ($base, $temp) = @_;
  if (($base.".7z") ~~ @bupdir) {
    print "Old version of " . $base . "7zip will be deleted";
    unlink ($bup . "/" . $base,$bup . "/" . $base . ".7z");
    print "Delete complete!\nCreating new archive:";
    system ("7z", "a",$bup . "/" .  $base.".7z",$bup . "/" .  $base.".old");
    print "Archive created!";
    print "Delete old " . $base .".old";
    system ("rm", "-rf", $bup . "/" .  $base.".old");
    print "Delete complete!\nCreate new " . $base.".old";
    oldcopy($base, $temp); 
  }
  else {
    print "Creating 7zip archive:";
    system ("7z", "a",$bup . "/" .  $base.".7z",$bup . "/" .  $base.".old");
    print "Archive created!";
  }
}

sub old {
  my ($base, $temp) = @_;
  if (($base.".old") ~~ @bupdir){
    zip($base, $temp);
  }
  else{
    oldcopy($base, $temp);
  }
}


sub backup {
  while (@dir.length ne 0){
    my $temp = pop @dir;
    my $base = basename($temp);
    #$base = ~/(\/)+/;

    print $base;
    if ($base ~~ @bupdir){
      old($base, $temp);      
    }
    else{
      system ("cp", "-r", $temp, $bup . "/" . $base);
    }
  }
}

sub prepare {
  print "Dir for backup:";
  while (my $temp = <$config>){
    chomp $temp;
    if (opendir $dir, $temp){
      push @dir, $temp;
      print $temp;
    }
    else{
      print "Dir '$temp' not found and is not processed";
    }
  }
  close $config;
  if (opendir $bup, $bup){
    print "Folder for backup already exist";
  }
  else{
    print "Make folder for backup";
    mkdir ($bup);
    opendir $bup, $bup;
  }
  while (my $bupdir = readdir $bup){
      print '1111';
      print $bupdir;
      push @bupdir, $bupdir;
    }
}
