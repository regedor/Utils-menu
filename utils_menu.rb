#!/usr/bin/ruby

require "yaml"

script_path_linux = "scripts_linux.yml"
script_path_mac = "scripts_mac.yml"



def generate_option_list
	@list = @full_list
	@navigation.each { |index| @list = @list[index]["script"]["scripts"] }
end

def menu_display
	index = 1
	puts "Choose what to do:"
	@list.each do |_script|
		script = _script["script"]
		puts " " + index.to_s + " - " + script["name"]
		index = index + 1
	end
	if @navigation.empty?
		puts " 0 - Exit"
	else
		puts " 0 - Back"
	end
end

def choose_execute_option
	proceed = false
	print "\nEnter option number: "
	begin
		option_str = gets.chomp
		raise if not /^\d+$/ === option_str
		option = option_str.to_i
		if option < 0 || option > @list.size
			puts "Wrong option!" # alternative: raise
		elsif option == 0
			popped = @navigation.pop
			@complete = popped.nil?
		else
			option = option - 1
			@navigation << option
			proceed = true
		end
	rescue
		puts "Wrong option!"
	end
	if proceed
		begin
			path = @list[option]["script"]["path"]
			if not path.nil?
				puts "Executing " + path + "..."
				system path
				@complete = true
			end
		rescue
			puts "Invalid script path!"
		end
	end
	puts "\n\n"
end



# main
@complete = false
@navigation = []

begin
	if RUBY_PLATFORM.downcase.include?("linux")
		config = YAML.load_file(script_path_linux)
		@full_list = config["scripts"]
	elsif RUBY_PLATFORM.downcase.include?("darwin")
		config = YAML.load_file(script_path_mac)
		@full_list = config["scripts"]
	else
		puts "This script is not supported in this operating system!"
		@complete = true
	end
rescue
	puts "Could not open the configuration file!"
	@complete = true
end

while not @complete
	generate_option_list
	menu_display
	choose_execute_option
end

