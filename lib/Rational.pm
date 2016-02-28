use strict;
use warnings;


package Rational;


our $VERSION = '1.0.0';


use constant NUMERATOR_TYPE_ERROR_MESSAGE => 'The numerator of a rational must be a rational or an integer value!';
use constant DENOMINATOR_TYPE_ERROR_MESSAGE => 'The denominator of a rational must be a rational or an integer value!';

use constant DENOMINATOR_ZERO_DIVISION_ERROR_MESSAGE => 'The denominator of a rational number can not be zero!';

use constant DIVIDER_ZERO_DIVISION_ERROR_MESSAGE => 'The divider cannot be 0!';

use constant POWER_TYPE_ERROR_MESSAGE => 'The power must be an integer value!';

use constant ZERO_TO_NEGATIVE_POWER_ZERO_DIVISION_ERROR_MESSAGE => '0 cannot be raised to a negative power!';

use constant NEGATIVE_INTEGER_TO_FRACTIONAL_POWER_ERROR_MESSAGE => 'Negative number cannot be raised to a fractional ",
																	power!';

use constant FIRST_TERM_TYPE_ERROR_MESSAGE => 'The first term must be a rational or an integer value!';
use constant SECOND_TERM_TYPE_ERROR_MESSAGE => 'The second term must be a rational or an integer value!';


use overload
	'""' => 'str',
	'neg' => 'neg',
	'abs' => 'abs',
	'int' => 'int',
	'~' => 'invert',
	'<' => 'lt',
	'<=' => 'le',
	'==' => 'eq',
	'!=' => 'ne',
	'>=' => 'ge',
	'>' => 'gt',
	'+' => 'add',
	'-' => 'sub',
	'*' => 'mul',
	'/' => 'div',
	'**' => 'pow';


sub new {
	my ($class, $numerator, $denominator) = @_;
	
	$numerator = defined($numerator) ? $numerator : 0;
	$denominator = defined($denominator) ? $denominator : 1;

	if (ref($numerator) ne __PACKAGE__ and $numerator !~ /^[+-]?\d+$/) {
		die(NUMERATOR_TYPE_ERROR_MESSAGE);
	}

	if (ref($denominator) ne __PACKAGE__ and $denominator !~ /^[+-]?\d+$/) {
		die(DENOMINATOR_TYPE_ERROR_MESSAGE);
	}
	
	if ($denominator =~ /^[+-]?\d+$/ and 0 == $denominator) {
		die(DENOMINATOR_ZERO_DIVISION_ERROR_MESSAGE);
	}
	
	if (ref($denominator) eq __PACKAGE__ && 0 == $denominator->numerator) {
		die(DENOMINATOR_ZERO_DIVISION_ERROR_MESSAGE);
	}
	
	if (ref($numerator) eq __PACKAGE__ or ref($denominator) eq __PACKAGE__) {
  		($numerator, $denominator) = transform($numerator, $denominator);
  	}

	my $divisor = gcd($numerator, $denominator);
	
	my $self = {
		_numerator 	=> $numerator / $divisor,
		_denominator => $denominator / $divisor,
	};
	
	my $object = bless $self, $class;
	return $object;
}

sub gcd {
	my ($a, $b) = @_;
	my $r = 0;
	
	while (0 != $b) {
		$r = $a % $b;
		$a = $b;
		$b = $r;
	}
	
	return $a;
}

sub transform {
	my ($a, $b) = @_;
	my $numerator = 0;
	my $denominator = 1;

	if (defined($a) && ref($a) eq __PACKAGE__) {
		$numerator = $a->numerator;
		$denominator = $a->denominator;
	} else {
		$numerator = $a;
		$denominator = 1;
	}
	
	if (defined($b) && ref($b) eq __PACKAGE__) {
		$numerator *= $b->denominator;
		$denominator *= $b->numerator;
	} else {
		$denominator *= $b;
	}
	
	return $numerator, $denominator
}

sub numerator {
	my $self = shift;
	return $self->{_numerator};
}

sub denominator {
	my $self = shift;
	return $self->{_denominator};
}

sub value {
	my $self = shift;
	return $self->{_numerator} / $self->{_denominator};
}

sub quotient {
	my $self = shift;
	return int($self->{_numerator} / $self->{_denominator});
}

sub remainder {
	my $self = shift;
	return $self->{_numerator} % $self->{_denominator};
}

sub str {
	my $self = shift;
	if (1 == $self->{_denominator}) {
		return "$self->{_numerator}";
	} else {
		return "$self->{_numerator}/$self->{_denominator}";
	}
}

sub repr {
	my $self = shift;	
	return __PACKAGE__ . "($self->{_numerator}, $self->{_denominator})";
}

sub float {
	my $self = shift;
	return $self->{_numerator} / $self->{_denominator};
}

sub int {
	my $self = shift;
	return int($self->{_numerator} / $self->{_denominator});
}

sub neg {
	my $self = shift;
	return Rational->new(-$self->{_numerator}, $self->{_denominator});
}

sub abs {
	my $self = shift;
	return Rational->new(abs($self->{_numerator}), $self->{_denominator});
}

sub invert {
	my $self = shift;
	return Rational->new($self->{_denominator}, $self->{_numerator});
}

