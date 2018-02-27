monerod for Docker
===================

[![Docker Stars](https://img.shields.io/docker/stars/kylemanna/monerod.svg)](https://hub.docker.com/r/kylemanna/monerod/)
[![Docker Pulls](https://img.shields.io/docker/pulls/kylemanna/monerod.svg)](https://hub.docker.com/r/kylemanna/monerod/)
[![Build Status](https://travis-ci.org/kylemanna/docker-monerod.svg?branch=master)](https://travis-ci.org/kylemanna/docker-monerod/)
[![ImageLayers](https://images.microbadger.com/badges/image/kylemanna/monerod.svg)](https://microbadger.com/#/images/kylemanna/monerod)

Docker image that runs the Monero monerod node in a container for easy deployment.


Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. [Vultr](http://bit.ly/1HngXg0), [Digital Ocean](http://bit.ly/18AykdD), KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 100 GB to store the block chain files (and always growing!)
* At least 1 GB RAM + 2 GB swap file

Recommended and tested on unadvertised (only shown within control panel) [Vultr SATA Storage 1024 MB RAM/250 GB disk instance @ $10/mo](http://bit.ly/vultrmonerod).  Vultr also *accepts Bitcoin payments*!


Really Fast Quick Start
-----------------------

One liner for Ubuntu 14.04 LTS machines with JSON-RPC enabled on localhost and adds upstart init script:

    curl https://raw.githubusercontent.com/kylemanna/docker-monerod/master/bootstrap-host.sh | sh -s trusty


Quick Start
-----------

1. Create a `monerod-data` volume to persist the monerod blockchain data, should exit immediately.  The `monerod-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker volume create --name=monerod-data
        docker run -v monerod-data:/monero --name=monerod-node -d \
            -p 18081:18081 \
            -p 127.0.0.1:18080:18080 \
            kylemanna/monerod

2. Verify that the container is running and monerod node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        kylemanna/monerod:latest     "xmr_oneshot"       2 seconds ago       Up 1 seconds        127.0.0.1:18080->18080/tcp, 0.0.0.0:18081->18081/tcp   monerod-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f monerod-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* Additional documentation in the [docs folder](docs).
