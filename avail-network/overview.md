---
description: 'Avail: Overview'
---

# Project Overview

<figure><img src="../.gitbook/assets/Avail Overview.png" alt=""><figcaption></figcaption></figure>

Welcome to this research, where you will find detailed information about the Avail architecture, team, and backers, resources, and testnet. In the following sections, we will explore each of these aspects in more detail, providing you with a comprehensive understanding of the project.

## What is Avail

[Avail](https://availproject.org/) is a base modular layer for other blockchains, particularly rollups, to build upon. These rollups can be validity proof-based, optimistic (fraud-proof based), or pessimistic rollups (re-executing all state transitions). Avail offers consensus and data availability as a service at scale to rollups.

* It ensures that data is sequenced, packaged into blocks, and published.
* It segregates transaction data on a per-app (rollup) basis, allowing multiple rollups to publish transactions while only querying their own.
* Avail will have a robust validator set of up to around 1,000, which will sign off on published blocks but will not interpret the transaction data within those blocks.
* Each rollup built on Avail has the power to define how to interpret its own transactions. They can be completely custom, ranging from EVM bytecode to app-specific state machines without a VM.

Avail will also be used to power Validiums/Optimistic chains that utilize Ethereum for settlement and rely on Avail for data availability.

## How Protocol Works

Avail is built upon a robust technological foundation, leveraging key technologies to achieve its objectives:

* **Data Availability Layer**: Avail's primary focus is ensuring the availability of blockchain data. It provides a dedicated layer for storing and guaranteeing the reliability of this data, which is crucial for applications.
* **Application ID**: Avail simplifies data indexing through an application ID system, making it easier for developers to retrieve and manage data.
* **Erasure Encoding**: Avail employs erasure encoding techniques to enhance data resilience and prevent attempts to suppress information. This involves spreading data redundantly across the network.
* **KZG Polynomial Commitments**: Avail secures data using KZG polynomial commitments, providing cryptographic assurances that the data remains unchanged.
* **Validator Network**: The protocol utilizes a decentralized network of validators to achieve consensus on data. With support for up to 1,000 external validators in the active set, Avail mitigates centralization risks.
* **Validity Proofs**: Instead of traditional fraud proofs, Avail utilizes validity proofs. This enables light clients to verify the correctness of the state and the availability of data immediately after finalization, without the need for lengthy challenge periods.
* **Data Availability Sampling**: Avail ensures high data availability through Data Availability Sampling. In this approach, a network of light clients continuously samples a subset of data, improving scalability and data redundancy.

<figure><img src="../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

## Avail Team

The Avail project was launched in late 2020 by co-founder Anurag Arjun within Polygon Labs. Its main objective was to address the data availability problem.

* [Anurag Arjun](https://twitter.com/anuragarjun), formerly a co-Founder and Chief Product Officer at [Polygon](https://iq.wiki/wiki/polygon), the leading Ethereum scaling solution. Alongside Jaynti Kanani, Sandeep Nailwal, and Mihailo Bjelic, Arjun played a key role in Polygon's growth from $26 million in market capitalization in 2019 to over $14 billion in 2021.

{% embed url="https://twitter.com/anuragarjun/status/1636368656807645184" %}

## Resources

* [<mark style="color:blue;">Website</mark>](https://www.availproject.org)
* [<mark style="color:blue;">Twitter</mark>](https://twitter.com/AvailProject)
* [<mark style="color:blue;">Discord</mark>](https://discord.gg/gbXXBF5d)
* [<mark style="color:blue;">Blog</mark>](https://blog.availproject.org/)
* [<mark style="color:blue;">GitHub</mark>](https://github.com/availproject/avail)
* [<mark style="color:blue;">Docs</mark>](https://availproject.github.io)

***

_Powered by_ [_<mark style="color:blue;">deNodes</mark>_](https://twitter.com/\_denodes)
