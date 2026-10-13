# Week 7 - Infrastructure as Code with OpenTofu

This project deploys a Linux web server on CSC cPouta using OpenTofu.

The infrastructure is defined entirely in code, allowing it to be created, modified, destroyed, and recreated automatically.

## Infrastructure

The deployment creates the following resources:

- An OpenStack SSH key pair using an existing public key.
- A security group allowing HTTP from anywhere and SSH from a specified IP.
- A network port connected to an existing CSC project network.
- An Ubuntu virtual machine.
- A floating public IP address attached to the network port.

The VM is automatically configured using cloud-init, which installs Apache and creates a custom webpage.

## Requirements

- OpenTofu 1.6.0 or newer
- CSC account with cPouta access
- CSC project with an existing network
- OpenStack Application Credential
- SSH public/private key pair
- Git

## Configuration

1. Clone the repository.
2. Create an OpenStack Application Credential in the cPouta dashboard.
3. Download `clouds.yaml` and place it in the project directory.
4. Generate an SSH key pair if necessary.
5. Copy `terraform.tfvars.example` to `terraform.tfvars`.
6. Update the configuration with your project network, public IP address, name, and other values.

The cloud name in `versions.tf` must match the name configured in `clouds.yaml`.

Sensitive files, including credentials and OpenTofu state files, are excluded from Git.

## Deployment

Initialize OpenTofu:

```powershell
tofu init
```

Format and validate the configuration:

```powershell
tofu fmt
tofu validate
```

Preview the infrastructure changes:

```powershell
tofu plan
```

Deploy the infrastructure:

```powershell
tofu apply
```

Confirm the deployment by typing `yes`.

Once the deployment finishes, OpenTofu displays the public IP address and website URL.

Cloud-init may take a few minutes to finish installing and configuring Apache.

## Updating the infrastructure

Modify the OpenTofu configuration or input variables.

Preview the changes:

```powershell
tofu plan
```

Apply the changes:

```powershell
tofu apply
```

OpenTofu determines which resources need to be added, modified, or replaced.

## Destroying the infrastructure

Remove all resources managed by this project:

```powershell
tofu destroy
```

Confirm by typing `yes`.

The existing CSC project network is not destroyed because it is referenced as an external data source rather than created by this configuration.

## Project files

| File | Purpose |
|---|---|
| `main.tf` | Infrastructure resources |
| `versions.tf` | OpenTofu and OpenStack provider configuration |
| `variables.tf` | Input variable definitions and validation |
| `outputs.tf` | Public IP address and website URL outputs |
| `cloud-init.yaml` | Automatic Apache installation and webpage configuration |
| `terraform.tfvars.example` | Example deployment configuration |
| `.gitignore` | Excludes credentials and generated state files |

## Security

SSH access is restricted to the IPv4 address specified in `ssh_allowed_cidr`.

HTTP access is available publicly on TCP port 80.

The OpenStack Application Credential, private SSH key, and infrastructure state files must not be committed to the repository.