sub lt {
	my $self = shift;
	my $other = shift;
	return $self->{_numerator} * $other->{_denominator} < $self->{_denominator} * $other->{_numerator};
}

sub le {
	my $self = shift;
	my $other = shift;
	return $self->{_numerator} * $other->{_denominator} <= $self->{_denominator} * $other->{_numerator};
}

sub eq {
	my $self = shift;
	my $other = shift;
	return $self->{_numerator} * $other->{_denominator} == $self->{_denominator} * $other->{_numerator};
}

sub ne {
	my $self = shift;
	my $other = shift;
	return $self->{_numerator} * $other->{_denominator} != $self->{_denominator} * $other->{_numerator};
}

sub ge {
	my $self = shift;
	my $other = shift;
	return $self->{_numerator} * $other->{_denominator} >= $self->{_denominator} * $other->{_numerator};
}

sub gt {
	my $self = shift;
	my $other = shift;
	return $self->{_numerator} * $other->{_denominator} > $self->{_denominator} * $other->{_numerator};
}

sub add {
	my ($self, $other, $swap) = @_;
	
	if (ref($other) ne __PACKAGE__ and $other !~ /^[+-]?\d+$/) {
		$swap ? die(FIRST_TERM_TYPE_ERROR_MESSAGE): die(SECOND_TERM_TYPE_ERROR_MESSAGE);
	}

	if ($other =~ /^[+-]?\d+$/) {
		$other = Rational->new($other);
	}

  	my $numerator = $self->{_numerator} * $other->{_denominator} + $self->{_denominator} * $other->{_numerator};
	my $denominator = $self->{_denominator} * $other->{_denominator};

	return Rational->new($numerator, $denominator);
}

sub sub {
	my ($self, $other, $swap) = @_;
	
	if (ref($other) ne __PACKAGE__ and $other !~ /^[+-]?\d+$/) {
  		$swap ? die(FIRST_TERM_TYPE_ERROR_MESSAGE): die(SECOND_TERM_TYPE_ERROR_MESSAGE);
	}

	if ($other =~ /^[+-]?\d+$/) {
		$other = Rational->new($other);
	}

	my $numerator = $self->{_numerator} * $other->{_denominator} - $self->{_denominator} * $other->{_numerator};
  	my $denominator = $self->{_denominator} * $other->{_denominator};

	my $result = Rational->new($numerator, $denominator);
	$result = -$result if $swap;
	
	return $result;
}

sub mul {
	my ($self, $other, $swap) = @_;
	
	if (ref($other) ne __PACKAGE__ and $other !~ /^[+-]?\d+$/) {
  		$swap ? die(FIRST_TERM_TYPE_ERROR_MESSAGE): die(SECOND_TERM_TYPE_ERROR_MESSAGE);
	}

	if ($other =~ /^[+-]?\d+$/) {
		$other = Rational->new($other);
	}

  	my $numerator = $self->{_numerator} * $other->{_numerator};
  	my $denominator = $self->{_denominator} * $other->{_denominator};

	return Rational->new($numerator, $denominator);
}

sub div {
	my ($self, $other, $swap) = @_;
	
	if (ref($other) ne __PACKAGE__ and $other !~ /^[+-]?\d+$/) {
  		$swap ? die(FIRST_TERM_TYPE_ERROR_MESSAGE): die(SECOND_TERM_TYPE_ERROR_MESSAGE);
	}

	if ($other =~ /^[+-]?\d+$/) {
		$other = Rational->new($other);
	}

	if (0 == $other->{_numerator}) {
		die(DIVIDER_ZERO_DIVISION_ERROR_MESSAGE);
	}

	my $numerator = 0;
	my $denominator = 1;
	if ($swap) {
		$numerator = $other->{_numerator} * $self->{_denominator};
  		$denominator = $other->{_denominator} * $self->{_numerator};
	} else {
  		$numerator = $self->{_numerator} * $other->{_denominator};
  		$denominator = $self->{_denominator} * $other->{_numerator};
  	}

	return Rational->new($numerator, $denominator);
}

sub pow {
	my ($self, $power, $swap) = @_;
	
	if ($swap) {
		if (0 > $power and 1 != $self->{_denominator}) {
			die(NEGATIVE_INTEGER_TO_FRACTIONAL_POWER_ERROR_MESSAGE);
		}
    
    	if (0 == $power and 0 > $self->value) {
    		die(ZERO_TO_NEGATIVE_POWER_ZERO_DIVISION_ERROR_MESSAGE);
    	}
    
    	return $power ** $self->value;
	}
	
	if ($power !~ /^[+-]?\d+$/) {
		die(POWER_TYPE_ERROR_MESSAGE);
	}

	if (0 > $power and 0 == $self->{_numerator}) {
		die(ZERO_TO_NEGATIVE_POWER_ZERO_DIVISION_ERROR_MESSAGE);
	}

	if (0 == $power and 0 == $self->{_numerator}) {
		return Rational->new($self->{_numerator}, $self->{_denominator});
	}

	my $numerator = 0;
	my $denominator = 1;
	if (0 > $power) {
		$numerator = $self->{_denominator} ** -$power;
		$denominator = $self->{_numerator} ** -$power;
	} else {
		$numerator = $self->{_numerator} ** $power;
		$denominator = $self->{_denominator} ** $power;
	}

	return Rational->new($numerator, $denominator);
}

1;
