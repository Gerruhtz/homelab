# Script designed to install Ansible and Terraform

# INSTALL ANSIBLE
    # Install pipx and Ansible and add Ansible to PATH
    sudo apt install pipx -y
    pipx install --include-deps ansible
    pipx ensurepath

# INSTALL TERRAFORM
    # Install Terraform dependencies
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

    # Add HashiCorp GPG key and repository
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

    # Update package list, install Terraform and enable tab completion
    sudo apt update 
    sudo apt install -y terraform packer
    touch ~/.bashrsc
    terraform -install-autocomplete