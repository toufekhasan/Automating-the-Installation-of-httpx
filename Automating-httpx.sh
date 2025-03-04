#!/bin/bash

# Update Kali Linux
sudo apt update -y

# Install Golang
echo "Installing Golang..."
sudo apt install golang-go -y

# Set Go environment variables (optional, adjust paths as needed)
echo "Setting Go environment variables..."
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$GOPATH/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Install httpx
echo "Cloning httpx repository..."
git clone https://github.com/projectdiscovery/httpx.git ~/httpx
cd ~/httpx

echo "Building httpx..."
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# Move httpx binary to /usr/local/bin for system-wide access
echo "Moving httpx binary to /usr/local/bin..."
sudo cp $HOME/go/bin/httpx /usr/local/bin/

# Verify installation
echo "Verifying installation..."
httpx -version

echo "Installation complete!"
