#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "Please run the installation script as root." 
    exit 1
fi

echo "Installing dependencies..."
apt update
apt install -y jq nethogs


cp ssh_usage_monitor.sh /usr/local/bin/
chmod +x /usr/local/bin/ssh_usage_monitor.sh

# Set up the systemd service
echo "Setting up the systemd service..."
cat > /etc/systemd/system/ssh_usage_monitor.service <<EOL
[Unit]
Description=SSH Usage Monitoring Service

[Service]
ExecStart=/usr/local/bin/ssh_usage_monitor.sh
Restart=always
User=$(whoami)
Group=$(id -gn)

[Install]
WantedBy=multi-user.target
EOL

systemctl daemon-reload
systemctl enable ssh_usage_monitor.service
sudo systemctl start nethogs_aggregator
echo "Installation completed and Service Began!"

