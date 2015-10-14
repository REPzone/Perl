#!/usr/bin/perl
#"Backup"

#Backup location()
open $config, '<', 'config.dat';
if (@ARGV.length != 0){
  $path = @ARGV[0];
}
elsif (-e $config){
  $path = <$config>;
}
else{
  print "Config file isn't exist.\n Please enter a location for backup.\n";
  my $path = <STDIN>;
}

print "Path to backup: " . $path . "\n";
open $dir, $path;

sub backup {

}

sub prepare {

}
