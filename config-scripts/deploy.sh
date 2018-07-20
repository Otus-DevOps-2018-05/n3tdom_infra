#!/bin/bash
#./deploy.sh
set -e

git clone -b monolith https://github.com/express42/reddit.git $HOME/reddit
cd $HOME/reddit
bundle install

#launch
puma -d
