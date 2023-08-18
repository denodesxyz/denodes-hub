# 🟠 Gear

## Installation

```
wget -O gear.sh https://github.com/denodesxyz/denodes-hub/raw/hub/scripts/gear.sh && chmod +x gear.sh && ./gear.sh install
```

After installation, enter a unique name for the node:
<img width="1250" alt="Screenshot 2023-08-18 at 18 26 57" src="https://github.com/denodesxyz/denodes-hub/assets/139079136/63a0cb6a-ae53-4a73-9757-8386cc922b62">

## Monitoring

Viewing logs:

```
journalctl -f -u gear-node -o cat
```

In addition to logs, you can find your node in telemetry.
To search, you just need to start typing the node name. 
Clicking on the row with the node pin it to the top of the list.

https://telemetry.gear-tech.io/

## Updating

```
wget -O gear.sh https://github.com/denodesxyz/denodes-hub/raw/hub/scripts/gear.sh && chmod +x gear.sh && ./gear.sh update
```

## Backup

To backup, you need to save the **secret_ed25519** file, which is located at **/root/.local/share/gear/chains/**

## Useful commands

Restart
```
systemctl restart gear-node
```

Stop
```
systemctl stop gear-node
```

Remove node from server
```
systemctl stop gear-node
systemctl disable gear-node
rm /etc/systemd/system/gear-node.service
rm /usr/local/bin/gear
rm -rf /root/.local/share/gear
```

