Building
========

The image can be built from source by running:

        docker build .

A recommended security practice is to add an additional unprivileged user to run the daemon as on the host. For example, as a privileged user, run this on the host:

        useradd monerod

To build an image which uses this unprivileged user's id and group id, run:

        docker build --build-arg USER_ID=$( id -u monerod ) --build-arg GROUP_ID=$( id -g monerod ) .

Now, when the container is run with the default options, the monerod process will only have the privileges of the monerod user on the host machine. This is especially important for a process such as monerod which runs as a network service exposed to the internet.
