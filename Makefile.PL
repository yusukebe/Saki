use inc::Module::Install;
name 'Saki';
all_from 'lib/Saki.pm';

requires 'Plack::Request';
requires 'Router::Simple';
requires 'UNIVERSAL::require';
requires 'Template';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
