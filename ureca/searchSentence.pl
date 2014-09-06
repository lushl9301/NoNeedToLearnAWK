sub searchPattern {
    $pmid = $_[0];
    @sentences = split(/\. /, $_[1]);
    chomp @sentences;
    $pattern = $_[2];
    foreach (@sentences){
        if ($_=~/$pattern/){
            print "\n>PMID-$pmid\n$_.\n";
        }
    }
}

$filename = "heart.rate.normative.txt";
$query = "heart rate";

open FILE, $filename or die "can't find file ".$filename;
while ($readinline = <FILE>) {
    $readinline =~ s/\R//g; #remove last newline
    if ($readinline = ~ /PMID- (\d+)/) {
        $pmid = $1;
        #print "\n>PMID  $pmid\n";
    } elsif ($readinline = ~/^AB  -(.*)$/) {
        $abstract = $1;
        $abstract =~ s/^\s//g;
        $ab_start = 1;

    } elsif ($ab_start == 1 && $readinline = ~/^    /) {
        $readinline =~ s/^\s+//;
        $abstract .= $readinline;
    } elsif ($ab_start == 1 && $readinline = ~/^\u+/) {
        $ab_start=0;
        &searchPattern($pmid, $abstract,$query);
    } elsif($readinline = ~/^TI  -(.*)$/) {
        $title = "Title -" . $1;
        $ti_start = 1;
    } elsif ($ti_start == 1 && $readinline = ~/^    /) {
        $readinline =~ s/^\s+/ /;
        $title .= $readinline;
    } elsif ($ti_start == 1 && $readinline = ~/^\u+/) {
        $ti_start = 0;
        &searchPattern($pmid, $title,$query);
    }
}