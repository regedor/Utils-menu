#!/bin/bash
echo ""
echo "go to: http://rubyforge.org/projects/rubygems/ find the link to the last rubygems version. (should be a tgz file)"
echo ""
echo "Enter rubygems path: "
read rubygems_path

sudo aptitude -y install vim-rails build-essential
sudo aptitude -y install ruby1.8-dev ruby1.8 ri1.8 rdoc1.8 irb1.8 libreadline-ruby1.8 libruby1.8 libopenssl-ruby sqlite3 libsqlite3-ruby1.8
sudo aptitude -y install imagemagick libmagick9-dev
sudo aptitude -y install libxslt1-dev libxml2-dev
sudo aptitude -y install ruby-gnome2 libnotify-dev

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

sudo gem install --no-rdoc --no-ri rails --version '2.3.8'
sudo gem install --no-rdoc --no-ri sinatra
sudo gem install --no-rdoc --no-ri shotgun
sudo gem install --no-rdoc --no-ri rmagick
sudo gem install --no-rdoc --no-ri prawn
sudo gem install --no-rdoc --no-ri RedCloth
sudo gem install --no-rdoc --no-ri formtastic
sudo gem install --no-rdoc --no-ri haml
sudo gem install --no-rdoc --no-ri ruby-libnotify 
sudo gem install --no-rdoc --no-ri webrat
sudo gem install --no-rdoc --no-ri rspec
sudo gem install --no-rdoc --no-ri rspec-rails
sudo gem install --no-rdoc --no-ri cucumber
sudo gem install --no-rdoc --no-ri factory_girl
sudo gem install --no-rdoc --no-ri email_spec
sudo gem install --no-rdoc --no-ri thoughtbot-factory_girl --source http://gems.github.com
sudo gem install --no-rdoc --no-ri bmabey-email_spec --source http://gems.github.com
sudo gem install --no-rdoc --no-ri autotest-rails
sudo gem install --no-rdoc --no-ri configatron
sudo gem install --no-rdoc --no-ri will_paginate
sudo gem install --no-rdoc --no-ri calendar_date_select
sudo gem install --no-rdoc --no-ri chronic
sudo gem install --no-rdoc --no-ri coderay
sudo gem install --no-rdoc --no-ri lesstile
sudo gem install --no-rdoc --no-ri fastercsv
sudo gem install --no-rdoc --no-ri spreadsheet-excel
sudo gem install --no-rdoc --no-ri cucumber-rails
sudo gem install --no-rdoc --no-ri database_cleaner
sudo gem install --no-rdoc --no-ri declarative_authorization --source http://gemcutter.org

sudo gem install --no-rdoc --no-ri authlogic
sudo gem install --no-rdoc --no-ri authlogic-oid
sudo gem install --no-rdoc --no-ri ruby-openid
sudo gem install --no-rdoc --no-ri post_commit
sudo gem install --no-rdoc --no-ri paperclip



sudo gem list
echo ""
echo "Ruby on Rails should be working now!"
