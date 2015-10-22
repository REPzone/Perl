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

sub backup {
  while (@dir.length ne 0){
    $temp = pop @dir;
    $base = basename($temp);
    if ($base ~~ @bupdir){
      rename ($bup . "/" . $base,$bup . "/" . $base . ".old");
      system ("cp", "-r", $temp, $bup . "/" . $base);
    }
    else{
      system ("cp", "-r", $temp, $bup . "/" . $base);
    }
  }
}

sub prepare {
  print "Dir for backuping:";
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
      print $bupdir;
      push @bupdir, $bupdir;
    }
}
