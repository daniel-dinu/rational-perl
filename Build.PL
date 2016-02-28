use strict;
use warnings;


use Module::Build;


my $builder = Module::Build->new(
	module_name         => 'Rational',
	license             => 'perl',
	dist_abstract       => 'Support for rational numbers',
	dist_author         => 'Daniel Dinu <dumitru-daniel.dinu@uni.lu>'
);


$builder->create_build_script();
