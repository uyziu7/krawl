#!/bin/bash
# krawl auto-installer
echo "[*] Updating and installing dependencies..."
pkg update && pkg install git -y
echo "[*] Building the krawl package..."
dpkg-deb --build .
echo "[*] Installing krawl..."
pkg install ./krawl.deb
echo "[+] Installation complete! Type 'krawl' to start."

