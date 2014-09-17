use warnings;
use Lingua::EN::Sentence qw(get_sentences);

binmode(STDOUT, ":utf8");

$filename = "myFormat.txt";
open FILE, "<:encoding(utf-8)", $filename or die "can't find file ".$filename;

while ($readinline = <FILE>) {
    if ($readinline =~ /^\n/) {
        next;
    }
    $PMID = $readinline;
    $readinline = <FILE>; #title here
    $readinline = <FILE>; #empty line
    $abstract = <FILE>;

    chomp($abstract);
    $counter = 0;
    my $sref = get_sentences($abstract);
    $useful = "";
    foreach my $sentence (@$sref) {
        #$sentence = normalize $sentence
        if ($sentence =~ /^((?!heart rate).)*$|^((?!age).)*$/gi) {
            ;
        } else {
            $counter += 1;
            $useful .= $sentence . "\n";
        }
    }
    if ($counter > 0) {
        print "$PMID" . $useful . "\n";
    }
}