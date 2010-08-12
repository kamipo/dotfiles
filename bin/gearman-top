#!/usr/bin/perl
use strict;
use warnings;
use IO::Socket::INET;
use Getopt::Long;

my $port = 7003;
my $host = '127.0.0.1';
my $timeout = 10;

GetOptions(
    'port=i'    => \$port,
    'host=s'    => \$host,
    'timeout=i' => \$timeout,
);

my $cmd = join q{ }, @ARGV;
my $interval_sec = 1;

print "HOST: $host\n";
print "PORT: $port\n";
print "CMD: $cmd\n";

while (1) {
    print "\033[2J"; # flush screen
    my $sock = IO::Socket::INET->new(
        PeerAddr => $host,
        PeerPort => $port,
        Timeout  => $timeout,
    ) or die "cannot connect to $host:$port";
    $sock->autoflush(1);

    $sock->write($cmd . "\r\n");
    my $out;
    INNER: while ( defined ( my $line = <$sock> ) ) {
        chomp $line;
        if ( $line eq "." ) {
            last INNER;
        }
        $out .= "$line\n";
    }
    print $out;

    $sock->close;

    sleep($interval_sec);
}
