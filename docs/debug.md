# Debugging

## Things to Check

* RAM utilization -- monerod is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The monero blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 40GB+ is necessary.

## Viewing monerod Logs

    docker logs monerod-node


## Running Bash in Docker Container

*Note:* This container will be run in the same way as the monerod node, but will not connect to already running containers or processes.

    docker run -v monerod-data:/monero --rm -it kylemanna/monerod bash -l

You can also attach bash into running container to debug running monerod

    docker exec -it monerod-node bash -l
