#  Vagrant configuration file for a multi-node VirtualBox cluster
#  
#
#  Copyright (C) 2016 Paul Steffensen (@uptimeDBA) - All Rights Reserved
#  Permission to copy and modify is granted under the Apache license
#
#  By default only the client machine and the first 3 nodes are started
#  if a "vagrant up" command is issued in the cluster directory.
#  This is an arbituary number of nodes, you can have up to 254 which is the limit of the 
#  192.168.56.0/24 network.
#  Other nodes can be administered by including the node name or a regular expression 
#  representing a number of nodes. Enclose the expression in forward slashes.
#
#  For example: vagrant up nodeH
#		vagrant up /node[L-S]/
#
nodes = [
    { :name => "client", :ip => "192.168.56.110", :autostart => true, },
    { :name => "nodeA",  :ip => "192.168.56.111", :autostart => true, },
    { :name => "nodeB",  :ip => "192.168.56.112", :autostart => true, },
    { :name => "nodeC",  :ip => "192.168.56.113", :autostart => true, },
    { :name => "nodeD",  :ip => "192.168.56.114", :autostart => false, },
    { :name => "nodeE",  :ip => "192.168.56.115", :autostart => false, },
    { :name => "nodeF",  :ip => "192.168.56.116", :autostart => false, },
    { :name => "nodeG",  :ip => "192.168.56.117", :autostart => false, },
    { :name => "nodeH",  :ip => "192.168.56.118", :autostart => false, },
    { :name => "nodeI",  :ip => "192.168.56.119", :autostart => false, },
    { :name => "nodeJ",  :ip => "192.168.56.120", :autostart => false, },
    { :name => "nodeK",  :ip => "192.168.56.121", :autostart => false, },
    { :name => "nodeL",  :ip => "192.168.56.122", :autostart => false, },
    { :name => "nodeM",  :ip => "192.168.56.123", :autostart => false, },
    { :name => "nodeN",  :ip => "192.168.56.124", :autostart => false, },
    { :name => "nodeO",  :ip => "192.168.56.125", :autostart => false, },
    { :name => "nodeP",  :ip => "192.168.56.126", :autostart => false, },
    { :name => "nodeQ",  :ip => "192.168.56.127", :autostart => false, },
    { :name => "nodeR",  :ip => "192.168.56.128", :autostart => false, },
    { :name => "nodeS",  :ip => "192.168.56.129", :autostart => false, },
    { :name => "nodeT",  :ip => "192.168.56.130", :autostart => false, },
    { :name => "nodeU",  :ip => "192.168.56.131", :autostart => false, },
    { :name => "nodeV",  :ip => "192.168.56.132", :autostart => false, },
    { :name => "nodeW",  :ip => "192.168.56.133", :autostart => false, },
    { :name => "nodeX",  :ip => "192.168.56.134", :autostart => false, },
    { :name => "nodeY",  :ip => "192.168.56.135", :autostart => false, },
    { :name => "nodeZ",  :ip => "192.168.56.136", :autostart => false, },
]


Vagrant.configure(2) do |config|

   #  This is the name of the vagrant box created with the vagrant package command in the guide.
   #
   config.vm.box = "CockroachDB"
   
   #  Change the name of the SSH user so vagrant commands will use "roachdb" instead of "vagrant".
   #
   config.ssh.username = "roachdb"
   config.ssh.insert_key = false

   #  Loop over each entry in the nodes array
   #
   nodes.each do |node|
   
      config.vm.define node[:name], autostart: node[:autostart] do |nodeconfig|
      
         #  Set the hostname and add the Host-only (192.168.56.0/24) network interface.
         #
         nodeconfig.vm.hostname = node[:name]
         nodeconfig.vm.network :private_network, ip: node[:ip]
         
         #  Change or add VirtualBox provider settings in this block
         #
         nodeconfig.vm.provider "virtualbox" do |vb|
         
            #  Put the VM in the "CockroachDB Cluster" group
	    #
            vb.customize ["modifyvm", :id, "--groups", "/CockroachDB Cluster" ]
         
            #  Set the VirtualBox machine name
            #
            vb.name = node[:name]
            
            #  The amount of memory for each cluster node.
            #  The practical maximum depends on the amount of physical memory on your host
            #  and the number of cluster nodes.
            #
            vb.memory = 1024
            
            #  The number of virtual CPUs allocated to each cluster node.
            #  The practical maximum depends on the amount of physical cores on your host
            #  and the number of cluster nodes.  
            #
            vb.cpus = 2
            
            #  Adjust the VirtualBox timesync parameters to keep better time synchronization 
            #  between the host and cluster nodes.
            #
            vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-min-adjust", 50 ]
            vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]
            vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-start" ]
            vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-on-restore", 1 ]
         end
         
         nodeconfig.vm.provision :shell,  :path => "node_provision.bash", privileged: false
         
      end
   end 
end