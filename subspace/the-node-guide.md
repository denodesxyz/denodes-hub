---
description: 'Subspace: Node Setup Guide'
---

# Node Setup Guide

<figure><img src="../.gitbook/assets/Sub Guide.png" alt=""><figcaption></figcaption></figure>

Welcome to our guide on setting up your node and participating in the Gemini3, Subspace Incentivized Testnet. Follow these step-by-step instructions to get started.

### Hardware Requirements <a href="#hardware-requirements" id="hardware-requirements"></a>

We recommend the following minimum hardware requirements for running the Subspace Node:

* Machine: **8 GB+ RAM,** **CPU 4 Core+, 100GB SSD**
* OS: **Ubuntu Linux 20.04 (LTS)**

## Setting up a Subspace Node

1. Run the following command:

```
wget -O subspace.sh https://raw.github.com/denodesxyz/denodes-hub/hub/scripts/subspace.sh && chmod +x subspace.sh && ./subspace.sh
```

If the message "Illegal Instruction" appears during installation. It means that the processor is not compatible with this version. You can try adding the "v2" parameter and installing the version for older processors:

```
wget -O subspace.sh https://raw.github.com/denodesxyz/denodes-hub/hub/scripts/subspace.sh && chmod +x subspace.sh && ./subspace.sh v2
```

During the installation process, several parameters will be requested, the most important of which are the wallet address, the node name and the volume of the disk allocated for the plot.

2. For the first question, enter `Y`:

<figure><img src="https://github.com/denodesxyz/denodes-hub/assets/139079136/33aa294e-7995-43b8-aa80-12356dfe8adc" alt=""><figcaption></figcaption></figure>

3. Your subspace wallet address:

* Enter the address that can be taken [here](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Frpc-0.gemini-3e.subspace.network%2Fws#/accounts), or
* Install recommended wallet [Subwallet](https://docs.subspace.network/docs/protocol/wallets/subwallet)

<figure><img src="https://github.com/denodesxyz/denodes-hub/assets/139079136/9d4d4602-3bfd-4904-ad67-7bece619fa43" alt=""><figcaption></figcaption></figure>

4. Enter a unique node name:

<figure><img src="https://github.com/denodesxyz/denodes-hub/assets/139079136/9b0706c0-0d3d-4b2a-a785-aff539d3512c" alt=""><figcaption></figcaption></figure>

5. Specify the paths for storing the plot and the node data (you can leave the default values):

<figure><img src="https://github.com/denodesxyz/denodes-hub/assets/139079136/dfa79cd4-f47b-41a1-9eb8-b140a9d59ffb" alt=""><figcaption></figcaption></figure>

6. Specify the size of the plot:

<figure><img src="https://github.com/denodesxyz/denodes-hub/assets/139079136/0d079655-3772-4982-991d-69ff877ba150" alt=""><figcaption></figcaption></figure>

7. Leave the default value when selecting the chain:

<figure><img src="https://github.com/denodesxyz/denodes-hub/assets/139079136/e3245227-2d4d-4a18-a5d3-5a05dee8ca36" alt=""><figcaption></figcaption></figure>

8. Installation successfully completed:

<figure><img src="https://github.com/denodesxyz/denodes-hub/assets/139079136/bc698366-f1cc-4fac-ad52-443cd9403c35" alt=""><figcaption></figcaption></figure>

## Node Monitoring

To view logs, use the following command:

```
journalctl -f -u subspace-node -o cat
```

In addition to logs, you can find your node in telemetry. Keep in mind that with a large number of farmers, there is a chance that even a successfully working node will not be seen in telemetry immediately.

[https://telemetry.subspace.network/#list/0x92e91e657747c41eeabed5129ff51689d2e935b9f6abfbd5dfcb2e1d0d035095](https://telemetry.subspace.network/#list/0x92e91e657747c41eeabed5129ff51689d2e935b9f6abfbd5dfcb2e1d0d035095)

{% hint style="info" %}
To search, simply start typing the Node Name. Click on the row with the node to pin it to the top of the list.
{% endhint %}

<figure><img src="https://github.com/denodesxyz/denodes-hub/assets/139079136/f14ac701-72fd-4834-b5e0-79e43815a683" alt=""><figcaption></figcaption></figure>

## Useful Commands

The list of useful commands includes ways to manage and monitor your subspace node:

* **View the logs**

```
journalctl -f -u subspace-node -o cat
```

* **Restart your node**

```
journalctl -f -u subspace-node -o cat
```

```
systemctl restart subspace-node
```

* **Stop your node**

```
systemctl stop subspace-node
```

* **Delete your node**

```
sudo systemctl stop subspace-node
sudo systemctl disable subspace-node
sudo rm /etc/systemd/system/subspace-node.service
sudo rm /usr/local/bin/subspace
rm -rf $HOME/.local/share/subspace*
rm -rf $HOME/.config/subspace*
```

***

_Powered by_ [_<mark style="color:blue;">deNodes</mark>_](https://twitter.com/\_denodes)
