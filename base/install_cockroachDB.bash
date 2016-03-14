#!/bin/bash

#  Script to be executed from the roachdb user.
#  This script is currently not re-runnable.

go get -d github.com/cockroachdb/cockroach
cd $GOPATH/src/github.com/cockroachdb/cockroach
make build
make install

# Create the SSL certificates in the $HOME/certs directory.
#  The commands will create the certs directory if needed.
#
mkdir -m 700 ${HOME}/certs
cd ${HOME}/certs
echo "Creating SSL certificates in $HOME/certs"
cockroach cert create-ca     --ca-cert=${HOME}/certs/ca.cert --ca-key=${HOME}/certs/ca.key
cockroach cert create-node   --ca-cert=${HOME}/certs/ca.cert --ca-key=${HOME}/certs/ca.key --cert=${HOME}/certs/node.server.crt --key=${HOME}/certs/node.server.key 127.0.0.1 ::1 localhost client nodeA nodeB nodeC nodeD nodeE nodeF nodeG nodeH nodeI nodeJ nodeK nodeL nodeM nodeN nodeO nodeP nodeQ nodeR nodeS nodeT nodeU nodeV nodeW nodeX nodeY nodeZ 
cockroach cert create-client --ca-cert=${HOME}/certs/ca.cert --ca-key=${HOME}/certs/ca.key --cert=${HOME}/certs/node.client.crt --key=${HOME}/certs/node.client.key root


#  Add some node information in the roachdb .bash_profile to display on a login terminal 
#
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

#
##############  End of Script  ##############
