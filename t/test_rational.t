use strict;
use warnings;
 
use Test::Simple tests => 537;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Rational;


my @known_values = ([1, 2, 1, 2],
					[-1, 2, -1, 2],
					[1, -2, -1, 2],
					[-1, -2, 1, 2],
					
					[2, 4, 1, 2],
					[-2, 4, -1, 2],
					[2, -4, -1, 2],
					[-2, -4, 1, 2],
					
					[2, 1, 2, 1],
					[-2, 1, -2, 1],
					[2, -1, -2, 1],
					[-2, -1, 2, 1],
					
					[4, 2, 2, 1],
					[-4, 2, -2, 1],
					[4, -2, -2, 1],
					[-4, -2, 2, 1]);


sub repr {
	my $r = shift;
	if (defined($a) && ref($a) eq __PACKAGE__) {
		return $r->repr
	}
	return $r;
}


sub test_constructor_numerator_type_error {
	my $function_name = (caller(0))[3];

	eval { Rational->new(1.2) };
	ok($@ ne '', "Test $function_name");
}
test_constructor_numerator_type_error;

sub test_constructor_denominator_type_error {
	my $function_name = (caller(0))[3];

	eval { Rational->new(1, 1.2) };
	ok($@ ne '', "Test $function_name");
}
test_constructor_denominator_type_error;

sub test_constructor_denominator_zero_division_error {
	my $function_name = (caller(0))[3];
	
	#my $numerator = 1;
	#my $denominator = 0;
	#my $r1 = repr($numerator);
	#my $r2 = repr($denominator);
	#eval { Rational->new($numerator, $denominator) };
	#ok($@ ne '', "Test $function_name: (numerator=$r1, denominator=$r2)");
	
	#$numerator = Rational->new;
	#$denominator = 0;
	#$r1 = repr($numerator);
	#$r2 = repr($denominator);
	#eval { Rational->new($numerator, $denominator) };
	#ok($@ ne '', "Test $function_name: (numerator=$r1, denominator=$r2)");
	
	my $numerator = Rational->new;
	my $denominator = Rational->new;
	my $r1 = repr($numerator);
	my $r2 = repr($denominator);
	eval { Rational->new($numerator, $denominator) };
	ok($@ ne '', "Test $function_name: (numerator=$r1, denominator=$r2)");
}
test_constructor_denominator_zero_division_error;

sub test_constructor_numerator {
	my $function_name = (caller(0))[3];

	foreach my $row (@known_values) {
		my $r = Rational->new($row->[0], $row->[1]);
		ok($row->[2] == $r->numerator, "Test $function_name: (numerator=$row->[0], denominator=$row->[1])");
	}
}
test_constructor_numerator;

sub test_constructor_denominator {
	my $function_name = (caller(0))[3];
	
	foreach my $row (@known_values) {
		my $r = Rational->new($row->[0], $row->[1]);
		ok($row->[3] == $r->denominator, "Test $function_name: (numerator=$row->[0], denominator=$row->[1])");
  }
}
test_constructor_denominator;

sub test_constructor_transform {
	my $function_name = (caller(0))[3];
	my @test_constructor_transform_values = ([Rational->new(1, 2), Rational->new(1, 2), Rational->new(1)],
		[Rational->new(1, 2), Rational->new(1, 4), Rational->new(2)],
		[Rational->new(1, 4), Rational->new(1, 2), Rational->new(1, 2)],
		[Rational->new(-1, 2), Rational->new(1, 2), Rational->new(-1)],
		[Rational->new(-1, 2), Rational->new(1, 4), Rational->new(-2)],
		[Rational->new(-1, 4), Rational->new(1, 2), Rational->new(-1, 2)],
		[Rational->new(1, 2), Rational->new(-1, 2), Rational->new(-1)],
		[Rational->new(1, 2), Rational->new(-1, 4), Rational->new(-2)],
		[Rational->new(1, 4), Rational->new(-1, 2), Rational->new(-1, 2)],
		[Rational->new(-1, 2), Rational->new(-1, 2), Rational->new(1)],
		[Rational->new(-1, 2), Rational->new(-1, 4), Rational->new(2)],
		[Rational->new(-1, 4), Rational->new(-1, 2), Rational->new(1, 2)]);
													
	foreach my $row (@test_constructor_transform_values) {
		my $actual_result  = Rational->new($row->[0], $row->[1]);
		my $expected_result = $row->[2];
		
		my $a = repr($row->[0]);
		my $b = repr($row->[1]);
		my $c = repr($row->[2]);

		my $message = "Test $function_name: (a=$a, b=$b, expected_result=$c)";
		ok($expected_result == $actual_result , $message);
	}
}
test_constructor_transform;

