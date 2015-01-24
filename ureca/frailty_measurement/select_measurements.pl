use warnings;
use Lingua::EN::Sentence qw(get_sentences);
use Unicode::Normalize 'normalize';

binmode(STDOUT, ":utf8");

$filename = "selectedSentence.txt";
open FILE, "<:encoding(utf-8)", $filename or die "can't find file ".$filename;
while ($readinline = <FILE>) {
    if ($readinline =~ /^\n/ or $readinline !~ /^MEASUREMENT/) {
        next;
    }
    $measurements = $readinline;
    while ($readinline = <FILE>) {
        if ($readinline =~ /^[A-Z]{4,13}:/ or $readinline =~ /^\n/) {
            last;
        }
        $measurements .= $readinline;
    }

    print "$measurements"."\n\n";
}
