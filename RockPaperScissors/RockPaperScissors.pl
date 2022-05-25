# Mehul Patel
#Date: 9/15/2021
#Game of Rock, Paper, Scissors
#Choose 1, 2, or 3 Since 1 = Rock, 2 = Paper, 3 Scissors



use strict;

my $look_behind = shift || 10;
my @winners = (1, 2, 0);
my @Character_Pieces = qw( Rock Paper Scissors );
my @characters = qw( R P S );

my (%freq,@last,$uw,$cw,$t);


while (1) {
  my $game;


  for my $X (0 .. $#last) {
    if (my $c = $freq{"@last[$X .. $#last]"}) {
      $game = $winners[ weighted(@$c) ];
      last;
    }
  }

  $game = int rand 3 if not defined $game;

  print "Rock (1), Paper (2), Scissors (3):  ";
  chomp(my $player = <STDIN>);

  last if !$player or $player > 3;


  $player--;
  for (0 .. $#last) {
    $freq{"@last[0 .. $_]"}[$player]++;
  }

  shift @last if @last == $look_behind;
  push @last, $player;

  print "$Character_Pieces[$player] vs. $Character_Pieces[$game] => ";

  if ($game == $player) { $t++; print "tied\n" }
  elsif ($game == $winners[$player]) { $cw++; print "AI wins\n" }
  else { $uw++; print "you win\n" }   
}


sub weighted {
  my ($choice,$sum);

  for my $Y (0 .. $#_) {
    $_[$Y] ||= 0;
    $choice = $Y if rand($sum += $_[$Y]) < $_[$Y];
  }
    
  return $choice;
}
     
   
print "You wins': $uw\n";
print "Computer wins':  $cw\n";
print "Ties:    $t\n\n";
  
for (sort { length($a) <=> length($b) } keys %freq) {
  for (split ' ') { print $characters[$_] }
  print " => ( ";
  for my $Z (0 .. 2) {
    print "$characters[$Z] = ", $freq{$_}[$Z] || 0, ", ";
  }
  print ")\n";
}