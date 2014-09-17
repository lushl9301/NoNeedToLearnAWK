use warnings;
use Lingua::EN::Sentence qw(get_sentences);
use Unicode::Normalize 'normalize';

binmode(STDOUT, ":utf8");

$filename = "pubmed_result.txt";
open FILE, "<:encoding(utf-8)", $filename or die "can't find file ".$filename;
while ($readinline = <FILE>) {
    if ($readinline =~ /^\n/) {
        next;
    }
    if ($readinline =~ /^\d/) {
        while ($readinline = <FILE>) {
            if ($readinline =~ /^\n/) {
                last;
            }
        }
    }

    #title
    $readinline = <FILE>;
    $readinline =~ s/\R+//g;
    $title = "Title - " . $readinline;
    while ($readinline = <FILE>) {
        if ($readinline =~ /^\n/) {
            last;
        }
        $readinline =~ s/\R+//g;
        $title .= $readinline;
    }

    #author
    while ($readinline = <FILE>) {
        if ($readinline =~ /^\n/) {
            last;
        }
    }

    $abstract = "";
    $readinline = <FILE>;
    if ($readinline =~ /^Author/) {
        while ($readinline = <FILE>) {
            if ($readinline =~ /^\n/) {
                last;
            }
        }
    } else {
        #here comes the abstract
        $abstract .= $readinline;
    }

    while ($readinline = <FILE>) {
        if ($readinline=~ /^\n/) {
            last;
        }
        $readinline =~ s/\R//g; #remove last newline
        $abstract .= $readinline;
    }

    #PMID
    while ($readinline = <FILE>) {
        if ($readinline =~ /PMID: (\d+)/) {
            $pmid = $1;
            last;
        }
    }
    if ($title =~ /Title - \[/) {
        next;
    }
    print "PMID - $pmid\n";
    my $sref = get_sentences($abstract);
    foreach my $sentence (@$sref) {
        #$sentence = normalize $sentence
        if ($sentence =~ /heart rate[\w,\s]+age/gi) {
            print $sentence . "\n";
        }
    }
    print "\n\n";
    #print $title . "\n\n" . $abstract . "\n\n\n"; 
}
