use warnings;

$filename = "pubmed_result.txt";
open FILE, $filename or die "can't find file ".$filename;
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
    
    while ($readinline = <FILE>) {
        if ($readinline =~ /^\n/) {
            last;
        }
    }
    
    #here comes the abstract
    $abstract = "Abstract";
    while ($readinline = <FILE>) {
        if ($readinline=~ /^\n/) {
            last;
        }
        $readinline =~ s/\R//g; #remove last newline
        $abstract .= $readinline;
    }

    #PMID
    $readinline = <FILE>;
    $readinline =~ /PMID: (\d+)/;
    $pmid = $1;
    print "PMID - $pmid\n";
    print $title . "\n" . $abstract . "\n"; 
}
