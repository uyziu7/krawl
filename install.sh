#!/bin/bash
# krawl universal safe-installer v2026.1

echo "[*] Preparation..."
pkg update -y || true
pkg install git -y

# 1. SMART CHECK
if [ -f "DEBIAN/control" ]; then
    echo "[*] Working directory detected. Building from current files..."
elif [ -d "krawl" ]; then
    echo "[*] Existing 'krawl' folder found. Moving into it..."
    cd krawl
else
    echo "[*] No source found. Cloning from GitHub..."
    git clone https://github.com/uyziu7/krawl.git
    cd krawl
fi

# 2. TARGETED CLEANUP
rm -f krawl.deb

# 3. BUILDING
echo "[*] Building the krawl package..."
dpkg-deb --build . krawl.deb

# 4. INSTALLATION
echo "[*] Installing krawl..."
pkg install ./krawl.deb -y

echo "[+] Installation complete! Type 'krawl' or 'krawl update' to start."

