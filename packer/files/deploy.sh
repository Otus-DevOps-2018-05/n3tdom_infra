#!/bin/bash
#./deploy.sh
workdir="/opt"
cd $workdir
git clone -b monolith https://github.com/express42/reddit.git
cd ./reddit
bundle install



#daemon
echo "" > /lib/systemd/system/reddit.service
systemctl daemon-reload

#launch
systemctl enable reddit.service
systemctl start reddit.service