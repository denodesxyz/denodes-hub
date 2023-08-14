#!/bin/bash

if [ $# -ne 1 ]; then 
	echo "Usage:"
	echo "gear.sh <command>"
	echo "	install   Node installation"
	echo "	uninstall Delete node"
	echo "	update    Update"
	echo "	backup    Backup private key"
	echo ""
fi

case "$1" in
install)
	cd $HOME  
	apt update && apt -y upgrade && apt -y install wget
        wget https://get.gear.rs/gear-nightly-linux-x86_64.tar.xz
	tar xvf gear-nightly-linux-x86_64.tar.xz
	rm gear-nightly-linux-x86_64.tar.xz
	mv gear /usr/local/bin
	read -p "Enter node name: " GEAR_NODE_NAME
	echo 'export GEAR_NODE_NAME="'${GEAR_NODE_NAME}'"' >> $HOME/.bash_profile
	source $HOME/.bash_profile
	printf "[Unit]
Description=Gear Node
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/root/
ExecStart=/usr/local/bin/gear --name \"$GEAR_NODE_NAME\" --telemetry-url \"ws://telemetry-backend-shard.gear-tech.io:32001/submit 0\"
Restart=always
RestartSec=3
LimitNOFILE=10000

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/gear-node.service
	systemctl daemon-reload
	systemctl enable gear-node
	systemctl start gear-node

	echo "Installation complete"
	echo "Logs: journalctl -u gear-node -f -o cat"
        
	echo "Don't forget to make a backup of the private key: bash gear.sh backup"
	;;
uninstall)
	systemctl stop gear-node
	systemctl disable gear-node
	rm /etc/systemd/system/gear-node.service
	rm /usr/local/bin/gear
	rm -rf /root/.local/share/gear

	echo "Deletion complete"
	;;
update)
	cd $HOME
	wget https://get.gear.rs/gear-nightly-linux-x86_64.tar.xz
	tar -xvf gear-nightly-linux-x86_64.tar.xz -C /usr/local/bin
	rm gear-nightly-linux-x86_64.tar.xz
	systemctl stop gear-node
	mkdir -p /root/.local/share/gear/chains/gear_staging_testnet_v6/network
	cp /root/.local/share/gear/chains/gear_staging_testnet_v6/network/* /root/.local/share/gear/chains/gear_staging_testnet_v7/network/
	systemctl start gear-node

	echo "Updating complete"
	;;
backup)
	mkdir /root/gear_backup > /dev/null 2>&1
	cd /root/gear_backup
	hexdump -e '1/1 "%02x"' /root/.local/share/gear/chains/gear_staging_testnet_v7/network/secret_ed25519 > private.txt
	cp /root/.local/share/gear/chains/gear_staging_testnet_v7/network/secret_ed25519 ./secret_ed25519
	echo "Backup of the private key can be found here: /root/gear_backup"
	;;
esac

