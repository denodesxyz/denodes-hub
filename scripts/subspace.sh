#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

cd $HOME

if [[ "$1" == "uninstall" ]]; then
    printf "${GREEN}Delete node${NC}\n"
    sudo systemctl stop subspace-node
    sudo systemctl disable subspace-node
    sudo rm /etc/systemd/system/subspace-node.service
    sudo rm /usr/local/bin/subspace
    rm -rf $HOME/.local/share/subspace-cli/
    printf "${GREEN}Deletion complete${NC}\n"
    exit
fi

printf "${GREEN}Updating and installing dependencies${NC}\n"
sudo apt -qq update
sudo apt -qq -y upgrade
sudo apt -y install wget

BIN_FILE="https://github.com/subspace/pulsar/releases/download/v0.6.11-alpha/pulsar-ubuntu-x86_64-skylake-v0.6.11-alpha"

if [[ $1 == "v2" ]]; then
    BIN_FILE="https://github.com/subspace/pulsar/releases/download/v0.6.11-alpha/pulsar-ubuntu-x86_64-v2-v0.6.11-alpha"
fi
sudo wget -O /usr/local/bin/subspace $BIN_FILE
sudo chmod +x /usr/local/bin/subspace

printf "${GREEN}Setting up Subspace${NC}\n"
/usr/local/bin/subspace init

printf "${GREEN}Node startup${NC}\n"
printf "[Unit]
Description=Subspace Node
After=network.target
[Service]
Type=simple
User=$USER
ExecStart=/usr/local/bin/subspace farm --verbose
Restart=on-failure
RestartSec=10
LimitNOFILE=1048576
[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/subspace-node.service > /dev/null

sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable subspace-node
sudo systemctl restart subspace-node

printf "${GREEN}Installation complete${NC}\n"
printf "${GREEN}Logs: journalctl -f -u subspace-node -o cat ${NC}\n"
