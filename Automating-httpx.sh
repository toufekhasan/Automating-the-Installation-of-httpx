#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update Kali Linux
echo "🔄 Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

# Install Golang and Git
echo "📦 Installing Golang and Git..."
sudo apt install -y golang-go git

# Set Go environment variables
echo "⚙️ Setting Go environment variables..."
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Add to .bashrc if not already added
grep -qxF 'export GOPATH=$HOME/go' ~/.bashrc || echo 'export GOPATH=$HOME/go' >> ~/.bashrc
grep -qxF 'export PATH=$GOPATH/bin:$PATH' ~/.bashrc || echo 'export PATH=$GOPATH/bin:$PATH' >> ~/.bashrc

# Apply changes to current session
source ~/.bashrc

# Install httpx
echo "🚀 Installing httpx..."
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# Install waybackurls
echo "🚀 Installing waybackurls..."
go install -v github.com/tomnomnom/waybackurls@latest

# Move binaries to /usr/local/bin
echo "📂 Moving binaries to /usr/local/bin..."
sudo cp "$GOPATH/bin/httpx" /usr/local/bin/
sudo cp "$GOPATH/bin/waybackurls" /usr/local/bin/

# Verify installation
echo ""
echo "✅ Verifying installations..."
httpx_version=$(httpx -version 2>/dev/null || echo "httpx not found")
waybackurls_version=$(waybackurls -h 2>&1 | grep -i usage || echo "waybackurls not found")

echo ""
echo "✅ Installation Summary:"
echo "---------------------------"
echo "📌 httpx: $httpx_version"
echo "📌 waybackurls: Installed and accessible via command line"
echo "---------------------------"
echo "🎉 Both tools installed successfully!"
