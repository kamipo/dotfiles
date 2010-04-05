use inc::Module::Install;
name '[% dist %]';
all_from 'lib/[% module_path %].pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More' => 0.88; # done_testing()
use_test_base;
auto_include;
WriteAll;
