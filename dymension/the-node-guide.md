---
description: 'Dymension: Node Setup Guide'
---

# Node Setup Guide

<figure><img src="../.gitbook/assets/Sub Guide (2).png" alt=""><figcaption></figcaption></figure>

Welcome to our guide on setting up your node and participating in the Dymension protocol testnet. Follow these step-by-step instructions to get started.

### Hardware Requirements <a href="#hardware-requirements" id="hardware-requirements"></a>

We recommend the following minimum hardware requirements for running the Dymension Node:

* Machine: **16 GB RAM,** **Dual Core, 500 SSD, 100mbps network bandwidth**
* OS: **Ubuntu Linux 20.04 (LTS)**

## Setting up a Dymension Node

### Update system and install requirements

{% code lineNumbers="true" %}
```bash
apt update && apt upgrade -y
apt install curl jq wget build-essential
```
{% endcode %}

### Install GO

{% code lineNumbers="true" %}
```bash
 rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.10.linux-amd64.tar.gz && rm go1.20.10.linux-amd64.tar.gz
 echo "export PATH=$PATH:/usr/local/go/bin" > $HOME/.profile
 source $HOME/.profile
```
{% endcode %}

### Build Dymension

{% code lineNumbers="true" %}
```bash
git clone https://github.com/dymensionxyz/dymension.git --branch v1.0.2-beta
cd dymension
make build
cp ./build/dymd /usr/local/bin/
```
{% endcode %}

Check binary version:

```bash
dymd version --long | grep -E -i "^commit|^version"
```

{% hint style="success" %}
commit: 74457e007dc802bd9c0be979baa5d83ab4d3226e

version: v1.0.2-beta
{% endhint %}

### Node configuration

<pre class="language-bash" data-line-numbers><code class="lang-bash">DYMENSION_MONIKER="Your moniker"
<strong>DYMENSION_CHAIN_ID="froopyland_100-1"
</strong>echo 'export DYMENSION_MONIKER='$DYMENSION_MONIKER >> $HOME/.bash_profile
echo 'export DYMENSION_CHAIN_ID='$DYMENSION_CHAIN_ID >> $HOME/.bash_profile
source $HOME/.bash_profile
dymd init $DYMENSION_MONIKER --chain-id $DYMENSION_CHAIN_ID
dymd config chain-id DYMENSION_CHAIN_ID
dymd config keyring-backend test
</code></pre>

### Download genesis

```bash
wget -O $HOME/.dymension/config/genesis.json https://raw.githubusercontent.com/dymensionxyz/testnets/main/dymension-hub/froopyland/genesis.json
```

Check genesis checksum:

```bash
sha256sum $HOME/.dymension/config/genesis.json
```

{% hint style="success" %}
2c39abf9fd87222fc3b8178763e1c0e250029a445a3775b3507e88140910049e genesis.json
{% endhint %}

### Create or recover existing wallet

{% code title="Create" %}
```bash
dymd keys add wallet
```
{% endcode %}

{% code title="Recover" %}
```bash
dymd keys add wallet --recover
```
{% endcode %}

Save the output of the command in a secure place. Fund your address using Dymension's Discord channel [#froopyland-faucet](https://discord.com/channels/956961633165529098/1143231362468434022)

















***

_Powered by_ [_<mark style="color:blue;">deNodes</mark>_](https://twitter.com/deNodes\_)
