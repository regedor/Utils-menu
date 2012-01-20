#!/usr/bin/ruby

require "#{ENV['UTILS_PROJECT_PATH']}/Lib/Linode.rb"

domain = ARGV.shift
l = Linode::GB.new
l.add_google_apps(domain)

puts "Finished adding Google Apps records for domain #{domain}!"
puts "In order to create a Google Apps free account for this\ndomain, open https://www.google.com/a/cpanel/standard/new3\nand fill out the form."


