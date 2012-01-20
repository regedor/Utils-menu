#!/usr/bin/ruby

fullpath = File.expand_path $0
dirname = File.dirname(fullpath)
require "#{dirname}/Linode.rb"

domain = ARGV.shift 
if ! domain
  puts 'Address for the domain being created (domain.tld):'
  domain = gets.chomp
end

l = Linode::GB.new
l.add_google_apps(domain)

puts "Finished adding Google Apps records for domain #{domain}!"
puts "In order to create a Google Apps free account for this\ndomain, open https://www.google.com/a/cpanel/standard/new3\nand fill out the form."