sub test_transform {
	my $function_name = (caller(0))[3];
	my @test_transform_values = ([1, 2, 1, 2],
									[2, 4, 2, 4],
									[-1, 2, -1, 2],
									[-2, 4, -2, 4],
									[1, -2, 1, -2],
									[2, -4, 2, -4],
									[-1, -2, -1, -2],
									[-2, -4, -2, -4],

									[Rational->new(1, 2), 1, 1, 2],
									[Rational->new(1, 2), 2, 1, 4],
									[Rational->new(-1, 2), 1, -1, 2],
									[Rational->new(-1, 2), 2, -1, 4],
									[Rational->new(1, -2), 1, -1, 2],
									[Rational->new(1, -2), 2, -1, 4],
									[Rational->new(1, 2), -1, 1, -2],
									[Rational->new(1, 2), -2, 1, -4],
									[Rational->new(-1, 2), -1, -1, -2],
									[Rational->new(-1, 2), -2, -1, -4],

									[1, Rational->new(1, 2), 2, 1],
									[2, Rational->new(1, 2), 4, 1],
									[-1, Rational->new(1, 2), -2, 1],
									[-2, Rational->new(1, 2), -4, 1],
									[1, Rational->new(-1, 2), 2, -1],
									[2, Rational->new(-1, 2), 4, -1],
									[1, Rational->new(1, -2), 2, -1],
									[2, Rational->new(1, -2), 4, -1],
									[-1, Rational->new(1, 2), -2, 1],
									[-2, Rational->new(1, 2), -4, 1],

									[Rational->new(1, 2), Rational->new(1, 2), 2, 2],
									[Rational->new(1, 2), Rational->new(1, 4), 4, 2],
									[Rational->new(1, 4), Rational->new(1, 2), 2, 4],
									[Rational->new(-1, 2), Rational->new(1, 2), -2, 2],
									[Rational->new(-1, 2), Rational->new(1, 4), -4, 2],
									[Rational->new(-1, 4), Rational->new(1, 2), -2, 4],
									[Rational->new(1, 2), Rational->new(-1, 2), 2, -2],
									[Rational->new(1, 2), Rational->new(-1, 4), 4, -2],
									[Rational->new(1, 4), Rational->new(-1, 2), 2, -4],
									[Rational->new(-1, 2), Rational->new(-1, 2), -2, -2],
									[Rational->new(-1, 2), Rational->new(-1, 4), -4, -2],
									[Rational->new(-1, 4), Rational->new(-1, 2), -2, -4]);
													
	foreach my $row (@test_transform_values) {
		my @actual_result  = Rational::transform($row->[0], $row->[1]);
		my $expected_numerator = $row->[2];
		my $expected_denominator = $row->[3];
		my @expected_result = ($row->[2], $row->[3]);
		
		my $a = repr($row->[0]);
		my $b = repr($row->[1]);
	
		my $message = "Test $function_name: (a=$a, b=$b, expected_result=($expected_numerator, $expected_denominator))";
		ok(@expected_result == @actual_result , $message);
	}
}
test_transform;

sub test_gcd {
	my $function_name = (caller(0))[3];
	my @gcd_test_values = ([0, 0, 0],
							[0, 1, 1],
							[1, 0, 1],
							[0, -1, -1],
							[-1, 0, -1],
							[2, 4, 2],
							[-2, 4, 2],
							[-2, -4, -2],
							[42, 30, 6],
							[42, -30, -6],
							[-42, -30, -6]);
													
	foreach my $row (@gcd_test_values) {
		my $actual_gcd  = Rational::gcd($row->[0], $row->[1]);
		my $expected_gcd = $row->[2];
	
		my $message = "Test $function_name: (a=$row->[0], b=$row->[1], expected_gcd=$expected_gcd)";
		ok($expected_gcd == $actual_gcd, $message);
	}
}
test_gcd;

sub test_value {
	my $function_name = (caller(0))[3];

	foreach my $row (@known_values) {
		my $r = Rational->new($row->[0], $row->[1]);
		my $expected_value = $row->[2] / $row->[3];
	
		my $message = "Test $function_name: (numerator=$row->[0], denominator=$row->[1], ",
						"expected_result=$expected_value)";
		ok($expected_value == $r->value, $message);
	}
}
test_value;

sub test_quotient {
	my $function_name = (caller(0))[3];

	foreach my $row (@known_values) {
		my $r = Rational->new($row->[0], $row->[1]);
		my $expected_value = int($row->[2] / $row->[3]);

		my $message = "Test $function_name: (numerator=$row->[0], denominator=$row->[1], ",
						"expected_result=$expected_value)";
		ok($expected_value == $r->quotient, $message);
	}
}
test_quotient;


