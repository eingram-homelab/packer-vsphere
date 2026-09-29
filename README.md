# pkr-vsphere

Packer templates for building VM templates on a VMware vSphere homelab. Each directory corresponds to a single OS image. Templates are built as vSphere VMs using the `vsphere-iso` source and converted to vCenter templates upon completion.

Secrets (vCenter credentials, SSH passwords) are retrieved from HashiCorp Vault at build time via Packer's `vault()` function.

## Templates

| Build directory | Image |
|---|---|
| `rhel85/` | RHEL 8.5 |
| `rocky9/` | Rocky Linux 9 |
| `rocky10/vcsa-1/` | Rocky Linux 10 on vCenter 1 |
| `rocky10/vcsa-2/` | Rocky Linux 10 on vCenter 2 |
| `ubuntu24/` | Ubuntu 24.04 |
| `win11/` | Windows 11 |
| `win2019/` | Windows Server 2019 |
| `win2022/` | Windows Server 2022 |
| `win2022-core/` | Windows Server 2022 Core |
| `win2025-core/vcsa-2/` | Windows Server 2025 Core on vCenter 2 |

Each build directory contains its Packer template and variable declarations. Some builds also have an auto-loaded `.auto.pkrvars.hcl` file, `data/` assets, or guest customization scripts. Rocky Linux 10 and Windows Server 2025 Core configurations are nested under their vCenter-specific directories; use those paths when initializing or running Packer.

The repository-level `scripts/publish_template.ps1` is used by the release workflow to remove the previous vCenter template and rename the newly built timestamped VM.

## Prerequisites

- [Packer](https://developer.hashicorp.com/downloads) ≥ 1.15
- HashiCorp Vault accessible at `http://vault.local.lan:8200` with a valid token
- vCenter/ESXi accessible at `vcsa-1.local.lan`
- ISO files pre-staged in the vCenter datastore

## Usage

### Initialize plugins

Always run `packer init` before first use or after changing plugin versions:

```bash
packer init <build-directory>/
```

### Validate (syntax only — no Vault required)

```bash
packer validate -syntax-only <build-directory>/
```

### Validate (full — requires Vault)

```bash
export VAULT_ADDR=http://vault.local.lan:8200
export VAULT_TOKEN=<token>
packer validate <build-directory>/
```

### Build

```bash
export VAULT_ADDR=http://vault.local.lan:8200
export VAULT_TOKEN=<token>
packer build <build-directory>/
```

After a successful build, `<os>/build-manifest.json` is written with the artifact ID and timestamped VM name (format: `<template_name>__YYYYMMDDHHmmss`).

### Format check

```bash
packer fmt -check <os>/
```

Run `packer fmt <os>/` (without `-check`) to auto-fix formatting.

## CI/CD

| Workflow | Trigger | Action |
|---|---|---|
| `f-branch-validate.yaml` | Push to any branch except `main` | Run the reusable feature-branch Packer checks |
| `pr-workflow.yaml` | Pull request targeting `main` | Run the reusable Packer PR checks |
| `release-workflow.yaml` | Push to `main` or manual dispatch | Run the reusable Packer release workflow |

The workflows delegate to reusable workflows in [eingram-homelab/reusable-workflows](https://github.com/eingram-homelab/reusable-workflows). The release workflow builds and publishes templates; `scripts/publish_template.ps1` handles template promotion in vCenter.

Workflows are self-hosted on `arc-runners` and call reusable workflows from [eingram-homelab/reusable-workflows](https://github.com/eingram-homelab/reusable-workflows).

The PR and release workflows pass the `VAULT_TOKEN` repository secret to their reusable workflows. Configure `VAULT_ADDR` as an Actions variable when required by the reusable workflow.

## Triggering a New Build

To force a rebuild of a template without any functional changes, edit the trigger comment on line 1 of the relevant `.pkr.hcl` file:

```hcl
# Change this line to trigger new build
```
