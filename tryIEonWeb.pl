#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use LWP::Simple;

my $ua = LWP::UserAgent->new;
$ua->agent("$0/0.1 " . $ua->agent);

my $req = new HTTP::Request 'GET' => 'http://github.com';
$req->header('Accept' => 'text/html');

# send request
my $res = $ua->request($req);

print "$res\n";

my $catalog = get("http://shop.oreilly.com/");
die "Couldn't get it?!" unless $catalog;
my $count = 0;
$count++ while $catalog =~ m/Perl/gi;
print "$count\n";
