---
title: Overview
tags: 
keywords: CockroachDB, Install, Setup, Guide, Tutorial
last_updated: 
summary: "We will be downloading a pre-built Vagrant box and using it to create a multi-node CockroachDB cluster."
---

## Logical Architecture

For a high-level overview of what you will be building with this guide, the logical architecture of the cluster looks like this:

![virtualbox architecture](images/virtualbox_architecture.png)

Vagrant and VirtualBox work on Max OS/X and Linux so you could use one of those for the host machine instead of Windows. Instructions for a Mac or Linux host are included where they differ from those on Windows.

If you haven't used VirtualBox or Vagrant before, I would recommend you read [Chapter 1. First
Steps](https://www.virtualbox.org/manual/ch01.html) in the VirtualBox manual and the [Why Vagrant](https://www.vagrantup.com/docs/why-vagrant/index.html) section of the Vagrant documentation. 


## Hardware Requirements

The cluster in this guide was constructed on a 64bit Windows 10 Professional host machine with an Intel i7-4770 CPU and 32Gb of memory.
The minimun (and default) configuration is 3 CockroachDB cluster nodes and 1 client machine, each has 2 vCPUs and 1Gb of memory.


### Operating System

The host machine needs to run [VirtualBox](https://www.virtualbox.org) and [Vagrant](https://www.vagrantup.com) (and [Cygwin](https://www.cygwin.com) if you are using Windows).
VirtualBox and Vagrant are supported by various versions of Windows, Linux, and Mac OS X. Please check the version compatibility of these products against your version of your host operating system.


### Memory

The suggested minimum host machine memory requirement is **8 Gb** but the amount of CPU, memory, disk your host machine has will ultimately determine the size and number of virtual CockroachDB machines you can run.


### Disk

Each virtual machine as a single 30 Gb, dynamically allocated VMDK type disk. Because the disk is dynamically allocated, the actual disk size of each node is less than 1.5 Gb when started. The amount of data loaded into the database will determine the final disk space used, up to 30Gb for each machine.

The suggested minimum host machine disk space requirement is **6 Gb** but the amount of CPU, memory, disk your host machine has will ultimately determine the size and number of virtual CockroachDB machines you can run.

The theoretical maximum host machine disk space requirement is approximately **800 Gb** if you started all 26 cluster nodes and filled all their disk.

{{site.data.alerts.important}}
The VirtualBox machines that get created will reside in the VirtualBox Default Machine Folder. By default this is called "VirtualBox VMs" and on Windows is set to %HOMEDRIVE%%HOMEPATH% which is usually C:\Users\username\. On Mac OS X, it's /Users/username, and on Linux it's /home/username. 
This is where most of the disk space will be consumed.
{{site.data.alerts.end}}


## Software Requirements

The following software components are required on the host machine. The versions listed are the versions used in this guide.
Versions greater than those listed should also work.

|--
| Software | Version
|:-|:-
| Cygwin* | 2.4.1
| VirtualBox | 5.0.14
| Vagrant | 1.8.1
|---

\*If you are using a Linux or Mac host, you don't need Cygwin.

The following pages will instruct you how to install and setup this software.


## What's Next?

Install the required software on the host machine. If you're on Windows, start with [Cygwin](cockroach-vb-cluster_cygwin), otherwise jump straight to installing [VirtualBox](cockroach-vb-cluster_virtualbox).

