---
title: Vagrant
tags: 
keywords: CockroachDB, Install, Setup, Guide, Tutorial
last_updated: 
summary: "Install and configure Vagrant with the required plugin on your host machine."
---

Vagrant is a tool for building and managing virtualized environments. It can manage machines hosted in VirtualBox and makes it easy to install and manage a group of very similar machines like a cockroachDB cluster.

In particular, this guide uses a Vagrant [Multi-machine](https://www.vagrantup.com/docs/multi-machine/) setup to manage all the nodes using one Vagrant configuration.

See the [Installation](https://www.vagrantup.com/docs/installation/) page in the Vagrant documentation for more information.

See the [Vagrant Documentation](https://www.vagrantup.com/docs/) for more information about Vagrant.


## Install Vagrant
<span class="label label-info">Windows</span><span class="label label-success">Mac</span><span class="label label-warning">Linux</span>

Coming soon.


## Configure Vagrant

Coming soon but not a lot to do really.


### vagrant-vbguest Plugin
<span class="label label-info">Windows</span><span class="label label-success">Mac</span><span class="label label-warning">Linux</span>

Vagrant uses plugins to extend it’s core functionality.

This guide relies on the functionality contained within the Vagrant [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) plugin to automatically install the correct version of the VirtualBox Guest Additions in the CockroachDB node machines and to update them when your version of VirtualBox is updated. The plugin downloads and installs all the necessary dependent packages needed to build the guest additions.

1. To install the plugin, from the command prompt on the host machine, execute the `vagrant plugin install vagrant-vbguest` command.

   ```Shell
   > vagrant plugin install vagrant-vbguest
   Installing the 'vagrant-vbguest' plugin. This can take a few minutes...
   Installed the plugin 'vagrant-vbguest (0.11.0)'!
   >
   ```

2. Check that the plugin has been installed and it’s version using the `vagrant plugin list` command.

   ```Shell
   > vagrant plugin list
   vagrant-share (1.1.5, system)
   vagrant-vbguest (0.11.0)
   >
   ```
There should be no further configuration required but refer to the plugin’s [github page](https://github.com/dotless-de/vagrant-vbguest) for more information.


## What's Next?

A little bit [about](cockroach-vb-cluster_about_base_box) the pre-built CockroachDB Vagrant box.


