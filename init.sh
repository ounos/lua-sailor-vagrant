#!/bin/bash
apt-get update
apt-get install -y apache2 lua5.2 luarocks
a2enmod lua
sed -i '/\<Directory \/var\/www.*/{n;n;s/None$/All/;}' /etc/apache2/apache2.conf
service apache2 restart

# Install packages
luarocks install sailor

#Create new sailor project
sailor create 'hello-world' /vagrant/sailor
if ! [ -L /var/www/html ]; then
  rm -rf /var/www/html
  ln -fs /vagrant/sailor/hello-world /var/www/html
fi