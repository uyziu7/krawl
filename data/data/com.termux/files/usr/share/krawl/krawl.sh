#!/bin/bash

if [ "$1" == "update" ]; then
    bash /data/data/com.termux/files/usr/share/krawl/krawlupdate.sh
    exit 0
fi

G='\033[1;32m'
R='\033[1;31m'
NC='\033[0m'

read -p "What is the IP (web address e.g. example.com): " target

if [ -z "$target" ]; then
    echo -e "${R}Error: Target cannot be empty.${NC}"
    exit 1
fi

read -p "Are you sure to continue? (y/N) " confirm
confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

if [[ "$confirm" != "y" && "$confirm" != "yes" ]]; then
    echo "Aborted."
    exit 1
fi

echo -e "${G}Loading... (Note: use only for educational purposes)${NC}"
sleep 1

list=("admin" "administrator" "login" "wp-login.php" "wp-admin" "config" "configuration" "backup" "bak" "old" "dev" "test" "api" "v1" "v2" "db" "database" "sql" "phpmyadmin" "uploads" "images" "assets" "server-status")
found=""

for dir in "${list[@]}"; do
    echo -ne "Searching folders... (checking: ${target}/${dir})\r"
    
    status=$(curl -s -o /dev/null -L -w "%{http_code}" "http://${target}/${dir}" --connect-timeout 5)
    
    if [ "$status" == "200" ] || [ "$status" == "301" ]; then
        echo -e "\n${G}[FOUND] http://${target}/${dir} (Status: $status)${NC}"
        found="${found}http://${target}/${dir} (Status: $status)\n"
    fi
    sleep 0.2
done

echo -e "\n--------------------------------"
if [ -z "$found" ]; then
    echo "Scan complete: No directories found."
else
    echo -e "Results:\n${G}${found}${NC}"
fi

