#!/usr/bin/env perl
use strict;
use warnings;
use Linux::Smaps;

@ARGV or die "usage: %0 [pid ...]";

printf "PID\tRSS\tSHARED\n";

for my $pid (@ARGV) {
    my $map = Linux::Smaps->new($pid);
    unless ($map) {
        warn $!;
        next;
    }

    printf
        "%d\t%d\t%d (%d%%)\n",
        $pid,
        $map->rss,
        $map->shared_dirty + $map->shared_clean,
        int((($map->shared_dirty + $map->shared_clean) / $map->rss) * 100)
}
