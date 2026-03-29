#!/bin/bash
# Agent Zero Mobile - One-Click Dual-Brain Launcher
# Authored by: Daddy Draco

echo "[+] Starting Ollama local server in the background..."
ollama serve > /dev/null 2>&1 &

# Give the server a second to wake up
sleep 3 

echo "[+] Booting Agent Zero..."
cd agent-zero || { echo "[-] Error: agent-zero folder not found. Did you run install.sh?"; exit 1; }
python3 main.py