sub test_remainder {
	my $function_name = (caller(0))[3];

	foreach my $row (@known_values) {
		my $r = Rational->new($row->[0], $row->[1]);
		my $expected_value = $row->[2] % $row->[3];

		my $message = "Test $function_name: (numerator=$row->[0], denominator=$row->[1], ",
						"expected_result=$expected_value)";
		ok($expected_value == $r->remainder, $message);
	}
}
test_remainder;

sub test_str {
	my $function_name = (caller(0))[3];

	foreach my $row (@known_values) {
		my $r = Rational->new($row->[0], $row->[1]);
		
		my $expected_str;
		if (1 == $row->[3]) {
			$expected_str = "$row->[2]";
		} else {
			$expected_str = "$row->[2]/$row->[3]";
		}

		my $message = "Test $function_name: (numerator=$row->[0], denominator=$row->[1])";
		ok($expected_str eq $r->str, $message);
	}
}
test_str;

sub test_repr {
	my $function_name = (caller(0))[3];

	foreach my $row (@known_values) {
		my $r = Rational->new($row->[0], $row->[1]);
		
		my $expected_string = "Rational($row->[2], $row->[3])";

		my $message = "Test $function_name: (numerator=$row->[0], denominator=$row->[1])";
		ok($expected_string eq $r->repr, $message);
	}
}
test_repr;

sub test_float {
	my $function_name = (caller(0))[3];

	foreach my $row (@known_values) {
		my $r = Rational->new($row->[0], $row->[1]);
		my $expected_value = $row->[2]/$row->[3];

		my $message = "Test $function_name: (numerator=$row->[0], denominator=$row->[1])";
		ok($expected_value == $r->float, $message);
	}
}
test_float;

sub test_int {
	my $function_name = (caller(0))[3];

	foreach my $row (@known_values) {
		my $r = Rational->new($row->[0], $row->[1]);
		my $expected_value = int($row->[2]/$row->[3]);
		
		my $message = "Test $function_name: (numerator=$row->[0], denominator=$row->[1])";
		ok($expected_value == int($r), $message);
	}
}
test_int;

sub test_neg {
	my $function_name = (caller(0))[3];

	foreach my $row (@known_values) {
		my $r = -Rational->new($row->[0], $row->[1]);
		
		my $message = "Test $function_name: (numerator=$row->[0], denominator=$row->[1])";
		ok(-$row->[2] == $r->numerator, $message);
		ok($row->[3] == $r->denominator, $message);
	}
}
test_neg;

sub test_abs {
	my $function_name = (caller(0))[3];

	foreach my $row (@known_values) {
		my $r = abs(Rational->new($row->[0], $row->[1]));
		
		my $message = "Test $function_name: (numerator=$row->[0], denominator=$row->[1])";
		ok(abs($row->[2]) == $r->numerator, $message);
		ok($row->[3] == $r->denominator, $message);
	}
}
test_abs;

sub test_invert_zero_division_error {
	my $function_name = (caller(0))[3];

	eval { my $r = ~Rational->new(0) };
	ok($@ ne '', "Test $function_name");
}
test_invert_zero_division_error;

sub test_invert {
	my $function_name = (caller(0))[3];

	foreach my $row (@known_values) {
		my $r = ~Rational->new($row->[0], $row->[1]);
		
		my $expected_inverted_numerator;
		my $expected_inverted_denominator;
		if (0 > $row->[2]) {
			$expected_inverted_numerator = -$row->[3];
			$expected_inverted_denominator = -$row->[2];
		} else {
			$expected_inverted_numerator = $row->[3];
			$expected_inverted_denominator = $row->[2];
		}
		
		my $message = "Test $function_name: (numerator=$row->[0], denominator=$row->[1])";
		ok($expected_inverted_numerator == $r->numerator, $message);
		ok($expected_inverted_denominator == $r->denominator, $message);
	}
}
test_invert;

sub test_lt {
	my $function_name = (caller(0))[3];

	my @true_test_cases = ([Rational->new(-1, 2), Rational->new()],
							[Rational->new, Rational->new(1, 2)],
							[Rational->new(-1, 2), Rational->new(1, 2)],
							[Rational->new(1, 4), Rational->new(1, 2)],
							[Rational->new(-1, 2), Rational->new(-1, 4)]);

	my @false_test_cases = ([Rational->new(), Rational->new()],
							[Rational->new(1, 2), Rational->new()],
							[Rational->new(), Rational->new(-1, 2)],
							[Rational->new(-1, 2), Rational->new(1, -2)],
							[Rational->new(1, 2), Rational->new(2, 4)],
							[Rational->new(1, 2), Rational->new(-1, 2)],
							[Rational->new(1, 2), Rational->new(1, 4)],
							[Rational->new(-1, 4), Rational->new(-1, 2)]);
						
	foreach my $row (@true_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		
		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=True)";
		ok($row->[0] < $row->[1], $message);
	}
	
	foreach my $row (@false_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		
		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=False)";
		ok(!($row->[0] < $row->[1]), $message);
	}
}
test_lt;

