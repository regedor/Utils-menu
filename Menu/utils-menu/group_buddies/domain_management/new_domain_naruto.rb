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
l.add_naruto(domain)

puts "Finished adding default records for domain #{domain}!"


