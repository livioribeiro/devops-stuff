# Vagrant Ansible Cluster

Creates a cluster from 6 VMs: 3 servers and 3 workers.

Each server runs consul and nomad in server mode and each worker runs consul and nomad in client mode.

Access the Consul ui from http://172.10.10.11:8500/ui and the Nomad ui from http://172.10.10.11:4646/ui