sub test_le {
	my $function_name = (caller(0))[3];

	my @true_test_cases = ([Rational->new(), Rational->new()],
							[Rational->new(-1, 2), Rational->new()],
							[Rational->new(), Rational->new(1, 2)],
							[Rational->new(-1, 2), Rational->new(1, -2)],
							[Rational->new(1, 2), Rational->new(2, 4)],
							[Rational->new(-1, 2), Rational->new(1, 2)],
							[Rational->new(1, 4), Rational->new(1, 2)],
							[Rational->new(-1, 2), Rational->new(-1, 4)]);

	my @false_test_cases = ([Rational->new(1, 2), Rational->new()],
							[Rational->new(), Rational->new(-1, 2)],
							[Rational->new(1, 2), Rational->new(-1, 2)],
							[Rational->new(1, 2), Rational->new(1, 4)],
							[Rational->new(-1, 4), Rational->new(-1, 2)]);

	foreach my $row (@true_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		
		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=True)";
		ok($row->[0] <= $row->[1], $message);
	}
	
	foreach my $row (@false_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);

		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=False)";
		ok(!($row->[0] <= $row->[1]), $message);
	}
}
test_le;

sub test_eq {
	my $function_name = (caller(0))[3];

	my @true_test_cases = ([Rational->new(), Rational->new()],
							[Rational->new(-1, 2), Rational->new(1, -2)],
							[Rational->new(1, 2), Rational->new(2, 4)]);

	my @false_test_cases = ([Rational->new(-1, 2), Rational->new()],
							[Rational->new(), Rational->new(1, 2)],
							[Rational->new(1, 2), Rational->new()],
							[Rational->new(), Rational->new(-1, 2)],
							[Rational->new(-1, 2), Rational->new(1, 2)],
							[Rational->new(1, 4), Rational->new(1, 2)],
							[Rational->new(-1, 2), Rational->new(-1, 4)],
							[Rational->new(1, 2), Rational->new(-1, 2)],
							[Rational->new(1, 2), Rational->new(1, 4)],
							[Rational->new(-1, 4), Rational->new(-1, 2)]);

	foreach my $row (@true_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
	
		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=True)";
		ok($row->[0] == $row->[1], $message);
	}
	
	foreach my $row (@false_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
	
		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=False)";
		ok(!($row->[0] == $row->[1]), $message);
	}
}
test_eq;

sub test_ne {
	my $function_name = (caller(0))[3];

	my @true_test_cases = ([Rational->new(-1, 2), Rational->new()],
							[Rational->new(), Rational->new(1, 2)],
							[Rational->new(1, 2), Rational->new()],
							[Rational->new(), Rational->new(-1, 2)],
							[Rational->new(-1, 2), Rational->new(1, 2)],
							[Rational->new(1, 4), Rational->new(1, 2)],
							[Rational->new(-1, 2), Rational->new(-1, 4)],
							[Rational->new(1, 2), Rational->new(-1, 2)],
							[Rational->new(1, 2), Rational->new(1, 4)],
							[Rational->new(-1, 4), Rational->new(-1, 2)]);

	my @false_test_cases = ([Rational->new(), Rational->new()],
							[Rational->new(-1, 2), Rational->new(1, -2)],
							[Rational->new(1, 2), Rational->new(2, 4)]);

	foreach my $row (@true_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
	
		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=True)";
		ok($row->[0] != $row->[1], $message);
	}
	
	foreach my $row (@false_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
	
		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=False)";
		ok(!($row->[0] != $row->[1]), $message);
	}
}
test_ne;

sub test_ge {
	my $function_name = (caller(0))[3];

	my @true_test_cases = ([Rational->new(), Rational->new()],
							[Rational->new(1, 2), Rational->new()],
							[Rational->new(), Rational->new(-1, 2)],
							[Rational->new(-1, 2), Rational->new(1, -2)],
							[Rational->new(1, 2), Rational->new(2, 4)],
							[Rational->new(1, 2), Rational->new(-1, 2)],
							[Rational->new(1, 2), Rational->new(1, 4)],
							[Rational->new(-1, 4), Rational->new(-1, 2)]);

	my @false_test_cases = ([Rational->new(-1, 2), Rational->new()],
							[Rational->new(), Rational->new(1, 2)],
							[Rational->new(-1, 2), Rational->new(1, 2)],
							[Rational->new(1, 4), Rational->new(1, 2)],
							[Rational->new(-1, 2), Rational->new(-1, 4)]);
						
	foreach my $row (@true_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
	
		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=True)";
		ok($row->[0] >= $row->[1], $message);
	}
	
	foreach my $row (@false_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
	
		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=False)";
		ok(!($row->[0] >= $row->[1]), $message);
	}
}
test_ge;

