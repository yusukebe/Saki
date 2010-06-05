use inc::Module::Install;
name 'Saki';
all_from 'lib/Saki.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
