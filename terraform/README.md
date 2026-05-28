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
