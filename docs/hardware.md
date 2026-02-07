# Hardware

The Ether homelab consists of 3x Raspberry Pi 5 nodes with NVMe storage, connected through a Tailscale network for secure communication. The setup leverages modern DevOps practices with Kubernetes orchestration and GitOps deployment.

## Raspberry Pi 5 Nodes

### Hardware Specifications

- **Processor**: Raspberry Pi 5 with 8GB RAM
- **Storage**: NVMe SSDs for local storage
- **Networking**: Built-in Ethernet and Wi-Fi capabilities
- **Power**: PoE HATs for power-over-ethernet support

### Node Configuration

The homelab uses three identical Raspberry Pi 5 nodes and one Raspberry Pi 3 node:

1. **ethernode1** (Primary node)
   - Role: Control plane node and subnet router

2. **ethernode2**
   - Role: Worker node

3. **ethernode3**
   - Role: Worker node

4. **remote_pi** (Backup location)
   - Role: Remote worker node

## Storage Configuration

### Local Storage

- **NVMe SSDs**: Each Raspberry Pi node is equipped with NVMe SSDs for local storage
- **Performance**: NVMe provides high-speed storage for Kubernetes workloads and applications
- **Capacity**: Storage capacity varies by individual node but is sufficient for running k3s and applications

### External Storage

- **External NAS**: For permanent data storage and backups
- **Data Protection**: Critical data is stored on external NAS for redundancy
