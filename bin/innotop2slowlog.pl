#!/usr/bin/perl -w
use strict;
while (<>) {
    chop;
    my @row = split(" ", $_);
    printf ("# Time:\n# User\@Host: %s(%s) @ %s\n", $row[2], $row[2], $row[3]);
    my $i = 5;
    while ($row[$i] !~ /[0-9]{2}\:[0-9]{2}$/ && $i < $#row) { $i++;}
    printf ("# Query_time: %s Lock_time = x.x Rows_sent:x Rows_examined: x\n", $row[$i]);
    print join(" ", @row[($i+2)..$#row]) . "\;\n";
}
