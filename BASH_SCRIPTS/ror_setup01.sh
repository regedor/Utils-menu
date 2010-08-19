#!/bin/bash
echo ""
echo "go to: http://rubyforge.org/projects/rubygems/ find the link to the last rubygems version. (should be a tgz file)"
echo ""
echo "Enter rubygems path: "
read rubygems_path

sudo aptitude -y install vim-rails

sudo aptitude -y install build-essential

sudo aptitude -y install ruby1.8-dev ruby1.8 ri1.8 rdoc1.8 irb1.8 libreadline-ruby1.8 libruby1.8 libopenssl-ruby sqlite3 libsqlite3-ruby1.8

sudo ln -s /usr/bin/ruby1.8 /usr/bin/ruby
sudo ln -s /usr/bin/ri1.8 /usr/bin/ri
sudo ln -s /usr/bin/rdoc1.8 /usr/bin/rdoc
sudo ln -s /usr/bin/irb1.8 /usr/bin/irb

wget $rubygems_path
tar xzvf $(basename $rubygems_path)
cd $(basename $rubygems_path .tgz)
sudo ruby setup.rb
cd ..
rm -rf $(basename $rubygems_path .tgz)
rm -rf $(basename $rubygems_path)

sudo ln -s /usr/bin/gem1.8 /usr/bin/gem
sudo gem update
sudo gem update --system

sudo gem install rails
sudo aptitude -y install imagemagick
sudo aptitude -y install libmagick9-dev
sudo gem install rmagick
sudo gem install prawn
sudo aptitude -y install libxslt1-dev libxml2-dev
sudo gem install webrat
sudo gem install rspec
sudo gem install rspec-rails
sudo gem install bmabey-email_spec --source http://gems.github.com
sudo gem install cucumber
sudo gem install thoughtbot-factory_girl --source http://gems.github.com

sudo gem list
echo ""
echo "Ruby on Rails should be working now!"
