use strict;
use warnings;

use Email::MIME;
my $message = Email::MIME->create(
    header_str => [
	From => 'lushl9301@gmail.com',
	To => 'lushl9301@gmail.com',
	subject => 'happy',
    ],
    attributes => {
	encoding => 'quoted-printable',
	charset => 'ISO-8859-1',
    },
    body_str => 'mmm',
    );
use Email::Sender::Simple qw(sendmail);
sendmail($message);
