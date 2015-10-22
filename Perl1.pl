#!/usr/bin/perl
#Reverse Polish notation

#Organization of the stack for writing characters
@stack;
@plquest;
#String for writing answ
$out = '';
#counter for validation expression
$count1 = 0;
$count2 = 0;

#Reading of expression
if (@ARGV.length != 0){
  $exp = @ARGV[0];
  print "Expression:\n" . $exp . "\n";
}
else{
  print "Enter the expression:\n";
  $exp = <STDIN>;
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
#Parsing input string
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
          print "Wrong expression";
          exit 1;
        }
        pop @stack;
      }
      elsif ($x eq '*' or $x eq '/' or $x eq '+' or $x eq '-'){
        $count1++;
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
      elsif ("\n" eq $x){}
      else{
        $count2++;
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

#Validation expression(stupid metod)
print $count1 . " " . $count2;
if ($count1 ne ($count2-1)){
  print "Expression isn't correct\n";
  exit 2;
}

#Arr for math RPN;
@plansw;
@plquest = reverse(@plquest);
#Calculation of Polish notation explicitly
while (@plquest.length ne 0){
  $temp = pop @plquest;
  if ($temp eq '*'){
    push @plansw, (pop @plansw) * (pop @plansw);
  }
  elsif ($temp eq '/'){
    my $b = pop @plansw;
    my $a = pop @plansw; 
    push @plansw, $a - $b;
  }
  elsif ($temp eq '+'){
    push @plansw, (pop @plansw) + (pop @plansw);
  }
  elsif ($temp eq '-'){
    my $b = pop @plansw;
    my $a = pop @plansw; 
    push @plansw, $a - $b;
  }
  elsif ($temp eq ""){}
  else{
    push @plansw, $temp;
  }
}
undef @plquest;

#Otput answ and math
print "Reverse Polish notation:\n" . $out . "\n";
print "Result(RPN):\n" . (pop @plansw) . "\n";
print "Result(eval):\n" . eval($exp) . "\n";
