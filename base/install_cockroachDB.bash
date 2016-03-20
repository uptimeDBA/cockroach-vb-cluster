#!/bin/bash

#  Script to be executed from the roachdb user.
#  This script is currently not re-runnable.

echo "Install CockroachDB pre-built binary"

cd ${HOME}
if [ -f "cockroach.linux-amd64.tgz" ]; then
   rm -f cockroach.linux-amd64.tgz
fi

wget --quiet https://binaries.cockroachdb.com/cockroach.linux-amd64.tgz

# check return code

tar -xzf cockroach.linux-amd64.tgz

if [ ! -d ${HOME}/bin ]; then
   mkdir -m 750 ${HOME}/bin
fi

cp cockroach.linux-amd64/cockroach ${HOME}/bin/
chmod 750 ${HOME}/bin/cockroach


# Create the SSL certificates in the $HOME/certs directory.
#  The commands will create the certs directory if needed.
#
if [ ! -d "${HOME}/certs" ]; then
   mkdir -m 700 ${HOME}/certs
fi

if [ -d "${HOME}/certs" ]; then
   cd ${HOME}/certs/ && rm -f ca.cert ca.key node.cert node.key client.cert client.key
fi

cd ${HOME}
echo "Creating SSL certificates in $HOME/certs"

cockroach cert create-ca     --ca-cert=certs/ca.cert --ca-key=certs/ca.key

#  Create   key/cert pairs for the cluster nodes.
cockroach cert create-node   --ca-cert=certs/ca.cert --ca-key=certs/ca.key --cert=certs/node.cert --key=certs/node.key 127.0.0.1 localhost client nodeA nodeB nodeC nodeD nodeE nodeF nodeG nodeH nodeI nodeJ nodeK nodeL nodeM nodeN nodeO nodeP nodeQ nodeR nodeS nodeT nodeU nodeV nodeW nodeX nodeY nodeZ
cockroach cert create-client --ca-cert=certs/ca.cert --ca-key=certs/ca.key --cert=certs/client.cert --key=certs/client.key root


# Install the cockroach man pages
#
echo "Installing cockroach man pages into /usr/local/share/man/man1/"
sudo su - -c "cd /usr/local/share; ~roachdb/bin/cockroach gen man"

#  Add some node information in the roachdb .bash_profile to display on a login terminal
#
if  ! grep -q "^#  Display some version info." ~/.bash_profile ; then
cat << EOF >> ~/.bash_profile
#  Display some version info.
#
if [ ! -z "\$TERM" ]; then
   echo
   [ -r "/etc/fedora-release" ] && echo; cat /etc/fedora-release || echo "File /etc/fedora-release not found."
   echo "CockroachDB info:"
   [ -x ~/bin/cockroach ] && cockroach version | head -3 || echo "cockroach executable not found."
   echo
fi

EOF
fi

#
##############  End of Script  ##############
