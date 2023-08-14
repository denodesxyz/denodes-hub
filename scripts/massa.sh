#!/bin/bash

if [ $# -ne 1 ]; then 
	echo "Usage:"
	echo "massa.sh <command>"
	echo "	install    Node installation"
	echo "	uninstall] Delete node"
	echo "	update     Update"
	echo "	backup     Backup private key"
	echo ""
fi

backup () {
	mkdir -p $HOME/massa_backup
	cp $HOME/massa/massa-node/config/node_privkey.key $HOME/massa_backup/
	cp $HOME/massa/massa-client/wallet.dat $HOME/massa_backup/
}

case "$1" in
install)
	apt update && apt -y upgrade
	sudo apt -y install pkg-config curl git build-essential libssl-dev libclang-dev jq
	
	MASSA_LATEST=`wget -qO- https://api.github.com/repos/massalabs/massa/releases/latest | jq -r ".tag_name"`
	wget -qO $HOME/massa.tar.gz "https://github.com/massalabs/massa/releases/download/${MASSA_LATEST}/massa_${MASSA_LATEST}_release_linux.tar.gz"
	tar -xvf $HOME/massa.tar.gz
	rm -rf $HOME/massa.tar.gz

	read -p "Enter password: " MASSA_PASSWORD
	echo 'export MASSA_PASSWORD='$MASSA_PASSWORD >> $HOME/.bash_profile
	echo 'function massa_client() { (cd /root/massa/massa-client/ && ./massa-client -p $MASSA_PASSWORD $@); }' >> $HOME/.bash_profile
	source $HOME/.bash_profile

	printf "[Unit]
Description=Massa Node
After=network-online.target

[Service]
User=$USER
WorkingDirectory=$HOME/massa/massa-node
ExecStart=$HOME/massa/massa-node/massa-node -p "$MASSA_PASSWORD"
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/massa-node.service

	sudo tee <<EOF >/dev/null $HOME/massa/massa-node/config/config.toml
[network]
routable_ip = "`curl -s ifconfig.me/ip`"
EOF

	systemctl daemon-reload
	systemctl enable massa-node
	systemctl restart massa-node

	echo "Installation complete"
	echo "To work correctly, you need to register the node in the discord"
	echo "Logs: journalctl -u massa-node -f -o cat"
	;;

update)
	backup

	systemctl stop massa-node
	MASSA_LATEST=`wget -qO- https://api.github.com/repos/massalabs/massa/releases/latest | jq -r ".tag_name"`
        wget -qO $HOME/massa.tar.gz "https://github.com/massalabs/massa/releases/download/${MASSA_LATEST}/massa_${MASSA_LATEST}_release_linux.tar.gz"
        tar -xvf $HOME/massa.tar.gz
        rm -rf $HOME/massa.tar.gz
	systemctl start massa-node

	echo "Updated to version ${MASSA_LATEST}"
	;;

backup)
	backup
	;;		

uninstall)
	backup
	systemctl stop massa-node
	systemctl disable massa-node
	rm /etc/systemd/system/massa-node.service
	rm -rf $HOME/massa

	echo "Deletion complete"
	;;

esac
