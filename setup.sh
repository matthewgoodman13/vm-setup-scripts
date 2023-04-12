#!/bin/bash

# Matthew Goodman
# Setup Script for Ubuntu 22.04

# INSTALL PACKAGES
echo "Installing Packages..."

# Check if snap is installed
echo "Checking if snap is installed..."
if ! command -v snap &> /dev/null
then
   echo "snap could not be found - installing..."
   sudo apt install snapd -y

      # Check if snap is installed
      if ! command -v snap &> /dev/null
      then
          echo "Error: snap could not be found"
          exit
      fi
else
    echo "Snap is already installed"
fi

# Install Homebrew
echo "Installing Homebrew..."
if ! command -v brew &> /dev/null
then
   NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
   eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
   sudo apt-get install build-essential -y
else
   echo "Homebrew is already installed"
fi

# Install GCC
echo "Installing GCC..."
brew install gcc

# Install Starship Prompt and Inconsolata Font
if ! command -v starship &> /dev/null
then
   echo "Installing Inconsolata Font..."
   sudo apt install fonts-inconsolata -y
   echo "Installing Starship Prompt..."
   echo "Starship could not be found - installing..."
   brew install starship
   echo 'eval "$(starship init bash)"' >> ~/.bashrc
   source ~/.bashrc
else
   echo "Starship is already installed"
fi

# Install Python
if ! command -v python &> /dev/null
then
   echo "Installing Python..."
   sudo apt install python3 python3-pip -y
   echo "alias python=python3" >> ~/.bashrc
   source ~/.bashrc
else
   echo "Python is already installed"
fi

# Install Git
echo "Installing Git..."
sudo apt install git -y

# Install VSCode
echo "Installing VSCode..."
sudo snap install --classic code

# Install/Update Docker & Docker Compose
if [ -x "$(command -v docker)" ]; then
   echo "Updating Docker..."
   sudo apt-get update
   sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
   sudo docker version
   sudo docker compose version
else
   echo "Installing Docker..."
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
   sudo apt-get update
   sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
   sudo usermod -aG docker $USER
   sudo docker version
   sudo docker compose version
fi

# Install NVM & NodeJS
echo "Installing / Updating NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install lts/fermium
nvm install lts/hydrogen

echo "Installing NodeJS..."
sudo apt install nodejs -y

# Source .bashrc
source ~/.bashrc