<p align="center">
  <img src="docs/assets/ether_logo_256.png" alt="ether logo" width="220">
</p>

<p align="center">
  Personal Kubernetes Homelab
</p>

## What’s inside

- `ansible/` - Ansible inventories, roles and playbooks used to bootstrap/maintain hosts
- `argo/` - Argo CD apps / app-of-apps definitions (GitOps manifests)
- `certificates/` - Certificate-related assets (CA, leaf certs, issuance configs, etc.)
- `ssh-keys/` - SSH keys
- `justfile` - Common automation tasks
- `docs/` - Documentation

## What it can do

> Note: This section is still under construction! I want to create an extensive documentation and blog posts for all the cool features I have been working on, but that takes time

While I work on full documentation, here are some of the features I personally find cool about my homelab:
* It uses Tailscale and IPTables setup to join two networks together. Read more about it [in this blog post (a bit outdated)](https://myzopotamia.dev/joining-together-home-networks-using-tailscale)
* It uses Github Runners for automatically building and deploying a few of my own applications (including the blog) to the cluster.
* It uses ArgoCD for a full GitOps setup of software. Coupled with Ansible for provisioning, it is quite easy to recreate the cluster entirely from scratch
* It uses Longhorn for partitioning ephemeral storage and sharing that space between nodes. It also ensures data replication
* It uses Cloudflare Tunnels for external access (like the blog, but not only) paired with NGINX proxy sidecars for allowlisting only specific paths
* It hosts n8n which is used for automating a lot of stuff for both me personally a family company
* It hosts very cool self-hostable applications, such as Immich (for managing photos) and PaperlessNGX (for digitizing documents)

## Tools used

- `k3s` for a lightweight Kubernetes implementation
- **Ansible** for provisioning the nodes and making k3s work
- **ArgoCD** for a GitOps approach to managing applications inside the cluster
- **Kustomize** (with **Helm** enabled) for declarative
- **SOPS** for encrypting sensitive data with a GPG key
- `just` + **Justfile** for declaring common operations

## Hardware

<p align="center">
  <img src="docs/assets/ether_photo.jpg" alt="ether logo" width="280">
</p>

This homelab currently runs on 3x Raspberry Pi 5 Nodes with a [Waveshare PoE M.2 HAT+](https://www.waveshare.com/wiki/PoE_M.2_HAT+) and a 512 GB SSD M.2 disk on each node.

The local storage is managed by Longhorn for data replication. This storage is intended for ephemeral and non-critical data.

There is also an external NAS server for permanent data.

## Software

For more details on what is running inside Ether, see the `argo/` directory.

Here's a quick non-exhaustive list:
* Authelia
* Personal blog
* Cert Manager
* Cloudflare Tunnel
* Github Actions Runners
* Homepage (dashboard)
* Immich
* Longhorn
* MetalLB
* N8N
* Ntfy
* PaperlessNGX
* PiHole
* Prometheus + Grafana
* Sealed Secrets
* Umami
* Uptime Kuma

## How to run it

> Note: Due to the personal nature of this project, the setup process might contain issues that require manual resolving

1. Go to the `ansible` directory and follow instructions to provision the Raspberry Pi 5 nodes
2. Go to the `argo/bootstrap` directory and run the `just bootstrap` recipe for bootstrapping Argo
3. Go to Argo and make sure all the apps work properly

## Plans for the future

Here are some more or less defined plans for the future:
* Add a stronger node to the cluster (something with more horsepower than RPi) to be used for a Media Center at some point
* Add some sort of GPU capable of running a good-enough AI model locally (not sure if the hardware is there yet)
* (Alternative to above) Setup my personal gaming PC with a wake-on-lan in such a way that the cluster can wake it up and make use of the strong GPU there to run AI stuff when needed and then turn it off (it's expensive to keep the PC running all the time)
* Create some cool dashboards and display them on the LCD screen instead of just the static logo
* Install even more cool applications
* Document all the stuff I find interesting with extensive diagrams and possible write a few blog posts about this setup
* (Not sure if I want this yet) Use some sort of coding agent to make it live in the cluster and work on progressive updates to the setup by producing PRs etc.
* Harden the whole setup: ensure certificates and TLS are used everywhere, add safety features like fail2ban, add DNS-over-TLS, etc.

## AI Disclosure

All of the manifests inside `argo/` directory have been **written by a human entirely**, albeit with research being done using OpenAI Chat GPT where needed.

Ansible playbooks have been mostly generated with the help of OpenAI Chat GPT and then adjusted by me.

## Author

You can read more about me on [my blog](https://myzopotamia.dev) (which is [hosted on this homelab!](argo/apps/blog/))

## ... Why?

I am a DevOps Engineer by trade and I just pretty much like doing what I do. This homelab setup is here so I can practice my skills. I do realize it is probably over-engineered and could be done much simpler, but it is done so on purpose - and the purpose is learning.