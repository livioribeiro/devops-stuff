# Vagrant Ansible Cluster

Requires: ansible, python netaddr package

Creates a cluster from 6 VMs: 3 servers and 3 workers.

Each server runs consul and nomad in server mode and each worker runs consul and nomad in client mode.

Remeber to change the public network settings from `192.168.1.11` to an address that suits your network.