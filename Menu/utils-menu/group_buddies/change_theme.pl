#!/usr/bin/env perl 
use strict; use warnings;
use File::Basename;
use YAML::XS;
use Data::Dumper;

my ($repi_client_config, $themes_root, $site_files) = @ARGV;

$themes_root =~ s!/$!!;
$site_files =~ s!/$!!;
my $client_theme 		= get_theme_from_config($repi_client_config) or die "Could not find 'theme' inside '$repi_client_config'\n";
my $rept_client_config 	= "$themes_root/Instances/".$client_theme."/config.yml";
my $generic_theme 		= get_theme_from_config($rept_client_config) or die "Could not find 'theme' inside '$rept_client_config\n'";
my $rept_generic_config = "$themes_root/Generic/".$generic_theme."/config.yml";

my $info = {
	# Script arguments
	repi_client_config 		=> $repi_client_config,
	themes_root				=> $themes_root,
	site_files				=> $site_files,

	# Configs
	client_theme 			=> $client_theme,
	rept_client_config 		=> $rept_client_config,
	generic_theme 			=> $generic_theme,
	rept_generic_config 	=> $rept_generic_config,
	local_conf				=> "$site_files/config/config.yml",
	local_conf_folder		=> "$site_files/config",
	
	# Overrides
	shared_or   			=> "$themes_root/Shared/Overrides",
	generic_or  			=> "$themes_root/Generic/$generic_theme/Overrides",
	client_or   			=> "$themes_root/Instances/$client_theme/Overrides",

	# SASS
	stylesheets 			=> "$site_files/public/stylesheets",
	sass_folder 			=> "$themes_root/Instances/$client_theme",
};

copy_overrides($info);
generate_saas($info);
generate_config($info);

sub copy_overrides {
	my ($info) = @_;
	my $shared_or = $info->{shared_or};
	print qx{cp -r '$shared_or'/* '$site_files/'} if -d $shared_or;

	my $generic_or = $info->{generic_or}; 
	print qx{cp -r '$generic_or'/* '$site_files/'} if -d $generic_or;
		
	my $client_or = $info->{client_or}; 
	print qx{cp -r '$client_or'/* '$site_files/'} if -d $client_or;
}

sub generate_saas {
	my ($info) = @_;
	my $sass_folder = $info->{sass_folder};
	my $stylesheets = $info->{stylesheets};
	print qx{mkdir -p "$stylesheets"};
	foreach my $sass (<$sass_folder/*.sass>){
		next if $sass =~ /config\.sass$/;
		my $css = basename($sass);
		$css =~ s/sass$/css/;
		$css = "$stylesheets/$css";
		my $cmd = qq{sass --update '$sass':'$css' --style compressed};
		# print "$sass_folder\n";
		# print "COMMAND: $cmd\n\n\n\n";
		print qx{sass --update '$sass':'$css' --style compressed};
	}
}

sub generate_config {
	my ($info) = @_;
	my $local_conf = $info->{local_conf};
	my $local_conf_folder = $info->{local_conf_folder};
	print qx{mkdir -p "$local_conf_folder"};
	print qx{merge_yaml.pl '$repi_client_config' '$rept_client_config' '$rept_generic_config' > '$local_conf'};
	add_railsenv($local_conf);
}

sub add_railsenv {
	my $config_file = shift;
	my $config = YAML::XS::LoadFile($config_file);
	my $rails_env;
	defined($ENV{'RAILS_ENV'})? $rails_env = $ENV{'RAILS_ENV'} : $rails_env = 'development';
	my $newconf = { $rails_env => $config };
	YAML::XS::DumpFile($config_file,$newconf);
}
	

sub get_theme_from_config {
	my $config_file = shift;
	my $config = YAML::XS::LoadFile($config_file);
	return $config->{theme};
}

