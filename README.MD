# ether

Infrastructure-as-code repository for provisioning and operating an environment using **Ansible** (machine/bootstrap configuration) and **Argo CD** (GitOps delivery of Kubernetes workloads), plus supporting materials like certificates and SSH keys.

> This repo appears to be a personal/ops repository. Treat it as **sensitive**: certificates and keys can easily become security liabilities if handled incorrectly.

## What’s inside

Repository root layout (high-level): :contentReference[oaicite:2]{index=2}

- `ansible/` — Ansible inventories, roles and playbooks used to bootstrap/maintain hosts.
- `argo/` — Argo CD apps / app-of-apps definitions (GitOps manifests).
- `certificates/` — Certificate-related assets (CA, leaf certs, issuance configs, etc.).
- `ssh-keys/` — SSH key material or SSH-related configs (should be handled carefully).
- `justfile` — Common automation tasks (command runner).
- `README.MD` — This documentation.

## Prerequisites

### Local tooling

- [git](https://git-scm.com/)
- [just](https://github.com/casey/just) (recommended; used via `justfile`)
- Ansible:
  - `ansible` + `ansible-playbook`
- Kubernetes tooling (for day-2 ops):
  - `kubectl`
  - `helm` (if your Argo apps deploy Helm charts)
- Argo CD CLI (optional but helpful):
  - `argocd`

### Access requirements

- Network access to the target machines (SSH)
- Credentials for Kubernetes cluster admin (for initial Argo CD bootstrap)
- Secure handling for secrets (recommended):
  - SOPS + age/GPG, External Secrets, or Sealed Secrets