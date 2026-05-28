# Phase 3, Task 1: Infrastructure as Code (Terraform & Ansible) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create Terraform and Ansible skeletons in `devops_playground/terraform/` and `devops_playground/ansible/`.

**Architecture:** Skeleton IaC for Yandex Cloud provisioning and basic k3s installation via Ansible.

**Tech Stack:** Terraform (Yandex provider), Ansible.

---

### Task 1: Terraform Skeletons

**Files:**
- Create: `devops_playground/terraform/main.tf`
- Create: `devops_playground/terraform/variables.tf`
- Create: `devops_playground/terraform/outputs.tf`
- Create: `devops_playground/terraform/README.md`

- [ ] **Step 1: Create `terraform/variables.tf`**

```hcl
variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "zone" {
  description = "Yandex Cloud Zone"
  type        = string
  default     = "ru-central1-a"
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "vm_size" {
  description = "VM size preset"
  type        = string
  default     = "s2.micro"
}
```

- [ ] **Step 2: Create `terraform/main.tf`**

```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_vpc_network" "lab_net" {
  name = "devops-lab-network"
}

resource "yandex_vpc_subnet" "lab_subnet" {
  name           = "devops-lab-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.lab_net.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_security_group" "lab_sg" {
  name        = "devops-lab-sg"
  network_id  = yandex_vpc_network.lab_net.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "K3s API"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 6443
  }

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}
```

- [ ] **Step 3: Create `terraform/outputs.tf`**

```hcl
output "vm_external_ip" {
  description = "External IP of the created VM (skeleton)"
  value       = "Provision a yandex_compute_instance to see the real IP"
}
```

- [ ] **Step 4: Create `terraform/README.md`**

```markdown
# Terraform Infrastructure Skeleton

This directory contains Terraform skeletons for provisioning infrastructure on Yandex Cloud.

## Warning: Cost Management

**IMPORTANT:** Provisioning resources on Yandex Cloud (or any cloud provider) incurs costs. 
Always remember to destroy your infrastructure when you are done with your experiments.

## Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan the changes:
   ```bash
   terraform plan
   ```

3. Apply the changes:
   ```bash
   terraform apply
   ```

4. **Destroy the infrastructure:**
   ```bash
   terraform destroy
   ```
   **DO NOT FORGET THIS STEP TO AVOID UNNECESSARY CHARGES.**
```

---

### Task 2: Ansible Skeletons

**Files:**
- Create: `devops_playground/ansible/inventory.example.ini`
- Create: `devops_playground/ansible/playbook.yml`

- [ ] **Step 1: Create `ansible/inventory.example.ini`**

```ini
[lab_nodes]
node1 ansible_host=EXTERNAL_IP_HERE ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
```

- [ ] **Step 2: Create `ansible/playbook.yml`**

```yaml
- name: Install k3s on lab nodes
  hosts: lab_nodes
  become: true
  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes
      when: ansible_os_family == "Debian"

    - name: Install curl
      package:
        name: curl
        state: present

    - name: Install k3s
      shell: curl -sfL https://get.k3s.io | sh -
      args:
        creates: /usr/local/bin/k3s
```

- [ ] **Step 3: Verify Ansible Syntax**

Run: `ansible-playbook devops_playground/ansible/playbook.yml --syntax-check`

---

### Task 3: Commit Changes

- [ ] **Step 1: Commit and push**

```bash
git add devops_playground/terraform/ devops_playground/ansible/
git commit -m "feat: add infrastructure skeletons"
```
