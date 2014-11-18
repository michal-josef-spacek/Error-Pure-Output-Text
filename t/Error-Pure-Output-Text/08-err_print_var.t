# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Pure::Output::Text qw(err_print_var);
use Test::More 'tests' => 9;
use Test::NoWarnings;

# Test.
my @errors = (
	{
		'msg' => ['Error.'],
		'stack' => [
			{
				'args' => '(\'Error.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
		],
	},
);
my $right_ret = <<"END";
ERROR: Error.
END
my $ret = err_print_var(\@errors, 'ERROR');
is($ret, $right_ret, 'Print in simple error (scalar mode).');

# Test.
my @right_ret = (
	'ERROR: Error.',
);
my @ret = err_print_var(\@errors, 'ERROR');
is_deeply(
	\@ret,
	\@right_ret,
	'Print in simple error (array mode).',
);

# Test.
@errors = (
	{
		'msg' => ['Error.'],
		'stack' => [
			{
				'args' => '(\'Error.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
			{
				'args' => '',
				'class' => 'main',
				'line' => '10',
				'prog' => './example.pl',
				'sub' => 'eval {...}',	
			},
		],
	},
);
$right_ret = <<"END";
ERROR: Error.
END
$ret = err_print_var(\@errors, 'ERROR');
is($ret, $right_ret, 'Print in complicated error.');

# Test.
@errors = (
	{
		'msg' => ['Error 1.'],
		'stack' => [
			{
				'args' => '(\'Error 1.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
			{
				'args' => '',
				'class' => 'main',
				'line' => '10',
				'prog' => './example.pl',
				'sub' => 'eval {...}',	
			},
		],
	},
	{
		'msg' => ['Error 2.'],
		'stack' => [
			{
				'args' => '(\'Error 2.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
			{
				'args' => '',
				'class' => 'main',
				'line' => '10',
				'prog' => './example.pl',
				'sub' => 'eval {...}',	
			},
		],
	},
);
$right_ret = <<"END";
ERROR: Error 1.
END
$ret = err_print_var(\@errors, 'ERROR');
is($ret, $right_ret, 'Print in more errors.');

# Test.
@errors = (
	{
		'msg' => [
			'Error.',
			'first', 0,
			'second', -1,
			'third', 1,
			'fourth', undef,
		],
		'stack' => [
			{
				'args' => '(\'Error.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
		],
	},
);
$right_ret = <<"END";
ERROR: Error.
first: 0
second: -1
third: 1
fourth
END
$ret = err_print_var(\@errors, 'ERROR');
is($ret, $right_ret, 'Print in different key=value pairs.');

# Test.
@errors = (
	{
		'msg' => ['Error.', undef],
		'stack' => [
			{
				'args' => '(\'Error.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
		],
	},
);
$right_ret = <<"END";
ERROR: Error.
END
$ret = err_print_var(\@errors, 'ERROR');
is($ret, $right_ret, 'Print in simple error with undef value.');

# Test.
@errors = (
	{
		'msg' => ['Error.', undef],
		'stack' => [
			{
				'args' => '(\'Error.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
		],
	},
);
$right_ret = <<"END";
Error.
END
$ret = err_print_var(\@errors);
is($ret, $right_ret, 'Print in simple error with undef value without title.');
