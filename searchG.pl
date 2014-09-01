#!/usr/bin/perl
use strict;
use warnings;
use LWP 5.64;
use URI;

my $browser = LWP::UserAgent->new;
my $url = URI->new('http://www.google.com/search');

$url->query_form(
    'h1' => 'en',
    'num' => '100',
    'q' => 'three blind mice',
    );
#print $url;
my $response = $browser->get($url);
#print $response->content;
open(my $RESULT, '>searchGoogleResult.html');
print $RESULT $response->content;
close($RESULT);
#cannot be used now
#results showed in searchGoogleResult.html

