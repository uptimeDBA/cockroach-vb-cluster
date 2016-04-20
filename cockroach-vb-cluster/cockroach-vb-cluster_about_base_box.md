---
title: About the CockroachDB Base Box
tags: 
keywords: CockroachDB, Install, Setup, Guide, Tutorial
last_updated: 
summary: "Some background information about how the base box was constructed and it's contents."
---

{{site.data.alerts.important}}
There are no instructions on this page, it's just information to help you understand the constrcution of the base box should you wish to modify or make your own. Impatient people can skip to the next section but the information here will help you understand how this setup works.
{{site.data.alerts.end}}

The CockroachDB Vagrant base box was constructed using the 64 bit version of the Fedora Server distribution. The installation selected the "minimal" package group and all other default options.

## Additional Packages

Other than the default packages within the "minimal" group, the other packages changes were:

- Updated the kernel to version 4.4.6
- Installed the packages gcc, kernel-devel, kernel-headers, dkms, make, bzip2, and  perl to enable the VirtualBox Guest Additions to be built.
- Installed the nc (netcat) package for a way of testing open ports. This package is not required to run or install the cluster.


## Configuration Changes

- root password set to "changeme".
- VirtualBox Guest Additions installed.
- Boot timeout changed to 1 second to decrease machine startup time.
- Cluster node host entries added to /etc/hosts.
- `roachdb` operating system account created.
- Timezone set to UTC
- SELinux set to "enforcing"


## Guest Additions {#about_guest_additions}


A version of the VirtualBox Guest Additions has been pre-installed on the base box. It may not be the same version as the version of VirtualBox you are using. The Vagrant plugin `vagrant-vbguest` checks the Guest Additions version against the version of VirtualBox you are using during machine boot and takes care of it as follows:

- Guest Additions version is **less than** the VirtualBox version

  This is probably the more common case. The vagrant-vbguest will **upgrade** the box's Guest Additions to match the VirtualBox version.
  
- Guest Additions version is the **same as** the VirtualBox version

  The vagrant-vbguest plugin will check the versions and it they match, do nothing.
  
- Guest Additions version is **greater than** the VirtualBox version

  This might happen if VirtualBox is an older version. The vagrant-vbguest plugin will **downgrade** the Guest Additions to match the VirtualBox version.
  
The re-installation of the Guest Additions on each cluster node can take some time so please be patient during the first boot of your cluster. 


## Firewall Configuration

The firewall (firewalld) is enabled with a **cockroach** service added by creating a file called `cockroach.xml` in `/etc/firewalld/services` directory with the contents:

```Shell
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>CockroachDB</short>
  <description>CockroachDB Database Server internode communication.</description>
  <port protocol="tcp" port="26257"/>
  <port protocol="tcp" port="8080"/>
</service>
```

The file was assigned the correct SELinux context and file permissions using the commands:

```Shell
# cd /etc/firewalld/services
# restorecon cockroach.xml
# chmod 640 cockroach.xml
```

The service configuration was permanently added to the firewall.

```Shell
# firewall-cmd --permanent --add-service=cockroach
# firewall-cmd --reload
```

and checked with:

```Shell
# firewall-cmd --list-services
```


## What's Next?

We will [download and configure](cockroach-vb-cluster_configure_base_box) the pre-built CockroachDB Vagrant box.
