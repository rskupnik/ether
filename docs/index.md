# Ether Homelab Documentation

Welcome to the documentation for Ether, a personal Kubernetes homelab setup. This documentation provides comprehensive information about the architecture, setup, configuration, and operation of this homelab.

## Overview

Ether is a personal Kubernetes homelab built with Raspberry Pi 5 nodes running k3s. It leverages modern DevOps practices including GitOps with ArgoCD, infrastructure provisioning with Ansible, and containerized applications for various personal and professional tasks.

## Architecture

The homelab consists of:
- 3x Raspberry Pi 5 nodes with NVMe storage
- Kubernetes cluster (k3s) for container orchestration
- GitOps deployment with ArgoCD
- Network connectivity via Tailscale
- Storage managed by Longhorn
- Various applications for personal and professional use

## Key Technologies

- **Kubernetes**: k3s lightweight Kubernetes implementation
- **Infrastructure**: Ansible for provisioning and configuration management
- **GitOps**: ArgoCD for declarative application management
- **Storage**: Longhorn for distributed storage
- **Networking**: Tailscale for secure networking
- **Security**: SOPS, Sealed Secrets for secret management
- **Monitoring**: Prometheus + Grafana
- **Applications**: Immich, PaperlessNGX, N8N, Authentik, and more

## Components

### Hardware
- Raspberry Pi 5 nodes with PoE HATs
- NVMe SSDs for local storage
- External NAS for permanent data storage
- Network switch and LCD display

### Software
- Kubernetes cluster with 3 nodes
- GitOps with ArgoCD applications
- Monitoring with Prometheus and Grafana
- Security tools and certificate management
- Various self-hosted applications including:
  - **n8n**: Workflow automation tool for personal and business tasks
  - Immich: Photo management
  - PaperlessNGX: Document digitization
  - Authentik: Identity and access management
  - And more...

## Documentation Structure

This documentation is organized into the following sections:

1. **Overview** - General information about the homelab
2. **Hardware** - Details about the physical setup
3. **Software Stack** - Technologies and tools used
4. **Infrastructure Setup** - How the system is provisioned and configured
5. **Networking** - Network architecture and configuration
6. **Operations** - Daily operations and maintenance
7. **Applications** - Documentation for each application
   - [n8n](n8n.md) - Workflow automation tool
8. **Troubleshooting** - Common issues and solutions

## Getting Started

To explore the homelab setup:
1. Review the Ansible playbooks in `/ansible/`
2. Examine the ArgoCD applications in `/argo/apps/`
3. Check the hardware configuration in the README

## Contributing

This documentation is part of a personal project. While the code and configurations are open, the documentation is maintained for personal use. However, feedback and suggestions are welcome.
