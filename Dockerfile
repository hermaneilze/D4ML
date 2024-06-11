FROM jenkins/inbound-agent:latest

# Set the working directory for the Jenkins agent
WORKDIR /home/jenkins

# Install necessary packages
USER root
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
 && rm -rf /var/lib/apt/lists/*

# Download and install Terraform
RUN wget https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip && \
    unzip terraform_0.15.4_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_0.15.4_linux_amd64.zip

# Switch back to the Jenkins user
USER jenkins
