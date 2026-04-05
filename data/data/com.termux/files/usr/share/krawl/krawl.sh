#!/bin/bash
# Check for update argument
if [ "$1" == "update" ]; then
    echo "[*] Checking for updates on GitHub..."
    # Downloading and running the installer
    curl -sL https://raw.githubusercontent.com/uyziu7/krawl/main/install.sh | bash
    exit 0
fi

# Couleurs
G='\033[1;32m'
NC='\033[0m'

# 1. Demande l'adresse
read -p "What is the IP (web adress e.g. example.com): " target

# 2. Confirmation (gestion de y/n/yes/no etc)
read -p "Are you sure to continue? (y/N) " confirm
confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

if [[ "$confirm" != "y" && "$confirm" != "yes" ]]; then
    echo "Aborted."
    exit 1
fi

# 3. Loading
echo "Loading... (Note: use only for educational purpose)"
sleep 2

# 4. Simulation de scan (Searching folders)
# Pour l'exemple, on teste 3 dossiers classiques
list=("admin" "config" "backup" "db" "login" "api")
found=""

for dir in "${list[@]}"; do
    echo -e "Searching folders... (searching: ${target}/${dir})"
    
    # On utilise curl pour vérifier si le dossier existe (code 200 ou 301)
    status=$(curl -s -o /dev/null -w "%{http_code}" "http://${target}/${dir}")
    
    if [ "$status" == "200" ] || [ "$status" == "301" ]; then
        found="${found}${target}/${dir} (Status: $status)\n"
    fi
    sleep 0.5 # Petit délai pour l'effet visuel
done

# 5. Résultat final
echo "--------------------------------"
if [ -z "$found" ]; then
    echo "Searched: No found."
else
    echo -e "Searched:\n${G}${found}${NC}"
fi

