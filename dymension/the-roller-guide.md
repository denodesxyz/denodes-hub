---
description: 'Dymension: Roller Setup Guide'
---

# Roller Setup Guide

<figure><img src="../.gitbook/assets/Sub Roller.png" alt=""><figcaption></figcaption></figure>

Welcome to our guide on setting up your node and participating in the [<mark style="color:blue;">Dymension testnet</mark>](https://medium.com/@dymension/froopyland-is-live-8bf21e9d7046). Follow these step-by-step instructions to get started.

### Hardware Requirements <a href="#hardware-requirements" id="hardware-requirements"></a>

We recommend the following minimum hardware requirements for deploying a RollApp:

* Machine: **16 GB+ RAM,** **Dual Core, 100 GB+ SSD**
* Network: **At least 100 mbps network bandwidth**
* OS: **Linux AMD64, Linux ARM64, Mac AMD64, Mac ARM64**

### Install Roller

1. Run the following command:

```bash
curl -L https://dymensionxyz.github.io/roller/install.sh | bash
```

2. Verify Roller version:

```bash
roller version
```

{% code title="Should output:" %}
```
💈 Roller version v0.1.16-beta
💈 Build time: 2023-10-04T13:38:07+0000"
💈 Git commit: 57994323bdaea039b4ce7449b9f026f0059ba925
```
{% endcode %}

### Initialize RollApp

Initializing the configuration files of the RollApp will create the necessary information to start a new RollApp. This will create a folder `~/.roller` in the root directory of your computer with important files such as the `Genesis` file.

```bash
roller config init --interactive
```

* Select your network → **Froopyland (default)**
* Select your execution environment → **EVM RollApp (default)**
* Enter your RollApp ID → The rollapp ID, should contain only alphabetical characters. **Example**: **denodes**
* Specify your RollApp denom → Name of the native token of the RollApp in English letters. **Example**: **BTC, PEPE, DYM**
* Set the genesis token supply → Initial token supply in the RollApp **1,000,000,000 (default)**
* Choose your data layer → **Celestia: Arabica testnet**, **Avail: Dymension dedicated devnet**

### Address funding <a href="#address-funding" id="address-funding"></a>

After initializing the RollApp, addresses to fund should be returned to you:

{% code fullWidth="false" %}
```
🔑 Addresses:

Sequencer <network> | Address used to publish state updates to the Dymension Hub
Relayer   <network> | Address that handles the relaying of IBC packets
DA        <network> | Address used to publish data on-chain to the DA network
```
{% endcode %}

You can get these addresses at any time by executing the command:

```
roller keys list
```

The first two addresses need to be fund through the [froopyland-faucet](https://discord.com/channels/956961633165529098/1143231362468434022) channel in the Dymension discord:

```
$request <dym-address>
```

For Celestia and Avail network tokens you may use the [celestia-faucet](https://discord.com/channels/956961633165529098/1128048548999610451) or [avail-faucet](https://discord.com/channels/956961633165529098/1144240033650458685) respectively:

{% code title="Celestia" %}
```
$request <celestia-address>
```
{% endcode %}

{% code title="Avail" %}
```
/deposit <avail-address>
```
{% endcode %}

### Registering the RollApp

Registering the RollApp adds a namespace in the Dymension Hub to account for the newly initalized RollApp.

Instead of managing a multi-sig smart contract, a developer only needs to register the RollApp with a simple command. Registering the RollApp to the Dymension Hub allows a Sequencer to publish state updates on-chain and furthermore facilitates bridging between ecosystems.

The following command utilizes the addresses generated in the [previous step](https://docs.dymension.xyz/build/quick-start/roller-quick/initialize) :

```bash
roller tx register
```

Should return:

```
💈 Rollapp '<rollapp-id>' has been successfully registered on the hub.
```

### Running the RollApp

There are two ways to run RollApp. In the first case it is enough to execute the command:

```
roller run
```

During the `Run` process a RollApp with an IBC connection to the Dymension Hub is started. A status table will appear with information about the RollApp and IBC relayer. Developers should see an output with useful information such as this:

<figure><img src="../.gitbook/assets/Screenshot 2023-10-09 at 4.53.41 PM.png" alt=""><figcaption></figcaption></figure>

If you close the terminal, the process execution will be stopped. Therefore, it is recommended to use the following method. It only works on Linux with systemd.

Creating service files:

```bash
roller services load
```

Enable services:

{% code title="Celestia" %}
```bash
sudo systemctl enable da-light-client sequencer relayer
```
{% endcode %}

{% code title="Avail" %}
```bash
sudo systemctl enable sequencer relayer
```
{% endcode %}

Start the services:

{% code title="Celestia" %}
```bash
sudo systemctl start da-light-client sequencer relayer
```
{% endcode %}

{% code title="Avail" %}
```bash
sudo systemctl start sequencer relayer
```
{% endcode %}

Next, check the status of running services

{% code title="Celestia" %}
```bash
sudo systemctl status da-light-client sequencer relayer
```
{% endcode %}

{% code title="Avail" %}
```bash
sudo systemctl status sequencer relayer
```
{% endcode %}

The status of all services should be **active (running)**.

### IBC Transfer

Fund the Dymension Hub faucet from the created RollApp:

```bash
roller tx fund-faucet
```

Within 30 minutes tokens will become available via faucet in the Dymension Discord ([#froopyland-faucet channel](https://discord.com/channels/956961633165529098/1143231362468434022)). Run the following command to check the balance of your RollApp token:

```
$balances dym1g8sf7w4cz5gtupa6y62h3q6a4gjv37pgefnpt5 <rollapp-id>
```

\<rollapp-id> can always be found with the command:

```bash
roller config show
```

Once the tokens appear in the faucet balance, users will be able to request them with the following command in Discord:

```
$request <user-address> <rollapp-id>
```

#### Transfer IBC Tokens <a href="#transfer-ibc-tokens" id="transfer-ibc-tokens"></a>

Let's transfer the tokens to the faucet address (for the example) using IBC. First, let's define the source channel of our RollApp:

```
roller relayer status
```

<figure><img src="../.gitbook/assets/Screenshot 2023-10-10 at 5.14.52 PM.png" alt=""><figcaption></figcaption></figure>

The source channel, in this case `channel-0`, will be used in the following command and will be referred to as `<src-channel>`.

In the following command, you must substitute your own values for `<src-channel>`and `<base-denom>`. `<destination-address>` replace with faucet address (_dym1g8sf7w4cz5gtupa6y62h3q6a4gjv37pgefnpt5_)

{% code overflow="wrap" %}
```bash
rollapp_evm tx ibc-transfer transfer transfer <src-channel> <destination-address> 5000000000000000000000000<base-denom> --from rollapp_sequencer --keyring-backend test --home ~/.roller/rollapp --broadcast-mode block
```
{% endcode %}

For example:

{% code overflow="wrap" %}
```bash
rollapp_evm tx ibc-transfer transfer transfer channel-0 dym1g8sf7w4cz5gtupa6y62h3q6a4gjv37pgefnpt5 5000000000000000000000000uDEN --from rollapp_sequencer --keyring-backend test --home ~/.roller/rollapp --broadcast-mode block
```
{% endcode %}

### Export keys

Backup the private keys of your account. Run the following command to display the private keys that are associated with the RollApp.

```
roller keys list
```

The following keys can currently be exported: `hub_sequencer`, `rollapp_sequencer` and `my_celes_key`

```
roller keys export my_celes_key
```

```
roller keys export hub_sequencer
```

```
roller keys export rollapp_sequencer
```

It is recommended to keep the keys in a secure place.

### Portal Listing

Listing on the [Dymension Portal](https://portal.dymension.xyz/) will allow users to discover and interact with the RollApp.&#x20;

First, you need to make sure the Dymension Hub faucet is funded with tokens from the created RollApp. Earlier we did this in the [IBC transfer](the-roller-guide.md#ibc-transfer) step. Next, you need to create a PR in the Dymension GitHub with the RollApp configuration so that the project team can list it on the portal. To do this, follow the steps below.

1. Fork the RollApp-registry [repo](https://github.com/dymensionxyz/rollapp-registry) into your GitHub account:

<figure><img src="../.gitbook/assets/dymension-fork.png" alt=""><figcaption></figcaption></figure>

2. Clone it:

<figure><img src="../.gitbook/assets/dymension-clone.png" alt=""><figcaption></figcaption></figure>

```bash
git clone https://github.com/<your-github-username>/rollapp-registry
```

3. Create the RollApp directory and prepare config information and logo:

```bash
cd rollapp-registry
```

<pre class="language-bash"><code class="lang-bash"><strong>export ROLLAPP_ID=$(roller config show | grep RollappID | grep -o '".*"' | sed 's/"//g')
</strong></code></pre>

<pre class="language-bash" data-overflow="wrap"><code class="lang-bash"><strong>mkdir -p $ROLLAPP_ID/logos &#x26;&#x26; cd $ROLLAPP_ID &#x26;&#x26; touch $ROLLAPP_ID.json
</strong></code></pre>

Next, place the logo in SVG, PNG, or JPG format in the `logos` directory. The size should not exceed 50 KB.

Then export the RollApp configuration to the `<RollApp-ID>.json` file:

```
roller config export 2>&1 | tail -n +2 > $ROLLAPP_ID.json && cat $ROLLAPP_ID.json
```

<figure><img src="../.gitbook/assets/roller_config_export.png" alt=""><figcaption></figcaption></figure>

In the `<RollApp-ID>.json` file, change the following fields:

* `rpc` "http://\<your-public-ip-or-domain>:port" (default port 26657)
* `rest` "http://\<your-public-ip-or-domain>:port" (default port 1317)
* `rpc` in the `evm` section: "http://\<your-public-ip-or-domain>:port" (default port 8545)
* `logo` Correct the file extension

Optional:

* `chainName` The RollApp name as it will appear on the Portal
* `description` Description to be displayed on the portal
* `website` Website URL

Then commit your changes:

{% code lineNumbers="true" %}
```bash
git add .
git commit -m "added RollApp"
git push -u origin main
```
{% endcode %}

And create pull request:

<figure><img src="../.gitbook/assets/dymension-contribute.png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/dymension-PR.png" alt=""><figcaption></figcaption></figure>

Next pair the RollApp on the [Discord channel](https://discord.com/channels/956961633165529098/1140590139022782474) by entering the following command:

```
$pair <RollApp-ID>
```

Then create a thread in the post and send a link to the PR.

<figure><img src="../.gitbook/assets/create-thread.png" alt=""><figcaption></figcaption></figure>

You just have to wait for a moderator to check the PR and list it on the portal. After that, you should send a tweet about the listing with the required `@Dymension` tag and a link to RollApp on the portal. The link to the tweet will need to be sent to this same thread.

### Upgrade

Install the most recent version of Roller:

```bash
curl -L https://dymensionxyz.github.io/roller/install.sh | bash
```

Stop the Roller services:

{% code title="Celestia" %}
```bash
sudo systemctl stop relayer sequencer da-light-client
```
{% endcode %}

{% code title="Avail" %}
```bash
sudo systemctl stop relayer sequencer
```
{% endcode %}

Execute the `migrate` command:

```bash
roller migrate
```

Start the Roller services:

{% code title="Celestia" %}
```bash
sudo systemctl start da-light-client sequencer relayer
```
{% endcode %}

{% code title="Avail" %}
```bash
sudo systemctl stop sequencer relayer
```
{% endcode %}

***

_Powered by_ [_<mark style="color:blue;">deNodes</mark>_](https://twitter.com/\_denodes)
