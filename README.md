# Services for the FreeFeed server development

The [FreeFeed server](https://github.com/FreeFeed/freefeed-server) development requires two additional network services: the PostgreSQL database and the Redis key-value store.

It is often not easy to install these services locally, especially on Windows. This repository will help you to create and run virtual machine with all necessary services installed and working.

## Preparations
First you need to install [Vagrant](https://www.vagrantup.com/), the virtual machines management tool.

Second, you need to have some virtual machines provider. This repository supports the following providers: [Oracle VirtualBox](https://www.virtualbox.org/) and [Microsoft Hyper-V](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/).

### About the Hyper-V
Hyper-V is included by default in Windows starting from 8.1 version (Enterprise, Pro, or Education only) but require to be enabled by user (see [here](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) and [here](https://www.vagrantup.com/docs/hyperv/)). Keep in mind that enabling Hyper-V will cause VirtualBox, VMware, and any other virtualization technology to no longer work.
</details>

## Starting up
So when you made all preparations, download this repository to the separate folder and run the following command:

For VirtualBox provider:
```
vagrant up
```

For Hyper-V provider (⚠ run with admin rights):
```
vagrant up --provider=hyperv
```

The Vagrant will create and configure virtual machine with the PostgreSQL and Redis services.

To stop the machine use `vagrant suspend` command, and to start it again use `vagrant resume` or `vagrant up` (you can omit --provider flag if machine is already created). See Vagrant docs for more details.

## Configuration
To prevent collisions this VM exposes non-standard ports for the PostgreSQL (15432 instead of 5432) and Redis (16379 instead of 6379). You can change their values in 'Vagrantfile' file if you want.

To set the FreeFeed server up, copy the 'local.json' file to the 'config' directory of FreeFeed server. This file will override the default ports of PostgreSQL and Redis.
