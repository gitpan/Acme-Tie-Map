
use constant COUNT => 1;

use Test;
BEGIN { plan tests => (4*COUNT)+3 };
use Acme::Tie::Map;
ok(1); # If we made it this far, we're ok.

sub succ {
  my $a = shift;
  return $a+1;
}

my $x;

tie $x, 'Acme::Tie::Map', \&succ;

for my $y (-(COUNT)..COUNT) {
  $x = $y;
  ok($x != $y);
  ok($x, succ($y));
}

