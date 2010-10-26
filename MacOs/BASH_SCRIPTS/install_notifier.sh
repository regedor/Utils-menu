sudo gem install autotest-rails
sudo aptitude install ruby-gnome2 libnotify-dev
wget -c http://rubyforge.org/frs/download.php/27134/ruby-libnotify-0.3.3.tar.bz2
tar -jxvf ruby-libnotify-0.3.3.tar.bz2
cd ruby-libnotify-0.3.3
ruby extconf.rb && make && sudo make install
rm -rf ruby-libnotify-0.3.3/ ruby-libnotify-0.3.3.tar.bz2
