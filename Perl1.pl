#!/usr/bin/perl
#Reverse Polish notation

#Organization of the stack for writing characters
my @stack;
my @plquest;
#String for writing answ
my $out = '';

print "Enter the expression:\n";
#Reading of expression
if (@ARGV.length != 0){
  my $exp = @ARGV[0];
}
else{
  my $exp = <STDIN>;
}
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
            $out = $out . $temp;
            push @plquest, $temp;
            $temp = pop @stack;
          }
          $out = $out . $temp;
          push @plquest, $temp;
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
          push @plquest, $temp;
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
        push @plquest, $x;
      }
    }
}
#Write remaining characters
foreach my $temp (@stack){
  $out = $out . $temp;
  push @plquest, $temp;
}
undef @stack;

#Arr for math RPN;
my @plansw;
@plquest = reverse(@plquest);
print join(", ", @plquest);
#Calculation of Polish notation explicitly
while (@plquest.length ne 0){
  $temp = pop @plquest;
  if ($temp eq '*'){
    push @plansw, (pop @plansw) * (pop @plansw);
  }
  elsif ($temp eq '/'){
    push @plansw, (pop @plansw) / (pop @plansw);
  }
  elsif ($temp eq '+'){
    push @plansw, (pop @plansw) + (pop @plansw);
  }
  elsif ($temp eq '-'){
    push @plansw, (pop @plansw) - (pop @plansw);
  }
  else{
    push @plansw, $temp;
  }
}
undef @plquest;

#Otput answ and math
print "Reverse Polish notation:\n" . $out . "\n";
print "Result(RPN):\n" . (pop @plansw) . "\n";
print "Result(eval):\n" . eval($exp) . "\n";
