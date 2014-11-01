use warnings;

binmode(STDOUT, ":utf8");

$filename = "selectedSentence.txt";
open FILE, "<:encoding(utf-8)", $filename or die "can't find file ".$filename;


open AGE_FILE, ">:encoding(utf-8)", "age.txt" or die "hahaha";

open AGELong_File, ">:encoding(utf-8)", "rubbish_info.txt" or die "hehehe";

open REST_FILE, ">:encoding(utf-8)", "non-age.txt" or die "hohoho";

while ($readinline = <FILE>) {
    $PMID = $readinline;
    my $abstract = "";
    while ($readinline = <FILE>) {
        if ($readinline =~ /^\n/) {
            last;
        }
        $abstract .= $readinline;
    }

    $pattern_age = '[\s, \W](age.+?\d+?.+?y)';
    $pattern_year = '(\d+?.+?year)';
    if ($abstract =~ /$pattern_age/i) {
        $tmp = $1;
        $s = "===========================\n";
        $toPrint = "$PMID".$s.$tmp."\n".$s.$abstract."\n";
        if ($tmp =~ /^.{5,26}$/) {
            printInto(AGE_FILE, $toPrint);
        } else {
            printInto(AGELong_File, $toPrint);
        }
    } elsif ($abstract =~ /$pattern_year/i) {
        $tmp = $1;
        $s = "===========================\n";
        $toPrint = "$PMID".$s.$tmp."\n".$s.$abstract."\n";
        if ($tmp =~ /^.{5,26}$/) {
            printInto(AGE_FILE, $toPrint);
        } else {
            printInto(AGELong_File, $toPrint);
        }
    } else {
        printInto(REST_FILE, "$PMID".$abstract."\n");
    }

}

close(AGE_FILE);


sub printInto {
    my ($fh, $str) = @_;
    print {$fh} "$str";
    # body...
}