# Services for the FreeFeed server development

The [FreeFeed server](https://github.com/FreeFeed/freefeed-server) development requires two additional network services: the PostgreSQL database and the Redis key-value store.

It is often not easy to install these services locally, especially on Windows. This repository will help you to create and run virtual machine (VM) with all necessary services installed and working.

## Preparations
First you need to install [Vagrant](https://www.vagrantup.com/), the virtual machines management tool.

Second, you need to have some virtual machines provider. This repository supports the following providers: [Oracle VirtualBox](https://www.virtualbox.org/) and [Microsoft Hyper-V](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/). It is up to you to choose which providers to use.

### VirtualBox
It is probably the easiest way if you haven't already worked with virtual machines. You just need to install the [Oracle VirtualBox](https://www.virtualbox.org/).

### Hyper-V
Hyper-V is included by default in Windows starting from 8.1 version (Enterprise, Pro, or Education only) but require to be enabled by user (see [here](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) and [here](https://www.vagrantup.com/docs/hyperv/)).

Keep in mind that enabling Hyper-V will cause VirtualBox, VMware, and any other virtualization technology to no longer work. Hyper-V is also required for Docker. If you have Docker installed on your PC, you already have Hyper-V enabled.

## Starting up
So when you made all preparations, download this repository to the separate folder and run the following command:

For **VirtualBox** provider:
```
vagrant up
```

For **Hyper-V** provider (⚠ run with admin rights):
```
vagrant up --provider=hyperv
```

The Vagrant will create and configure virtual machine with the PostgreSQL and Redis services.

To stop the machine use `vagrant suspend` command, and to start it again use `vagrant resume` or `vagrant up` (you can omit `--provider` flag if machine is already created). See [Vagrant docs](https://www.vagrantup.com/docs) for more details.

## Configuration

The VM has a separate private IP address on your host machine. You need this address to configure the FreeFeed server. Vagrant will show this address when machine starts. It is recommended to install small helper [vagrant-address](https://github.com/mkuzmin/vagrant-address) plugin: just type `vagrant plugin install vagrant-address`. After the plugin installation, you will be able to view the VM IP address by command `vagrant address`.

To set the FreeFeed server up, replace the `"your.vm.ip.address"` strings in 'local.json' to the actual address of your VM and copy the 'local.json' file to the 'config' directory of FreeFeed server. This file will override the default locations of PostgreSQL and Redis.
