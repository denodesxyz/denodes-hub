---
description: 'Avail: Node Setup Guide'
---

# Node Setup Guide

Welcome to our guide on setting up your node and participating in the Avail protocol testnet. Follow these step-by-step instructions to get started.

<figure><img src="../.gitbook/assets/Avail Guide.png" alt=""><figcaption></figcaption></figure>

### Hardware Requirements <a href="#hardware-requirements" id="hardware-requirements"></a>

We recommend the following minimum hardware requirements for running the Avail Node:

* Machine: **8 GB RAM,** **6 Cores, 500 SSD**
* OS: **Ubuntu Linux 20.04 (LTS)**

## Setting up a Avail Node

1. Run the following command:

## Node Monitoring

To view logs, use the following command:

```
journalctl -f -u subspace-node -o cat
```

In addition to logs, you can find your node in telemetry. Keep in mind that with a large number of farmers, there is a chance that even a successfully working node will not be seen in telemetry immediately.&#x20;

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

<pre><code><strong>sudo systemctl stop subspace-node
</strong>sudo systemctl disable subspace-node
sudo rm /etc/systemd/system/subspace-node.service
sudo rm /usr/local/bin/subspace
rm -rf $HOME/.local/share/subspace*
rm -rf $HOME/.config/subspace*
</code></pre>

***

_**Powered by**_ [_**deNodes**_](https://twitter.com/deNodes\_)