sub test_gt {
	my $function_name = (caller(0))[3];

	my @true_test_cases = ([Rational->new(1, 2), Rational->new()],
							[Rational->new(), Rational->new(-1, 2)],
							[Rational->new(1, 2), Rational->new(-1, 2)],
							[Rational->new(1, 2), Rational->new(1, 4)],
							[Rational->new(-1, 4), Rational->new(-1, 2)]);

	my @false_test_cases = ([Rational->new(), Rational->new()],
							[Rational->new(-1, 2), Rational->new()],
							[Rational->new(), Rational->new(1, 2)],
							[Rational->new(-1, 2), Rational->new(1, -2)],
							[Rational->new(1, 2), Rational->new(2, 4)],
							[Rational->new(-1, 2), Rational->new(1, 2)],
							[Rational->new(1, 4), Rational->new(1, 2)],
							[Rational->new(-1, 2), Rational->new(-1, 4)]);
						
	foreach my $row (@true_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
	
		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=True)";
		ok($row->[0] > $row->[1], $message);
	}
	
	foreach my $row (@false_test_cases) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		
		my $message = "Test $function_name: (r1=$r1, r2=$r2, result=False)";
		ok(!($row->[0] > $row->[1]), $message);
	}
}
test_gt;

sub test_add_type_error {
	my $function_name = (caller(0))[3];

	my $r = Rational->new();
	my $t;
	eval { $t = $r + 1.2 };
	ok($@ ne '', "Test $function_name");
}
test_add_type_error;

sub test_add {
	my $function_name = (caller(0))[3];
	
	my @add_test_values = ([Rational->new(), Rational->new(1, 2), Rational->new(1, 2)],
							[Rational->new(1, 2), Rational->new(), Rational->new(1, 2)],
							[Rational->new(1, 2), Rational->new(1, 2), Rational->new(1, 1)],
							[Rational->new(1, 2), Rational->new(-1, 2), Rational->new(0, 1)],
							[Rational->new(1, 4), Rational->new(2, 4), Rational->new(3, 4)],
							[Rational->new(1, 4), Rational->new(3, 4), Rational->new(1, 1)],
							[Rational->new(1, 4), Rational->new(-3, 4), Rational->new(-1, 2)],
							[Rational->new(1, 2), Rational->new(1, 3), Rational->new(5, 6)],
							[Rational->new(2), -1, Rational->new(1)],
							[Rational->new(2), 1, Rational->new(3)]);

	foreach my $row (@add_test_values) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		my $r3 = repr($row->[2]);
	
		my $r = $row->[0] + $row->[1];
		my $message = "Test $function_name: (r1=$r1, r2=$r2, expected_r=$r3)";
		ok($row->[2] == $r, $message);
	}
}
test_add;

sub test_sub_type_error {
	my $function_name = (caller(0))[3];

	my $r = Rational->new();
	my $t;
	eval { $t = $r - 1.2 };
	ok($@ ne '', "Test $function_name");
}
test_sub_type_error;

sub test_sub {
	my $function_name = (caller(0))[3];
	
	my @sub_test_values = ([Rational->new(), Rational->new(1, 2), Rational->new(-1, 2)],
							[Rational->new(1, 2), Rational->new(), Rational->new(1, 2)],
							[Rational->new(1, 2), Rational->new(1, 2), Rational->new(0, 1)],
							[Rational->new(1, 2), Rational->new(-1, 2), Rational->new(1, 1)],
							[Rational->new(1, 4), Rational->new(2, 4), Rational->new(-1, 4)],
							[Rational->new(1, 4), Rational->new(3, 4), Rational->new(-1, 2)],
							[Rational->new(1, 4), Rational->new(-3, 4), Rational->new(1, 1)],
							[Rational->new(1, 2), Rational->new(1, 3), Rational->new(1, 6)],
							[Rational->new(2), -1, Rational->new(3)],
							[Rational->new(2), 1, Rational->new(1)]);

	foreach my $row (@sub_test_values) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		my $r3 = repr($row->[2]);
	
		my $r = $row->[0] - $row->[1];
		my $message = "Test $function_name: (r1=$r1, r2=$r2, expected_r=$r3)";
		ok($row->[2] == $r, $message);
	}
}
test_sub;

sub test_mul_type_error {
	my $function_name = (caller(0))[3];

	my $r = Rational->new();
	my $t;
	eval { $t = $r * 1.2 };
	ok($@ ne '', "Test $function_name");
}
test_mul_type_error;

