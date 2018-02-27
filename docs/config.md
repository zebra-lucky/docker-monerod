monerod config tuning
======================

You can use environment variables to customize config ([see docker run environment options](https://docs.docker.com/engine/reference/run/#/env-environment-variables)):

        docker run -v monerod-data:/monero --name=monerod-node -d \
            -p 18081:18081 \
            -p 127.0.0.1:18080:18080 \
            -e DISABLEWALLET=1 \
            -e PRINTTOCONSOLE=1 \
            -e RPCUSER=mysecretrpcuser \
            -e RPCPASSWORD=mysecretrpcpassword \
            kylemanna/monerod

Or you can use your very own config file like that:

        docker run -v monerod-data:/monero --name=monerod-node -d \
            -p 18081:18081 \
            -p 127.0.0.1:18080:18080 \
            -v /etc/mybitmonero.conf:/monero/.bitmonero/bitmonero.conf \
            kylemanna/monerod
