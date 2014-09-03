#!/usr/bin/perl
use strict;
use warnings;
use LWP 5.64;
use POSIX ('strftime');
my $browser = LWP::UserAgent->new;

my $last_month = strftime("y%Y-m%m", localtime(time - 3*24 * 60 * 60));
# Since today is the first, one day ago (24*60*60 seconds) is in
#  last month.
my $url = "http://www.unicode.org/mail-arch/unicode-ml/$last_month/";

=pop
$browser->credentials(
    'sso.wis.ntu.edu.sg:443',
    'https://sso.wis.ntu.edu.sg',
    'slu001' => 'ilovehyy3'
    );
=cut
$browser->credentials(
    'www.unicode.org:80',
    'Unicode-MailList-Archives',
    'unicode-ml' => 'unicode'
    );

#my $url = 'https://sso.wis.ntu.edu.sg/webexe88/ntlm/sso_express.asp?app=https://wish.wis.ntu.edu.sg/pls/webexe/aus_stars_planner.main';

print "Getting topics for last month, $last_month\n",
    " from $url\n";
my $response = $browser->get($url);
die "Error getting $url: ", $response->status_line
    if $response->is_error;
$response = $browser->get($url);
print $response->content;

=pop
my $req =  HTTP::Request->new(GET => "https://sso.wis.ntu.edu.sg/webexe88/ntlm/sso_express.asp?app=https://wish.wis.ntu.edu.sg/pls/webexe/aus_stars_planner.main";)
$req->authorization_basic( "slu001", "ilovehyy3" );
my $page = $browser->request($req);
if ($page->is_success) {
    print $page->content;
} else {
    print "ERROR";
}
=cut
#print $req->is_success;