sub test_mul {
	my $function_name = (caller(0))[3];
	
	my @mul_test_values = ([Rational->new(), Rational->new(1, 2), Rational->new()],
							[Rational->new(1, 2), Rational->new(), Rational->new()],
							[Rational->new(1, 2), Rational->new(1, 2), Rational->new(1, 4)],
							[Rational->new(1, 2), Rational->new(-1, 2), Rational->new(-1, 4)],
							[Rational->new(1, 4), Rational->new(2, 4), Rational->new(1, 8)],
							[Rational->new(1, 4), Rational->new(3, 4), Rational->new(3, 16)],
							[Rational->new(1, 4), Rational->new(-3, 4), Rational->new(-3, 16)],
							[Rational->new(1, 2), Rational->new(1, 3), Rational->new(1, 6)],
							[Rational->new(2), 1, Rational->new(2)],
							[Rational->new(2), -1, Rational->new(-2)]);

	foreach my $row (@mul_test_values) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		my $r3 = repr($row->[2]);
		
		my $r = $row->[0] * $row->[1];
		my $message = "Test $function_name: (r1=$r1, r2=$r2, expected_r=$r3)";
		ok($row->[2] == $r, $message);
	}
}
test_mul;

sub test_div_zero_division_error {
	my $function_name = (caller(0))[3];

	my $r1 = Rational->new(1, 2);
	my $r2 = Rational->new();
	my $r;
	eval { $r = $r1 / $r2 };
	ok($@ ne '', "Test $function_name");
}
test_div_zero_division_error;

sub test_div_type_error {
	my $function_name = (caller(0))[3];

	my $r = Rational->new();
	my $t;
	eval { $t = $r / 1.2 };
	ok($@ ne '', "Test $function_name");
}
test_div_type_error;

sub test_div {
	my $function_name = (caller(0))[3];
	
	my @div_test_values = ([Rational->new(), Rational->new(1, 2), Rational->new()],
							[Rational->new(1, 2), Rational->new(1, 2), Rational->new(1, 1)],
							[Rational->new(1, 2), Rational->new(-1, 2), Rational->new(-1, 1)],
							[Rational->new(1, 4), Rational->new(2, 4), Rational->new(1, 2)],
							[Rational->new(1, 4), Rational->new(3, 4), Rational->new(1, 3)],
							[Rational->new(1, 4), Rational->new(-3, 4), Rational->new(-1, 3)],
							[Rational->new(1, 2), Rational->new(1, 3), Rational->new(3, 2)],
							[Rational->new(2), 1, Rational->new(2)],
							[Rational->new(2), -1, Rational->new(-2)]);

	foreach my $row (@div_test_values) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		my $r3 = repr($row->[2]);
	
		my $r = $row->[0] / $row->[1];
		my $message = "Test $function_name: (r1=$r1, r2=$r2, expected_r=$r3)";
		ok($row->[2] == $r, $message);
	}
}
test_div;

sub test_pow_zero_division_error {
	my $function_name = (caller(0))[3];

	my $r = Rational->new();
	my $r_repr = repr($r);
	foreach (-3..-1) {
		eval { $r = $r ** $_ };
		ok($@ ne '', "Test $function_name: (r=$r_repr, power=$_)");
	}
}
test_pow_zero_division_error;

sub test_pow_type_error {
	my $function_name = (caller(0))[3];

	my $r = Rational->new();
	my $t;
	eval { $t = $r ** 1.2 };
	ok($@ ne '', "Test $function_name");
}
test_pow_type_error;

