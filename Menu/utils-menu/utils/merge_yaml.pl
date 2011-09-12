#!/usr/bin/perl -ws

use strict; use warnings;
use YAML::XS;
use Data::Dumper;

my $orig = shift;
my $main_hash = yaml2dic($orig);

foreach my $file (@ARGV){
	if (-e $file){
		my $new_hash = yaml2dic($file);
		$main_hash = merge_hashes($main_hash,$new_hash);
	}
	else {
		warn "Missing file: '$file'";
	}
}

dic2yaml($main_hash);
	

sub dic2yaml {
	my $paths = shift;
	my $hash = {};
	foreach my $path (sort keys %$paths){
		my $value = $paths->{$path};
		my @elems = split /:#:/,$path;
		my $last_elem = pop @elems;
		my $tmp_hash = $hash;
		foreach my $tmp_elem (@elems){
			$tmp_hash->{$tmp_elem} = {} unless (defined($tmp_hash->{$tmp_elem}) and ref($tmp_hash->{$tmp_elem}) eq 'HASH');
			$tmp_hash = $tmp_hash->{$tmp_elem};
		}
		$tmp_hash->{$last_elem} = $value;	
	}
	print Dump($hash);
}

sub merge_hashes {
	my ($hash1,$hash2) = @_;
	#return (%$hash1,%$hash2);
	@$hash1{keys %$hash2} = values %$hash2;
	return $hash1;
}

sub yaml2dic {
	my $file = shift;
	my $hash = YAML::XS::LoadFile($file);
	my $paths = {};
	hash2dic('',$paths,$hash);
	return $paths;
}

sub hash2dic {
    my ($prev_path,$paths,$hash) = @_;
    if (ref($hash) eq 'HASH'){
        foreach my $key (keys %$hash){
            my $newpath = $prev_path ne '' ?  "$prev_path:#:$key" : $key;
            hash2dic($newpath,$paths,$hash->{$key});
        }
    }
    else {
        $paths->{$prev_path} = $hash;
    }
}


