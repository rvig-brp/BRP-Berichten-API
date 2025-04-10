#!/usr/local/bin/perl

# Credits @Tux (https://github.com/Tux) for providing this script in https://github.com/rvig-brp/BRP-Berichten-API/pull/7

use 5.014002;
use warnings;
use autodie;

our $VERSION = "0.1 - 20250410";
our $CMD = $0 =~ s{.*/}{}r;

sub usage {
    my $err = shift and select STDERR;
    say "usage: $CMD schema.json file.json ...";
    exit $err;
    } # usage

use utf8;
use Text::CSV;
use JSON::XS;
use JSON::Schema::Modern;
use Term::ANSIColor qw(:constants colored);
use Getopt::Long    qw(:config bundling);
GetOptions (
    "help|?"        => sub { usage (0); },
    "V|version"        => sub { say "$CMD [$VERSION]"; exit 0; },

    "v|verbose:1"    => \(my $opt_v = 0),
    ) or usage (1);

my $schema_file = shift    or usage (1);
-s $schema_file            or usage (1);
my @jf = grep { -s } @ARGV or usage (1);

binmode STDOUT, ":encoding(utf-8)";
binmode STDERR, ":encoding(utf-8)";

my $schema = decode_json (do { local (@ARGV, $/) = ($schema_file); <> });

my $jsv = JSON::Schema::Modern->new;
my $result = $jsv->validate_schema ($schema);
$opt_v > 4 and DDumper $result;
unless ($result->valid) {
  warn "$schema_file is not a valid JSON Schema file:\n";
  foreach my $e ($result->errors) {
    if ($e->exception) {
      my $x = $e->error =~ s/^'':\s*//r;
      die " $x\n";
    }

    printf "%-20s %s\n%20s %s\n", $e->keyword // "?", $e->instance_location, "", $e->error;
  }
}

foreach my $jf (@jf) {
  $opt_v and warn "Using $schema_file to validate $jf using JSON::Schema::Modern-$JSON::Schema::Modern::VERSION\n";
  my $jstr = do { local (@ARGV, $/) = ($jf); <> };
  my $result = $jsv->evaluate_json_string ($jstr, $schema, { strict => 1 });
  if ($result->valid) {
    say colored ("\N{HEAVY CHECK MARK}", "green"), " $jf valididated";
    next;
  }
  $opt_v > 4 and DDumper $result;
  say colored ("\N{HEAVY MULTIPLICATION X}", "red"), " $jf did not validate";
  foreach my $e ($result->errors) {
    if ($e->exception) {
      my $x = $e->error =~ s/^'':\s*//r;
      say  "  X: ", $x;
      last;
    }
    say "  E: ", $e->error;
  }
}
