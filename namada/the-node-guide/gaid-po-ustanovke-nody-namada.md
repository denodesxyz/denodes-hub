---
description: 'Namada: Node Setup Guide in Russian'
---

# Гайд по Установке Ноды Namada

<figure><img src="../../.gitbook/assets/Twitter header - 9.png" alt=""><figcaption></figcaption></figure>

Добро пожаловать в гайд по установке ноды и участию в тестовой сети Namada подготовленный командой [<mark style="color:blue;">deNodes</mark>](http://denodes.xyz/). Следуйте этим пошаговым инструкциям, чтобы начать процесс.

***

### Требования к оборудованию&#x20;

Мы рекомендуем следующие минимальные требования к оборудованию для ноды Namada:&#x20;

* Оборудование: **8 GB RAM,** **6 Cores, 500 SSD**
* ОС: **Ubuntu Linux 22.04+**

### Начало процесса

Обновляем систему:

```bash
apt update && sudo apt upgrade -y
apt install jq -y
```

Устанавливаем CometBFT:

```bash
mkdir -p $HOME/cometbft && cd $HOME/cometbft
wget -O cometbft.tar.gz https://github.com/cometbft/cometbft/releases/download/v0.37.2/cometbft_0.37.2_linux_amd64.tar.gz
tar -xvf cometbft.tar.gz
cp cometbft /usr/local/bin
cd $HOME
rm -rf ./cometbft
```

Скачиваем готовые бинарные файлы Namada:

<pre class="language-bash"><code class="lang-bash"><strong>mkdir -p $HOME/namada &#x26;&#x26; cd $HOME/namada
</strong>wget -O namada.tar.gz "$(curl -s "https://api.github.com/repos/anoma/namada/releases/latest" | grep "browser_download_url" | cut -d '"' -f 4 | grep "Linux")"
tar -xzvf namada*.tar.gz --strip-components 1
cp ./namada* /usr/local/bin/
cd $HOME
rm -rf ./namada
</code></pre>

Задаем переменные окружения:

```bash
# В следующих переменных задаем имя валидатора, название кошелька и свой. уьфшд
echo "export NAMADA_ALIAS="moniker"" >> $HOME/.bash_profile
echo "export NAMADA_WALLET="wallet"" >> $HOME/.bash_profile
echo "export EMAIL="mymail@mydomain.com"" >> $HOME/.bash_profile
# Это оставляем без изменений
echo "export PUBLIC_IP=$(wget -qO- eth0.me)" >> $HOME/.bash_profile
echo "export TM_HASH="v0.1.4-abciplus"" >> $HOME/.bash_profile
echo "export CHAIN_ID="public-testnet-14.5d79b6958580"" >> $HOME/.bash_profile
echo "export BASE_DIR="$HOME/.local/share/namada"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```

Присоединяемся к сети:

```bash
namada client utils join-network --chain-id $CHAIN_ID
```

Создаем сервисный файл:

```bash
sudo tee /etc/systemd/system/namadad.service > /dev/null <<EOF
[Unit]
Description=Namada
After=network-online.target
[Service]
User=$USER
WorkingDirectory=$BASE_DIR
Environment=CMT_LOG_LEVEL=p2p:none,pex:error
Environment=NAMADA_CMT_STDOUT=true
ExecStart=$(which namada) node ledger run 
StandardOutput=syslog
StandardError=syslog
Restart=always
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```

Включаем сервис и запускаем его:

```bash
systemctl daemon-reload
systemctl enable namadad
systemctl start namadad
```

Создаем новый кошелек:

```bash
namada wallet address gen --alias $NAMADA_WALLET
```

Пополняем созданный кошелек из крана [https://faucet.heliax.click/](https://faucet.heliax.click/)

После этого нужно дождаться полной синхронизации ноды. Для этого контролируем баланс кошелька и статус синхронизации.

&#x20;Баланс:

```bash
namada client balance --owner $NAMADA_ALIAS --token NAM
```

Статус синхронизации. Должно быть значение _false:_

```bash
curl http://127.0.0.1:26657/status | jq .result.sync_info.catching_up
```

Когда синхронизация завершилась и токены поступили на баланс создаем валидатора. Комиссию можно указать на свое усмотрение. В примере используется комиссия валидатора 5% и возможностью изменения на 1%

```bash
namada client init-validator \
  --alias $NAMADA_ALIAS \
  --account-keys $NAMADA_WALLET \
  --signing-keys $NAMADA_WALLET \
  --commission-rate 0.05 \
  --max-commission-rate-change 0.01 \
  --email $EMAIL
```

Теперь нужно застейкать имеющиеся токены в своего валидатора:

```bash
namada client bond \
  --validator $NAMADA_ALIAS \
  --amount 1000
```

Ждем две эпохи и проверяем стейк:

```bash
namada client bonds --owner $NAMADA_ALIAS
```

&#x20;Текущую эпоху можно получить следующей командой:

```bash
namada client epoch
```

### Полезные команды&#x20;

Список полезных команд включает способы управления и мониторинга ноды Namada:&#x20;

* **Получить список всех валидаторов и сумму застейканых (самостоятельно и делегированных) токенов**

```bash
namada client bonded-stake
```

* **Просмотр логов**

```bash
journalctl -fu namada -o cat
```

* **Удалить ноду**

```bash
sudo systemctl stop namadad
sudo systemctl disable namadad
sudo rm -rf /etc/systemd/system/namadad.service
sudo systemctl daemon-reload
sudo rm /usr/local/bin/namada*
sudo rm -rf $HOME/.local/share/namada
```

***

_Powered by_ [_<mark style="color:blue;">deNodes</mark>_](https://twitter.com/deNodes\_)
