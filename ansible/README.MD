# Ansible for Ether

This folder contains an Ansible setup for provisioning the nodes for Ether.

At this point, you should have:
* Raspberry Pi devices plugged in and working (can SSH)
* NVMe disks attached (unpartitioned)

## Playbooks

### rpi

The playbooks inside `rpi` folder should be ran on a fresh Raspberry Pi with an unpartitioned disk.

They will create two partitions and clone the RPi system to the NVMe SSD.

### k3s

The playbooks inside `k3s` folder should be used to install a k3s cluster on the Raspberry Pi.

### tailscale

These playbooks are used to establish tailscale routings in such a way that both the offsite and onsite nodes function as if in a single network. These should be run on one of the nodes onsite (primary) and on one of the nodes offsite (secondary).

### offsite

These playbooks are for configuring the offsite node, mostly for backups

### lcd

The playbooks in here are used on one of the onsite nodes to configure the LCD logo screen

## How to setup

Assuming you have both Raspberry Pi 5 devices available at SSH with attached unpartitioned NVMe disks:
1. Disable WiFi with `ansible-playbook playbooks/rpi/01_disable_wifi.yaml`
2. Partition the NVMe drive with `ansible-playbook playbooks/rpi/02_partition_nvme.yaml`
3. Clone the `/boot` and `/` folders from SD card to NVMe: `ansible-playbook playbooks/rpi/03_rpi_clone.yaml`
4. Verify the cloning was successful by booting down the nodes, pulling sd cards out and booting them back up - they should work

Once you have Raspberry Pis provisioned with NVMe disks and the filesystems copied over, you can provision k3s:
1. Prepare the nodes with `ansible-playbook playbooks/k3s/01_prepare_nodes.yaml` (this will install prerequisites)
2. Install k3s server: `ansible-playbook playbooks/k3s/02_install_k3s_server.yaml`
3. Install k3s agent: `ansible-playbook playbooks/k3s/03_install_k3s_agent.yaml`
4. Fetch kubeconfig: `ansible-playbook playbooks/k3s/04_fetch_kubeconfig.yaml`
5. You should see the kubeconfig at `playbooks/k3s/kubeconfig_raw.yaml`
6. If this is the only cluster - move the `kubeconfig_raw.yaml` file and replace `~/.kube/config` file - otherwise merge

The rest is optional:
* Use `offsite` playbooks to setup the offsite node for backups
* Use `tailscale` playbooks for setting up a tailscale network
* Use `lcd` playbooks for setting up the LCD logo screen