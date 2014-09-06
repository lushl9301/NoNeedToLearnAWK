#!/usr/bin/perl

use strict;
use warnings;

my $str = '111asdfasdfevxcvwqer';
$str =~ tr/a-z/A-Z/;

print $str . "\n";
