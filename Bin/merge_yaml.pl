#!/usr/bin/env perl

use strict; use warnings;
use YAML::XS qw /LoadFile Dump/;
use Hash::Merge qw/merge/;

my $orig = shift;
my $main_hash = LoadFile $orig;
Hash::Merge::set_behavior('STORAGE_PRECEDENT');

foreach my $file (@ARGV){
	if (-e $file){
		my $new_hash = LoadFile $file;
		$main_hash = merge($main_hash,$new_hash);
	}
	else {
		warn "Missing file: '$file'";
	}
}

print Dump $main_hash;