sub test_pow {
	my $function_name = (caller(0))[3];
	
	my @pow_test_values = ([Rational->new(), 0, Rational->new()],
							[Rational->new(), 1, Rational->new()],
							[Rational->new(), 2, Rational->new()],
							[Rational->new(), 3, Rational->new()],

							[Rational->new(1, 2), -3, Rational->new(8, 1)],
							[Rational->new(1, 2), -2, Rational->new(4, 1)],
							[Rational->new(1, 2), -1, Rational->new(2, 1)],
							[Rational->new(1, 2), 0, Rational->new(1, 1)],
							[Rational->new(1, 2), 1, Rational->new(1, 2)],
							[Rational->new(1, 2), 2, Rational->new(1, 4)],
							[Rational->new(1, 2), 3, Rational->new(1, 8)],

							[Rational->new(-1, 2), -3, Rational->new(-8, 1)],
							[Rational->new(-1, 2), -2, Rational->new(4, 1)],
							[Rational->new(-1, 2), -1, Rational->new(-2, 1)],
							[Rational->new(-1, 2), 0, Rational->new(1, 1)],
							[Rational->new(-1, 2), 1, Rational->new(-1, 2)],
							[Rational->new(-1, 2), 2, Rational->new(1, 4)],
							[Rational->new(-1, 2), 3, Rational->new(-1, 8)],

							[Rational->new(1, 3), -3, Rational->new(27, 1)],
							[Rational->new(1, 3), -2, Rational->new(9, 1)],
							[Rational->new(1, 3), -1, Rational->new(3, 1)],
							[Rational->new(1, 3), 0, Rational->new(1, 1)],
							[Rational->new(1, 3), 1, Rational->new(1, 3)],
							[Rational->new(1, 3), 2, Rational->new(1, 9)],
							[Rational->new(1, 3), 3, Rational->new(1, 27)],

							[Rational->new(-1, 3), -3, Rational->new(-27, 1)],
							[Rational->new(-1, 3), -2, Rational->new(9, 1)],
							[Rational->new(-1, 3), -1, Rational->new(-3, 1)],
							[Rational->new(-1, 3), 0, Rational->new(1, 1)],
							[Rational->new(-1, 3), 1, Rational->new(-1, 3)],
							[Rational->new(-1, 3), 2, Rational->new(1, 9)],
							[Rational->new(-1, 3), 3, Rational->new(-1, 27)]);

	foreach my $row (@pow_test_values) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		my $r3 = repr($row->[2]);
	
		my $r = $row->[0] ** $row->[1];
		my $message = "Test $function_name: (r1=$r1, power=$r2, expected_r=$r3)";
		ok($row->[2] == $r, $message);
	}
}
test_pow;

sub test_radd_type_error {
	my $function_name = (caller(0))[3];

	my $r = Rational->new();
	my $t;
	eval { $t = 1.2 + $r };
	ok($@ ne '', "Test $function_name");
}
test_radd_type_error;

sub test_radd {
	my $function_name = (caller(0))[3];
	
	my @radd_test_values = ([1, Rational->new(1, 2), Rational->new(3, 2)],
							[1, Rational->new(), Rational->new(1, 1)],
							[-1, Rational->new(1, 2), Rational->new(-1, 2)],
							[1, Rational->new(-1, 2), Rational->new(1, 2)],
							[1, Rational->new(2, 4), Rational->new(3, 2)],
							[1, Rational->new(3, 4), Rational->new(7, 4)],
							[1, Rational->new(-3, 4), Rational->new(1, 4)],
							[1, Rational->new(1, 3), Rational->new(4, 3)]);

	foreach my $row (@radd_test_values) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		my $r3 = repr($row->[2]);
	
		my $r = $row->[0] + $row->[1];
		my $message = "Test $function_name: (r1=$r1, r2=$r2, expected_r=$r3)";
		ok($row->[2] == $r, $message);
	}
}
test_radd;

sub test_rsub_type_error {
	my $function_name = (caller(0))[3];

	my $r = Rational->new();
	my $t;
	eval { $t = 1.2 - $r };
	ok($@ ne '', "Test $function_name");
}
test_rsub_type_error;

sub test_rsub {
	my $function_name = (caller(0))[3];
	
	my @rsub_test_values = ([1, Rational->new(1, 2), Rational->new(1, 2)],
							[1, Rational->new(), Rational->new(1, 1)],
							[-1, Rational->new(1, 2), Rational->new(-3, 2)],
							[1, Rational->new(-1, 2), Rational->new(3, 2)],
							[1, Rational->new(2, 4), Rational->new(1, 2)],
							[1, Rational->new(3, 4), Rational->new(1, 4)],
							[1, Rational->new(-3, 4), Rational->new(7, 4)],
							[1, Rational->new(1, 3), Rational->new(2, 3)]);

	foreach my $row (@rsub_test_values) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		my $r3 = repr($row->[2]);
	
		my $r = $row->[0] - $row->[1];
		my $message = "Test $function_name: (r1=$r1, r2=$r2, expected_r=$r3)";
		ok($row->[2] == $r, $message);
	}
}
test_rsub;

sub test_rmul_type_error {
	my $function_name = (caller(0))[3];

	my $r = Rational->new();
	my $t;
	eval { $t = 1.2 * $r };
	ok($@ ne '', "Test $function_name");
}
test_rmul_type_error;

sub test_rmul {
	my $function_name = (caller(0))[3];
	
	my @rmul_test_values = ([1, Rational->new(1, 2), Rational->new(1, 2)],
							[1, Rational->new(), Rational->new(0, 1)],
							[-1, Rational->new(1, 2), Rational->new(-1, 2)],
							[1, Rational->new(-1, 2), Rational->new(-1, 2)],
							[1, Rational->new(2, 4), Rational->new(1, 2)],
							[1, Rational->new(3, 4), Rational->new(3, 4)],
							[1, Rational->new(-3, 4), Rational->new(-3, 4)],
							[1, Rational->new(1, 3), Rational->new(1, 3)]);

	foreach my $row (@rmul_test_values) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		my $r3 = repr($row->[2]);
	
		my $r = $row->[0] * $row->[1];
		my $message = "Test $function_name: (r1=$r1, r2=$r2, expected_r=$r3)";
		ok($row->[2] == $r, $message);
	}
}
test_rmul;

