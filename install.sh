#!/bin/bash
# Agent Zero Mobile - Automated Setup Script
# Authored by: Daddy Draco

echo "[+] Updating Kali NetHunter environment..."
apt update && apt upgrade -y

echo "[+] Installing core dependencies..."
apt install python3 python3-pip git nodejs npm wget curl -y

echo "[+] Installing local AI engine (Ollama) for Stealth Mode..."
curl -fsSL https://ollama.com/install.sh | sh

echo "[+] Cloning Agent Zero framework..."
git clone https://github.com/frdel/agent-zero.git

echo "[+] Installing Python requirements..."
cd agent-zero
pip install -r requirements.txt

echo "[=======================================================]"
echo "[+] Setup Complete! You are ready to configure your keys."
echo "[=======================================================]"
