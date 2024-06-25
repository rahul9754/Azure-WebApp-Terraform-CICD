# Azure WebApp Terraform CI/CD

This project sets up a simple web application on Azure using Terraform and a CI/CD pipeline defined in Azure Pipelines. The infrastructure includes an Azure Virtual Machine (VM), an Application Load Balancer (ALB), and security groups to control traffic.

## Project Structure

- `azure-pipeline.yaml`: Defines the CI/CD pipeline for deploying the Terraform code.
- `terraform/`: Contains the Terraform configuration files.
  - `main.tf`: Main Terraform configuration file.
  - `variables.tf`: Variables used in the Terraform configuration.
  - `outputs.tf`: Outputs from the Terraform configuration.
  - `network.tf`: Configures networking resources.
  - `load-balancer.tf`: Configures the load balancer.
  - `virtual-machine.tf`: Configures the virtual machine.

## Modules


The project is organized into the following modules to promote reusability and modularity:

- Network Module ```(network.tf)```: Defines the virtual network and subnet resources.
- Load Balancer Module ```(load-balancer.tf)```: Configures the Application Load Balancer, including backend pools, health probes, and load balancing rules.
- Virtual Machine Module ```(virtual-machine.tf)```: Defines the VM instance, including the operating system, size, and associated security group.

## Prerequisites
- Azure account with sufficient permissions to create resources.
- Azure DevOps account for setting up the CI/CD pipeline.
- Terraform installed locally for manual testing and development.

## Terraform

1. Initialize Terraform:
   ```sh
   terraform init

2. Validate the code:
    ```sh
    terraform validate

3.  Plan the deployment:
    ```sh
    terraform plan

4.  Apply the deployment (manual step):
    ```sh
    terraform apply

## CI/CD Pipeline

- Navigate to your Azure DevOps project.
- Create a new pipeline and select the `azure-pipeline.yaml` file from the repository.
- Set up the pipeline variables and service connections as required.
- Run the pipeline to deploy the infrastructure.

## Resources

- **Azure Virtual Machine (VM)**: The VM instance serving as the web server.
- **Application Load Balancer (ALB)**: Distributes traffic to the VM instance.
- **Security Groups**: Controls traffic to the instance.

## ALB Configuration

- Listens on port 80.
- Forwards traffic to the VM instance.

## Security Groups

- **ALB Security Group**: Allows incoming HTTP traffic on port 80.
- **VM Security Group**: Allows incoming SSH traffic on port 22 and incoming HTTP traffic on port 80.

## Variables

The `variables.tf` file defines the variables used in the Terraform configuration. Update these variables as per your requirements.

## Outputs

The `outputs.tf` file defines the outputs from the Terraform configuration, such as the public IP address of the VM.
