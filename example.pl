use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Rational;


my $r = Rational->new(1, 2);
print("Object:      " . $r->repr . "\n");
print("Numerator:   " . $r->numerator . "\n");
print("Denominator: " . $r->denominator . "\n");
print("Value:       " . $r->value . "\n");
print("Quotient:    " . $r->quotient . "\n");
print("Remainder:   " . $r->remainder . "\n");

print("\n");


my $a = Rational->new(1, 2);
my $b = Rational->new($a);
my $c = 0;

print("Initial: a = $a; b = $b\n");
$a += 1;
$b = 2 - $b;
print("Final:   a = $a; b = $b\n");

print("\n");

print("Initial: a = $a; b = $b\n");
$a = $r / $b;
$b = $a * $r;
print("Final:   a = $a; b = $b\n");

print("\n");

print("Initial: a = $a; c = $c\n");
$a **= 2;
$c = 2 ** $b;
print("Final:   a = $a; c = $c\n");

print("\n");

my $d = Rational->new($a - $b);
print("Initial:                " . $d . "\n");
print("Absolute value:         " . abs($d) . "\n");
print("Additive inverse:       " . -$d . "\n");
print("Multiplicative inverse: " . ~$d . "\n");

print("\n");

my $s = 0;
foreach (1..9) {
    $s += Rational->new(1, $_);
}
print("s = $s = " . $s->value . "\n");

my $p = 1;
foreach (1..9) {
    $p *= Rational->new(1, $_);
}
print("p = $p = " . $p->value . "\n");

print("\n");

print("$s <  $p : " . ($s < $p  ? "True" : "False") . "\n");
print("$s <= $p : " . ($s <= $p ? "True" : "False") . "\n");
print("$s == $p : " . ($s == $p ? "True" : "False") . "\n");
print("$s != $p : " . ($s != $p ? "True" : "False") . "\n");
print("$s >= $p : " . ($s >= $p ? "True" : "False") . "\n");
print("$s >  $p : " . ($s > $p  ? "True" : "False") . "\n");
