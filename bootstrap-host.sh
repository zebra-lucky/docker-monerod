#!/bin/bash
#
# Configure broken host machine to run correctly
#
set -ex

XMR_IMAGE=${XMR_IMAGE:-kylemanna/monerod}

distro=$1
shift

memtotal=$(grep ^MemTotal /proc/meminfo | awk '{print int($2/1024) }')

#
# Only do swap hack if needed
#
if [ $memtotal -lt 2048 -a $(swapon -s | wc -l) -lt 2 ]; then
    fallocate -l 2048M /swap || dd if=/dev/zero of=/swap bs=1M count=2048
    mkswap /swap
    grep -q "^/swap" /etc/fstab || echo "/swap swap swap defaults 0 0" >> /etc/fstab
    swapon -a
fi

free -m

if [ "$distro" = "trusty" -o "$distro" = "ubuntu:14.04" ]; then
    curl https://get.docker.io/gpg | apt-key add -
    echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list

    # Handle other parallel cloud init scripts that may lock the package database
    # TODO: Add timeout
    while ! apt-get update; do sleep 10; done

    while ! apt-get install -y lxc-docker; do sleep 10; done
fi

# Always clean-up, but fail successfully
docker kill monerod-node 2>/dev/null || true
docker rm monerod-node 2>/dev/null || true
stop docker-monerod 2>/dev/null || true

# Always pull remote images to avoid caching issues
if [ -z "${XMR_IMAGE##*/*}" ]; then
    docker pull $XMR_IMAGE
fi

# Initialize the data container
docker volume create --name=monerod-data
docker run -v monerod-data:/monero --rm $XMR_IMAGE xmr_init

# Start monerod via upstart and docker
curl https://raw.githubusercontent.com/kylemanna/docker-monerod/master/upstart.init > /etc/init/docker-monerod.conf
start docker-monerod

set +ex
echo "Resulting bitmonero.conf:"
docker run -v monerod-data:/monero --rm $XMR_IMAGE cat /monero/.bitmonero/bitmonero.conf
