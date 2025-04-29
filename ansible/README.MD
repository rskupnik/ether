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

Remember to only setup the server or the agent on the nodes, not both.