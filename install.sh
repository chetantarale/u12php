#!/bin/bash -e

sudo apt-get clean
sudo mv /var/lib/apt/lists /tmp
sudo mkdir -p /var/lib/apt/lists/partial
sudo apt-get clean
sudo apt-get update

# Install dependencies
echo "=========== Installing dependencies ============"
apt-get update
apt-get install -y git wget cmake libmcrypt-dev libreadline-dev libzmq-dev
apt-get build-dep -y php5-cli

# Install libmemcached
echo "========== Installing libmemcached =========="
wget https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz
tar xzf libmemcached-1.0.18.tar.gz && cd libmemcached-1.0.18
echo 'line 19 install - pwd'
pwd
./configure --enable-sasl
make && make install
cd .. && rm -fr libmemcached-1.0.18*

# Install phpenv
echo "============ Installing phpenv ============="
git clone git://github.com/CHH/phpenv.git $HOME/phpenv
$HOME/phpenv/bin/phpenv-install.sh
echo 'Line 29 -> export PATH=$HOME/.phpenv/bin:$PATH'
echo 'export PATH=$HOME/.phpenv/bin:$PATH' >> $HOME/.bashrc
echo 'eval "$(phpenv init -)"' >> $HOME/.bashrc
echo '<----BASHRC START --->'
cat $HOME/.bashrc
echo '<----BASHRC END --->'
rm -rf $HOME/phpenv

# Install php-build
echo "============ Installing php-build =============="
git clone git://github.com/php-build/php-build.git $HOME/php-build
$HOME/php-build/install.sh
rm -rf $HOME/php-build

# Install phpunit
echo "============ Installing PHPUnit ============="
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar /usr/local/bin/phpunit

# Install pear
echo "============ Installing PHP-PEAR ============="
apt-get install php-pear

# Activate phpenv
export PATH=$HOME/.phpenv/bin:$PATH
echo " 51 PATH=$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

for file in /u12php/version/*;
do
  . $file
done

# Cleaning package lists
echo "================= Cleaning package lists ==================="
apt-get clean
apt-get autoclean
apt-get autoremove
