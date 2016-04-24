#!/bin/bash
#
#  Copyright (c) Paul Steffensen (@uptimeDBA) 2016.

#  Script to be executed from the roachdb user.


#  Unpack and install the CockroachDB pre-built binary
#  into /usr/local/bin so it can be found by the PATH
#  
echo "Installing latest CockroachDB pre-built binary"

if [ ! -f "/vagrant/cockroach-beta-latest.linux-amd64.tgz" ]; then
   echo "cockroach-beta-latest.linux-amd64.tgz not found."
   exit 1
fi

cd ${HOME}
tar -xzf /vagrant/cockroach-beta-latest.linux-amd64.tgz

sudo cp cockroach-beta-*.linux-amd64/cockroach /usr/local/bin/
sudo chmod 755 /usr/local/bin/cockroach
sudo chown roachdb:roachdb /usr/local/bin/cockroach



#  Create the node SSL certificates in the $HOME/certs directory.
#  The commands will create the certs directory if needed.
#
if [ ! -d "${HOME}/certs" ]; then
   mkdir -m 700 ${HOME}/certs
fi

if [ -d "${HOME}/certs" ]; then
   cd ${HOME}/certs/ && rm -f node.cert node.key 
fi

cd ${HOME}
echo "Creating SSL certificates in $HOME/certs"

#  Create the node certificate and key. Use the ca cert to sign the node key
#
/usr/local/bin/cockroach cert create-node  localhost ${HOSTNAME} --ca-cert=certs/ca.cert --ca-key=certs/ca.key --cert=certs/${HOSTNAME}.cert --key=certs/${HOSTNAME}.key 


# Install the cockroach man pages
#
sudo su - -c "cd /usr/local/share; cockroach gen man"


# Vagrant's "change host name" functionality associates the hostname to the loopback address.
# This conflicts with the existing host entries so remove it.
#
sudo sed -ri 's/127\.0\.0\.1\s.*/127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4/' /etc/hosts

#
##################  End of Script  ##################  
