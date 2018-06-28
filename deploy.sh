#!/bin/bash
#./deploy.sh
workdir="/opt"
cd $workdir
git clone -b monolith https://github.com/express42/reddit.git
cd ./reddit
bundle install

#launch
puma -d
