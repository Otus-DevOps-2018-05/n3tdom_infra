#!/bin/bash
set -e

#./install_ruby.sh
apt update
apt install -y ruby-full ruby-bundler build-essential

#./install_mongodb.sh
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
apt update
apt install -y mongodb-org
systemctl enable mongod
systemctl start mongod

#./deploy.sh
set -e

git clone -b monolith https://github.com/express42/reddit.git $HOME/reddit
cd $HOME/reddit
bundle install

#launch
puma -d
