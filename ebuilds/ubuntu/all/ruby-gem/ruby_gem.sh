#!/bin/bash

wget http://production.cf.rubygems.org/rubygems/rubygems-1.3.7.tgz
tar -xvzf rubygems-1.3.7.tgz
cd rubygems-1.3.7
sudo ruby setup.rb

# the following was taken from: 
# http://www.veebsbraindump.com/2010/08/supporting-multiple-ruby-versions-on-ubuntu-10-04-lucid/
sudo update-alternatives --remove-all gem

sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.8 500 \
    --slave /usr/share/man/man1/ruby.1.gz ruby.1.gz \
            /usr/share/man/man1/ruby1.8.1.gz \
    --slave /usr/bin/ri ri /usr/bin/ri1.8 \
    --slave /usr/bin/irb irb /usr/bin/irb1.8 \
    --slave /usr/bin/gem gem /usr/bin/gem1.8 \
    --slave /var/lib/gems/bin gem-bin /var/lib/gems/1.8/bin

sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 \
    --slave /usr/share/man/man1/ruby.1.gz ruby.1.gz \
            /usr/share/man/man1/ruby1.9.1.1.gz \
    --slave /usr/bin/ri ri /usr/bin/ri1.9.1 \
    --slave /usr/bin/irb irb /usr/bin/irb1.9.1 \
    --slave /usr/bin/gem gem /usr/bin/gem1.9.1 \
    --slave /var/lib/gems/bin gem-bin /var/lib/gems/1.9.1/bin

