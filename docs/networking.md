# Networking

This document describes the networking setup for the Ether homelab. The network architecture leverages Tailscale for secure networking between sites, enabling seamless communication while maintaining security boundaries.

## Overview

The Ether homelab uses a hybrid networking approach combining two local network infrastructures with Tailscale for secure inter-site communication. The setup consists of:

- Local network with static IP addresses in the 192.168.0.0/24 subnet
- A secondary local network with stat IP addresses 192.168.178.0/24
- Tailscale for secure inter-node communication and external access
- Routing rules to enable communication between local and Tailscale networks
- Network security through Tailscale's encrypted mesh network

## Network Topology

The homelab consists of multiple network segments:

1. **Local Network (192.168.0.0/24)**: This is the primary local network for the Raspberry Pi nodes
2. **Tailscale Network (100.64.0.0/10)**: Tailscale's encrypted mesh network
3. **Remote Network (192.168.178.0/24)**: Secondary network location, mainly for backup

## Hardware and Network Configuration

The Raspberry Pi nodes are configured with:
- Static IP addresses in the 192.168.0.0/24 subnet
- Tailscale installed and configured as a subnet router
- IP forwarding enabled for routing between networks

### Inventory Configuration

The Ansible inventory defines the network topology:

```yaml
all:
  children:
    ether_nodes:
      vars:
        ansible_user: pi
      hosts:
        ethernode1:
          ansible_host: 192.168.0.192
        ethernode2:
          ansible_host: 192.168.0.193
        ethernode3:
          ansible_host: 192.168.0.120
        remote_pi:
          ansible_host: 192.168.178.69
```

## Tailscale Configuration

Tailscale is configured as a subnet router to enable seamless communication between nodes:

- **Primary node (ethernode1)**: Configured as subnet router with `--advertise-routes=192.168.0.0/24`
- **IP forwarding**: Enabled on the primary node to route traffic between networks
- **Routing rules**: iptables rules configured to allow traffic between local and Tailscale networks

### Key Tailscale Parameters

```bash
--advertise-routes=192.168.0.0/24
--snat-subnet-routes=false
--accept-routes
```

## Routing Rules

The routing between networks is managed through iptables rules configured by Ansible playbooks:

1. **Forwarding rules**: Allow traffic between Tailscale and local networks
2. **Persistent rules**: iptables rules saved for persistence across reboots
3. **Security**: Rules ensure only necessary traffic is allowed

### Example Routing Configuration

```yaml
- name: Configure persistent, idempotent routing with iptables
  hosts: ethernode1
  become: true
  vars:
    this_subnet_cidr: "192.168.0.0/24"
    other_subnet_cidr: "192.168.178.0/24"
    other_rpi_tailscale_ip: "100.121.217.85"
    admin_ip: "100.104.91.122"

  tasks:
    - name: Define routing rules
      ansible.builtin.iptables:
        chain: FORWARD
        in_interface: "{{ item.in_iface }}"
        out_interface: "{{ item.out_iface }}"
        source: "{{ item.source }}"
        destination: "{{ item.dest }}"
        jump: ACCEPT
        ip_version: ipv4
        state: present
      loop:
        - { in_iface: "tailscale0", out_iface: "eth0", source: "{{ other_subnet_cidr }}", dest: "{{ this_subnet_cidr }}" }
        - { in_iface: "eth0", out_iface: "tailscale0", source: "{{ this_subnet_cidr }}", dest: "{{ other_subnet_cidr }}" }
        - { in_iface: "tailscale0", out_iface: "eth0", source: "{{ other_rpi_tailscale_ip }}", dest: "{{ this_subnet_cidr }}" }
        - { in_iface: "eth0", out_iface: "tailscale0", source: "{{ this_subnet_cidr }}", dest: "{{ other_rpi_tailscale_ip }}" }
        - { in_iface: "tailscale0", out_iface: "eth0", source: "{{ admin_ip }}", dest: "{{ this_subnet_cidr }}" }
        - { in_iface: "eth0", out_iface: "tailscale0", source: "{{ this_subnet_cidr }}", dest: "{{ admin_ip }}" }
```

## Security

The networking setup prioritizes security through:

1. **Tailscale Encryption**: All traffic is encrypted using Tailscale's mesh network
2. **Network Segmentation**: Clear separation between local and remote networks
3. **Minimal Exposure**: Only necessary ports and routes are open
4. **Access Control**: Tailscale's access control features for granular permissions

## References

- [Tailscale Documentation](https://tailscale.com/kb/)
- [Tailscale Subnet Router](https://tailscale.com/kb/1019/subnet-routers/)
- [Ansible iptables module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/iptables_module.html)