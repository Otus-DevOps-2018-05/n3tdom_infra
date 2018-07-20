#daemon
unit_file="
[Unit]
Description=reddit-app
Requires=network-online.target

[Service]
#Environment=PUMA_DEBUG=1
User=appuser
WorkingDirectory=/home/appuser/reddit
ExecStart=/usr/local/bin/puma -d
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target" 

echo "$unit_file" > /lib/systemd/system/reddit.service
systemctl daemon-reload

#launch
systemctl enable reddit.service
