#!/usr/local/bin/perl

#Organization of the stack for writing characters
my @stack;
my @stack1;
#String for writing answ
my $out = '';

print "Enter the expression:\n";
#Reading of expression
my $exp = <STDIN>;
#Initialize a hash with priority of operation
my %prior = (
  "(" => 0,
  ")" => 0,
  "+" => 1,
  "-" => 1,
  "*" => 2,
  "/" => 2,
);
#Parsing string
foreach my $x (split //, $exp) {
    if ($x ne " "){
      if ($x eq "("){
        push @stack, $x;
      }
      elsif ($x eq ")"){
        #Check for existence of opening bracket
        if (@stack.length ne 0){
          my $temp = pop @stack;
          while ($temp != "("){
			print 1;
			push @stack1, $temp;
            $out = $out . $temp;
            $temp = pop @stack;
          }
          $out = $out . $temp;
          undef $temp
        }
        else{
          print "Wrong input";
          exit 1;
        }
        pop @stack;
      }
      elsif ($x eq '*' or $x eq '/' or $x eq '+' or $x eq '-'){
        my $temp = pop @stack;
        push @stack, $temp;
        while ($prior{$x} <= $prior{$temp}){
          $out = $out . $temp;
          push @stack1, $temp;
          pop @stack;
          $temp = pop @stack;
          push @stack, $temp;
        }
        push @stack, $x;
      }
      elsif ("\n" eq $x){
        $x = '';
      }
      else{
        $out = $out . $x;
        push @stack1, $x
      }
    }
}
#Write remaining characters
foreach my $temp (@stack){
  $out = $out . $temp;
}
undef @stack2;

#Calculation of Polish notation explicitly
my @stack1;
#foreach my $x (split //, $out) {
#	if ($x eq '*' or $x eq '/' or $x eq '+' or $x eq '-'){
#		my $x = pop @stack1;
		 

#Otput answ and math
print "Reverse Polish notation:\n" . $out . "\n";
print "Result:\n" . eval($exp) . "\n";
