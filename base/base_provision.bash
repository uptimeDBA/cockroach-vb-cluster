#!/bin/bash

#  This script is run with root privileges so commands don't need to be prefixed with sudo.
#  It assumes an Internet connection is available via the host machine which is accessed via the NAT (eth1) 
#  interface of the VirtualBox guest(s).

#  The script is re-runnable in that you can execute it using "vagrant provision" and it shouldn't produce errors, but 
#  if an action has already been performed, it won't repeat it.
#  For example, if Go has already been installed and you want to re-install it, you will have to manually "rm -rf /usr/local/go"
#  before running "vagrant provision" (which will run this script).

#  Output a banner to identify the end out previous output and the start of this script's output.
#
echo << EOF

###
#
#  Executing provisioning script...
#
###
EOF


#  Update all installed packages from the base image to their latest versions.
#
echo  "Updating installed packages to latest versions"
dnf --quiet --assumeyes upgrade

#  Install additional software required for cockroachDB
#  git is required if you are building the cockroachDB software from source.
#
echo "Installing gcc-c++"
dnf --quiet --assumeyes install gcc-c++

echo "Installing git"
dnf --quiet --assumeyes install git 


#  Install Go from a local copy of the tarball that has been placed in the vagrant rsync directory (/vagrant).
#  Ensure the version of Go meets the requirements for cockroachDB.
#
if [ ! -d /usr/local/go ]; then
   echo "Installing Go"
   [ -r /vagrant/go1.6.linux-amd64.tar.gz ] && tar -C /usr/local -xzf /vagrant/go1.6.linux-amd64.tar.gz || echo "Go install file not found."
else
   echo "Go directory exists, not installing."
fi


#  Append the entries for the cluster nodes to the hosts file.
#
if  ! grep -q "node[A-Z]$" /etc/hosts ; then
   echo "Updating hosts file with cluster node entries."
   [ -r /vagrant/clusterhosts ] && cat /vagrant/clusterhosts >> /etc/hosts || echo "clusterhosts file not found."
else
   echo "hosts file contains node entries, not updating."
fi


#  Generate the encrypted password for the roachdb user.
#  There are lots of ways to do this but since we already have Perl on the machine...
#  Password is "changeme"
#
roachdb_passwd=`perl -e 'print crypt("changeme", "uptime")'`

#  The user will be placed into a private group, called roachdb.
#  Also include the user in the vboxsf group so it can access VirtualBox shared folders.
#
if  ! grep -q "^roachdb" /etc/passwd ; then
   echo "Adding roachdb user with password of \"changeme\""
   useradd --groups vboxsf --password $roachdb_passwd roachdb
else
   echo "roachdb user exists, not adding."
fi


#  The roachdb user will be the one that gets used for the vagrant ssh command 
#  instead of the default user "vagrant" in the CockroachDB node.
#  Install the Vagrant public key into the .ssh directory.
#
if [ ! -d ~roachdb/.ssh ]; then 
   echo "Setting up roachdb user for SSH."
   mkdir -p 700 ~roachdb/.ssh
   cp /vagrant/vagrant_insecure_public_key ~roachdb/.ssh/authorized_keys
   chmod 600 ~roachdb/.ssh/authorized_keys
   chown -R roachdb:roachdb ~roachdb/.ssh
else
   echo "SSH for roachdb already set up."
fi


#  Put the Go binaries in the user's PATH
#
if ! grep -q "/usr/local/go/bin" /home/roachdb/.bash_profile ; then
   echo "Adding /usr/local/go/bin to roachdb's PATH environment variable."
   echo "export PATH=\$PATH:/usr/local/go/bin" >> /home/roachdb/.bash_profile
else
   echo "/usr/local/go/bin exists in roachdb's PATH environment variable, not adding."
fi


#  Add the GOPATH variable to the user's environment.
#
if ! grep -q "^export GOPATH" /home/roachdb/.bash_profile ; then
   echo "Adding GOPATH to roachdb's .bash_profile"
   echo "export GOPATH=/home/roachdb" >> /home/roachdb/.bash_profile
else
   echo "GOPATH exists in roachdb's .bash_profile, not adding."
fi


#  Copy the install_cockroachDB.bash script to roachdb's home directory.
#
if [ ! -f ~roachdb/install_cockroachDB.bash ]; then
   echo "Copying install_cockroachDB.bash script to roachdb's home directory."
   cp -v /vagrant/install_cockroachDB.bash ~roachdb/
   chown roachdb:roachdb ~roachdb/install_cockroachDB.bash
   chmod 750 ~roachdb/install_cockroachDB.bash
else
   echo "install_cockroachDB.bash script already in ~roachdb/, not copying."
fi


#  Setup passwordless sudo for the ${db_owner} user.
#
if [ ! -f /etc/sudoers.d/roachdb-nopasswd ]; then
   echo "Adding roachdb user to sudoers."
   echo "roachdb ALL=NOPASSWD: ALL" > /etc/sudoers.d/roachdb-nopasswd
   chmod -v 644 /etc/sudoers.d/roachdb-nopasswd
else
   echo "roachdb user has sudo access, not adding."
fi

#
##################  End of Script  ##################  
