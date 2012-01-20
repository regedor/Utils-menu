#!/usr/bin/ruby

require "#{ENV['UTILS_PROJECT_PATH']}/Lib/Linode.rb"

domain = ARGV.shift
l = Linode::GB.new
l.add_naruto(domain)

puts "Finished adding default records for domain #{domain}!"


