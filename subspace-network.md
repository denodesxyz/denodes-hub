
# 🟠 Subspace Network

## Installation

```
wget -O subspace.sh https://github.com/denodesxyz/denodes-hub/raw/hub/scripts/subspace.sh && chmod +x subspace.sh && ./subspace.sh
```

If the text "Illegal instruction" appears during installation, it means that the processor is not suitable for this version. You can try adding the "v2" parameter and install the version for older processors:
```
wget -O subspace.sh https://github.com/denodesxyz/denodes-hub/raw/hub/scripts/subspace.sh && chmod +x subspace.sh && ./subspace.sh v2
```

During the installation process, several parameters will be requested, the most important of which are the wallet address, the node name and the volume of the disk allocated for the plot.

For the first question, enter Y
<img width="1040" alt="Screenshot 2023-08-14 at 18 03 36" src="https://github.com/denodesxyz/denodes-hub/assets/139079136/33aa294e-7995-43b8-aa80-12356dfe8adc">

Enter the address that can be taken here:
https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Frpc-0.gemini-3e.subspace.network%2Fws#/accounts
or install recommended wallet [Subwallet](https://docs.subspace.network/docs/protocol/wallets/subwallet)
<img width="1036" alt="Screenshot 2023-08-14 at 18 06 35" src="https://github.com/denodesxyz/denodes-hub/assets/139079136/9d4d4602-3bfd-4904-ad67-7bece619fa43">

Enter an arbitrary unique node name:
<img width="1032" alt="Screenshot 2023-08-14 at 18 06 51" src="https://github.com/denodesxyz/denodes-hub/assets/139079136/9b0706c0-0d3d-4b2a-a785-aff539d3512c">

Specify the paths for storing the plot and the node data (you can leave the default values):
<img width="1034" alt="Screenshot 2023-08-14 at 18 07 25" src="https://github.com/denodesxyz/denodes-hub/assets/139079136/dfa79cd4-f47b-41a1-9eb8-b140a9d59ffb">

Specify the size of the plot:
<img width="1035" alt="Screenshot 2023-08-14 at 18 08 41" src="https://github.com/denodesxyz/denodes-hub/assets/139079136/0d079655-3772-4982-991d-69ff877ba150">

Leave the default value when selecting the chain:
<img width="1036" alt="Screenshot 2023-08-14 at 18 08 57" src="https://github.com/denodesxyz/denodes-hub/assets/139079136/e3245227-2d4d-4a18-a5d3-5a05dee8ca36">

Installation successfully completed:
<img width="1031" alt="Screenshot 2023-08-14 at 18 09 26" src="https://github.com/denodesxyz/denodes-hub/assets/139079136/bc698366-f1cc-4fac-ad52-443cd9403c35">

## Monitoring

Viewing logs:
```
journalctl -f -u subspace-node -o cat
```

In addition to logs, you can find your node in telemetry. Keep in mind that with a large number of farmers, there is a chance that even a successfully working node will not be seen in telemetry immediately. To search, you just need to start typing the node name. Clicking on the row with the node pin it to the top of the list.

https://telemetry.subspace.network/#list/0xa3cd4b592d93f79943fbc58fc90ca8f516106699c9cf4d7ada98ca22877bc1ae

<img width="1081" alt="Screenshot 2023-08-14 at 18 38 52" src="https://github.com/denodesxyz/denodes-hub/assets/139079136/f14ac701-72fd-4834-b5e0-79e43815a683">

## Deleting

```
sudo systemctl stop subspace-node
sudo systemctl disable subspace-node
sudo rm /etc/systemd/system/subspace-node.service
sudo rm /usr/local/bin/subspace
rm -rf $HOME/.local/share/subspace*
rm -rf $HOME/.config/subspace*
```

## Useful commands

Restart
```
systemctl restart subspace-node
```

Stop
```
systemctl stop subspace-node
```
