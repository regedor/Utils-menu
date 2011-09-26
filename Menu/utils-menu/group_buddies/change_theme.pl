#!/usr/bin/env perl 
use strict; use warnings;
use File::Basename;
use YAML::XS;
use Data::Dumper;

my ($repi_client_config, $themes_root, $site_files) = @ARGV;

my $info = prepare_data($repi_client_config, $themes_root, $site_files);
copy_overrides	($info);
generate_saas	($info);
generate_config	($info);

sub prepare_data {
	my ($repi_client_config, $themes_root, $site_files) = @_;
	$themes_root =~ s!/$!!;	# Remove last '/', if any
	$site_files =~ s!/$!!; 	# Remove last '/', if any

	my $info = {};

	# Client config			- Repository gb-instances or config.local
		$info->{repi_client_config} 	= $repi_client_config;
	
	# Client theme config 	- Repository gb-handyant-themes, folder Instances
		my $client_theme 			= get_theme_from_config($repi_client_config) or die "Could not find 'theme' inside '$repi_client_config'\n";
		my $rept_client_config 		= "$themes_root/Instances/$client_theme/config.yml";
		$info->{client_theme}			= $client_theme;
		$info->{client_or}			= "$themes_root/Instances/$client_theme/Overrides";
		$info->{rept_client_config}	= $rept_client_config;

	# Generic theme config	- Repository gb-handyant-themes, folder Generic
		my $generic_theme 			= get_theme_from_config($rept_client_config) or warn "Could not find 'theme' inside '$rept_client_config\n'";
		my $rept_generic_config 	= "$themes_root/Generic/".$generic_theme."/config.yml";
		$info->{rept_generic_config} 	= $rept_generic_config;
		$info->{generic_theme} 		= $generic_theme;
		$info->{generic_or}  		= "$themes_root/Generic/$generic_theme/Overrides";
	


	# Script arguments
		$info->{themes_root}			= $themes_root;
		$info->{site_files}			= $site_files;

	# Configs
		$info->{local_conf}			= "$site_files/config/config.yml";
		$info->{local_conf_folder}	= "$site_files/config";

	# Overrides
		$info->{shared_or}   		= "$themes_root/Shared/Overrides";

	# SASS
		$info->{stylesheets} 		= "$site_files/public/stylesheets";
		$info->{sass_folder} 		= "$themes_root/Instances/$client_theme";

	return $info;
}

sub copy_overrides {
	my ($info) = @_;
	my $shared_or = $info->{shared_or};
	print qx{cp -r '$shared_or'/* '$site_files/'} if -d $shared_or;

	if ($info->{generic_theme} ne 'none'){
		my $generic_or = $info->{generic_or}; 
		print qx{cp -r '$generic_or'/* '$site_files/'} if -d $generic_or;
	}
		
	my $client_or = $info->{client_or}; 
	print qx{cp -r '$client_or'/* '$site_files/'} if -d $client_or;
}

sub generate_saas {
	my ($info) = @_;
	my $sass_folder = $info->{sass_folder};
	my $stylesheets = $info->{stylesheets};
	print qx{mkdir -p "$stylesheets"};
	#foreach my $sass (<"$sass_folder"/*.sass>){
	opendir(my $sass_dir,$sass_folder);
	foreach my $sass_n (readdir($sass_dir)){
		my $sass = "$sass_folder/$sass_n";  # Get complete path
		next unless $sass =~ /\.sass$/; 	# Skip unless its a sass file
		next if $sass =~ /config\.sass$/; 	# Skip if it's config.sass
		my $css = basename($sass);
		$css =~ s/sass$/css/;
		$css = "$stylesheets/$css";
		my $cmd = qq{sass --update '$sass':'$css' --style compressed};
		print qx{sass --update '$sass':'$css' --style compressed};
	}
}

sub generate_config {
	my ($info) = @_;
	my $local_conf = $info->{local_conf};
	my $local_conf_folder = $info->{local_conf_folder};
	print qx{mkdir -p "$local_conf_folder"};
	my $rept_generic_config = $info->{rept_generic_config};
	my $rept_client_config = $info->{rept_client_config};
	if($info->{generic_theme} ne 'none'){ print qx{merge_yaml.pl '$rept_generic_config' '$rept_client_config' '$repi_client_config' > '$local_conf'}; }
	else						{ print qx{merge_yaml.pl '$rept_client_config' '$repi_client_config' > '$local_conf'}; }
	add_railsenv($local_conf);
}

sub add_railsenv {
	my $config_file = shift;
	my $config = YAML::XS::LoadFile($config_file);
	my $rails_env;
	if(defined($ENV{'RAILS_ENV'}))	{ $rails_env = $ENV{'RAILS_ENV'} 	}
	else 							{ $rails_env = 'development';		}
	my $newconf = { 	
			$rails_env => $config, 
			test => { 
				'<<' => $config  } 
		};
	my $yaml = YAML::XS::DumpFile($config_file,$newconf);
}
	

sub get_theme_from_config {
	my $config_file = shift;
	my $config = YAML::XS::LoadFile($config_file);
	return $config->{theme};
}

