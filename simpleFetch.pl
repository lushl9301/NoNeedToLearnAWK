#!/usr/bin/perl
use strict;
use warnings;
use LWP::Simple;

my $url = 'https://www.google.com.sg/?gws_rd=ssl';
my $content = get($url);
die "Couldn't get $url" unless (defined $content);
#ma de. This kind of syntex lets who to survive
my $ss = $content;

if ($content =~ m/feeling/i) {
    print "There're talking about feeling\n";
} else {
    print "no no no";
}

my $s = ($ss =~ s/feeling//gi);
print $s . "\n";
