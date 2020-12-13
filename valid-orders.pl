use strict;
use warnings;

my @buckets = ( [ 1, 4 ],
                [ 5, 8 ],
                [ 2, 3 ],
                [ 6, 7 ],
              );

my @combinations; 

for (0..15) {
  my $combination = sprintf "%04b", $_;
  $combination .= $combination =~ tr/01/10/r;
  my @options = split //, $combination;
  push @combinations, join( '-', map { $buckets[ $_ % 4 ]->[ $options[$_] ] } 0 .. $#options ), "\n";
}

my @twice = map { $_ .'-'. $_ } grep /^1/, @combinations;

my %seen;

for my $combination ( @combinations ) {
  
  for my $twice ( @twice ) {
    
    if ( $twice =~ /$combination/ ) {
      
      print "$combination already seen in $twice\n" if $seen{$twice};
      $seen{$twice}++;
    }
  }
}

print $_, "\n" for sort keys %seen;