sub test_rdiv_zero_division_error {
	my $function_name = (caller(0))[3];

	my $r1 = Rational->new();
	my $r;
	eval { $r = 1 / $r1 };
	ok($@ ne '', "Test $function_name");
}
test_rdiv_zero_division_error;

sub test_rdiv_type_error {
	my $function_name = (caller(0))[3];

	my $r = Rational->new();
	my $t;
	eval { $t = 1.2 / $r};
	ok($@ ne '', "Test $function_name");
}
test_rdiv_type_error;

sub test_rdiv {
	my $function_name = (caller(0))[3];
	
	my @rdiv_test_values = ([1, Rational->new(1, 2), Rational->new(2, 1)],
							[-1, Rational->new(1, 2), Rational->new(-2, 1)],
							[1, Rational->new(-1, 2), Rational->new(-2, 1)],
							[1, Rational->new(2, 4), Rational->new(2, 1)],
							[1, Rational->new(3, 4), Rational->new(4, 3)],
							[1, Rational->new(-3, 4), Rational->new(-4, 3)],
							[1, Rational->new(1, 3), Rational->new(3, 1)]);

	foreach my $row (@rdiv_test_values) {
		my $r1 = repr($row->[0]);
		my $r2 = repr($row->[1]);
		my $r3 = repr($row->[2]);
	
		my $r = $row->[0] / $row->[1];
		my $message = "Test $function_name: (r1=$r1, r2=$r2, expected_r=$r3)";
		ok($row->[2] == $r, $message);
	}
}
test_rdiv;

sub test_rpow_zero_division_error {
	my $function_name = (caller(0))[3];

	my $base = 0;
	foreach (-3..-1) {
		my $power = Rational->new(1, $_);
		my $power_repr = repr($power);
		
		my $r;
		eval { $r = $base ** $power };
		ok($@ ne '', "Test $function_name: (base=$base, power=$power_repr)");
	}
}
test_rpow_zero_division_error;

sub test_rpow_value_error {
	my $function_name = (caller(0))[3];

	my @rpow_test_values = ([-2, Rational->new(1, 2)],
							[-1, Rational->new(1, 2)],
							[-3, Rational->new(-1, 2)],
							[-2, Rational->new(-1, 2)],
							[-1, Rational->new(-1, 2)],
							[-3, Rational->new(1, 3)],
							[-2, Rational->new(1, 3)],
							[-1, Rational->new(1, 3)],
							[-3, Rational->new(-1, 3)],
							[-2, Rational->new(-1, 3)],
							[-1, Rational->new(-1, 3)]);

	foreach my $row (@rpow_test_values) {
		my $power_repr = repr($row->[1]);
		
		my $r;
		my $message = "Test $function_name: (base=$row->[0], power=$power_repr)";
		eval { $r = $row->[0] ** $row->[1] };
		ok($@ ne '', "Test $function_name");
	}
}
test_rpow_value_error;

sub test_rpow {
	my $function_name = (caller(0))[3];
	
	my @rpow_test_values = ([0, Rational->new(), 1],
							[1, Rational->new(), 1],
							[2, Rational->new(), 1],
							[3, Rational->new(), 1],

							[0, Rational->new(1, 2), 0],
							[1, Rational->new(1, 2), 1],
							[2, Rational->new(1, 2), 1.4142135623730951],
							[3, Rational->new(1, 2), 1.7320508075688772],

							[1, Rational->new(-1, 2), 1],
							[2, Rational->new(-1, 2), 0.7071067811865476],
							[3, Rational->new(-1, 2), 0.5773502691896257],

							[0, Rational->new(1, 3), 0],
							[1, Rational->new(1, 3), 1],
							[2, Rational->new(1, 3), 1.2599210498948732],
							[3, Rational->new(1, 3), 1.4422495703074083],

							[1, Rational->new(-1, 3), 1],
							[2, Rational->new(-1, 3), 0.7937005259840998],
							[3, Rational->new(-1, 3), 0.6933612743506348],

							[-1, Rational->new(1), -1],
							[-2, Rational->new(1), -2],
							[-1, Rational->new(-1), -1],
							[-2, Rational->new(-2), 0.25]);

	foreach my $row (@rpow_test_values) {
		my $power_repr = repr($row->[1]);
		
		my $r = $row->[0] ** $row->[1];
		my $message = "Test $function_name: (base=$row->[0], power=$power_repr, expected_power=$row->[2])";
		ok($row->[2] == $r, $message);
	}
}
test_rpow;

1;
