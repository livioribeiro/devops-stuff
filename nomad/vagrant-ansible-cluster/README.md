# [Vagrant](https://www.vagrantup.com) Ansible Cluster

Creates a [Nomad](https://www.nomadproject.io) / [Consul](https://www.consul.io) / [Vault](https://www.vaultproject.io) cluster using [Traefik](https://traefik.io/) as reverse proxy.

The cluster is composed by 8 CentOS machines:

- 3 server VMs:
  - IPs 172.10.10.11-13
  - Consul server
  - Nomad server
- 3 worker VMs:
  - IPs 172.10.10.21-23
  - Consul client
  - Nomad client
  - Docker
  - OpenJDK
- 1 VM running Vault
  - IP 172.10.10.31
  - also running Consul client
- 1 VM running Traefik
  - IP 172.10.10.100
  - also runnig Consul client

The machines are provisioned using Ansible through the [*ansible_local*](https://www.vagrantup.com/docs/provisioning/ansible_local.html) provisioner. This way, it is not necessary to have Ansible installed on the host machine.

Traefik is configured as follow:

- Dashboard running on http://172.10.10.100:8080
- Consul UI: http://consul.172.10.10.100.nip.io/ui
- Nomad UI: http://nomad.172.10.10.100.nip.io/ui
- Vault UI: http://vault.172.10.10.100.nip.io/ui
- Services deployed on nomad: http://service-name.service.172.10.10.100.nip.io

The [Consul Catalog provider](https://docs.traefik.io/configuration/backends/consulcatalog) is used to expose the services running on Nomad.

By default, services are not exposed unless they have the tag `traefik.enable=true`:

```hcl
service {
    name = "my-service"
    port = "some-port"
    tags = ["traefik.enable=true"]
}
```