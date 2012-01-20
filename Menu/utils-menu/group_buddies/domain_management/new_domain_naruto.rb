#!/usr/bin/ruby

require 'Linode.rb'

domain = ARGV.shift
l = Linode::GB.new
l.add_naruto(domain)

puts "Finished adding default records for domain #{domain}!"


