#!/bin/bash -e

#Build PHP 5.6.7
echo "============ Building PHP 5.6 =============="
php-build -i development 5.6.7 $HOME/.phpenv/versions/5.6

# Setting phpenv to 5.6.7
echo "============ Setting phpenv to 5.6 ============"
phpenv rehash 
phpenv global 5.6

# Install Composer
echo "============ Installing Composer ============"
curl -s http://getcomposer.org/installer | php
chmod +x composer.phar
mv composer.phar $HOME/.phpenv/versions/5.6/bin/composer

#install pickle
cd /tmp/pickle
$HOME/.phpenv/versions/5.6/bin/composer install

cd /
