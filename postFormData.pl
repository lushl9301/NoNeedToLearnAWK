#!/usr/bin/perl
use strict;
use warnings;

use LWP 5.64;
my $word = shift;
$word or die "Usage: perl altavista_post.pl [keyword]\n";
my $browser = LWP::UserAgent->new;
my $url = 'http://search.yahoo.com/?fr=altavista';
my $response = $browser->post($url,
			      [ 'q' => $word,
				'pg' => 'q',
				'avkw' => 'tgz',
				'kl' => 'XX',
			      ]
    );
die "$url error: ", $response->status_line unless $response->is_success;
die "Weird content type at $url −− ", $response->content_type
    unless $response->content_type eq 'text/html';
#print $response->content;

if ($response->content =~ m/found ([0−9,]+) results/gi) {
    print "$word: [RETURN] $1\n";
} else {
    print "Couldn't find the match−string in the response\n";
}


#perl postFormData.pl [youWant2Search] > result.html
