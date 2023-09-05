---
description: >-
  This page is dedicated to providing detailed information about the Subspace
  network
---

# ⚪ Subspace

{% hint style="info" %}
Here, you can find information about the project's overview, architecture, backers and team, testnet, and resources.
{% endhint %}

### Table of Contents

* Project Overview
* Node Setup Guide
* FAQ: Most Frequently Asked Questions

## Installation

```
wget -O subspace.sh https://github.com/denodesxyz/denodes-hub/raw/hub/scripts/subspace.sh && chmod +x subspace.sh && ./subspace.sh
```

If the text "Illegal instruction" appears during installation, it means that the processor is not suitable for this version. You can try adding the "v2" parameter and install the version for older processors:

```
wget -O subspace.sh https://github.com/denodesxyz/denodes-hub/raw/hub/scripts/subspace.sh && chmod +x subspace.sh && ./subspace.sh v2
```

During the installation process, several parameters will be requested, the most important of which are the wallet address, the node name and the volume of the disk allocated for the plot.

For the first question, enter Y ![Screenshot 2023-08-14 at 18 03 36](https://github.com/denodesxyz/denodes-hub/assets/139079136/33aa294e-7995-43b8-aa80-12356dfe8adc)

Enter the address that can be taken here: https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Frpc-0.gemini-3e.subspace.network%2Fws#/accounts or install recommended wallet [Subwallet](https://docs.subspace.network/docs/protocol/wallets/subwallet) ![Screenshot 2023-08-14 at 18 06 35](https://github.com/denodesxyz/denodes-hub/assets/139079136/9d4d4602-3bfd-4904-ad67-7bece619fa43)

Enter an arbitrary unique node name: ![Screenshot 2023-08-14 at 18 06 51](https://github.com/denodesxyz/denodes-hub/assets/139079136/9b0706c0-0d3d-4b2a-a785-aff539d3512c)

Specify the paths for storing the plot and the node data (you can leave the default values): ![Screenshot 2023-08-14 at 18 07 25](https://github.com/denodesxyz/denodes-hub/assets/139079136/dfa79cd4-f47b-41a1-9eb8-b140a9d59ffb)

Specify the size of the plot: ![Screenshot 2023-08-14 at 18 08 41](https://github.com/denodesxyz/denodes-hub/assets/139079136/0d079655-3772-4982-991d-69ff877ba150)

Leave the default value when selecting the chain: ![Screenshot 2023-08-14 at 18 08 57](https://github.com/denodesxyz/denodes-hub/assets/139079136/e3245227-2d4d-4a18-a5d3-5a05dee8ca36)

Installation successfully completed: ![Screenshot 2023-08-14 at 18 09 26](https://github.com/denodesxyz/denodes-hub/assets/139079136/bc698366-f1cc-4fac-ad52-443cd9403c35)

## Monitoring

Viewing logs:

```
journalctl -f -u subspace-node -o cat
```

In addition to logs, you can find your node in telemetry. Keep in mind that with a large number of farmers, there is a chance that even a successfully working node will not be seen in telemetry immediately. To search, you just need to start typing the node name. Clicking on the row with the node pin it to the top of the list.

https://telemetry.subspace.network/#list/0xa3cd4b592d93f79943fbc58fc90ca8f516106699c9cf4d7ada98ca22877bc1ae

![Screenshot 2023-08-14 at 18 38 52](https://github.com/denodesxyz/denodes-hub/assets/139079136/f14ac701-72fd-4834-b5e0-79e43815a683)

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
