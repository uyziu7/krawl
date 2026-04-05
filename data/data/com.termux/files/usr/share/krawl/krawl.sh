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

list=("admin" "administrator" "login" "wp-login.php" "wp-admin" "config" "configuration" "backup" "bak" "old" "dev" "test" "api" "v1" "v2" "db" "database" "sql" "phpmyadmin" "uploads" "images" "assets" "server-status" ​"root" "user" "users" "member" "members" "guest" "guests" "tmp" "temp" "cache" "logs" "logging" "error" "errors" "debug" "monitor" "monitoring" "git" "svn" "hg" "env" "environment" "secret" "secrets" "private" "hidden" "secure" "security" "auth" "authorize" "token" "key" "keys" "cert" "certs" "certificate" "certificates" "ssh" "id_rsa" "bash_history" "mysql" "pgsql" "mongodb" "redis" "memcached" "app" "apps" "src" "source" "core" "lib" "libs" "library" "bin" "sbin" "sh" "script" "scripts" "tools" "utility" "utilities" "setup" "installer" "install" "update" "upgrade" "patch" "version" "v3" "beta" "staging" "production" "prod" "dev" "development" "local" "localhost" "remote" "ftp" "sftp" "mail" "email" "smtp" "pop3" "imap" "webmail" "client" "clients" "customer" "customers" "order" "orders" "payment" "payments" "billing" "invoice" "invoices" "cart" "checkout" "shop" "store" "product" "products" "item" "items" "download" "downloads" "file" "files" "doc" "docs" "document" "documents" "manual" "readme" "changelog" "license" "copyright" ​"console" "shell" "terminal" "exec" "command" "run" "system" "sysadmin" "root" "superadmin" "master" "manager" "maintenance" "phpinfo.php" "info.php" "test.php" "status.php" "health" "healthcheck" "metrics" "v3" "v4" "api-docs" "swagger" "redoc" "graphql" "rest" "endpoint" "webhooks" "hooks" "job" "jobs" "worker" "workers" "queue" "queues" "scheduler" "crontab" "cron" "tasks" "storage" "buckets" "s3" "minio" "cloud" "cdn" "dist" "out" "build" "target" "vendor" "node_modules" "composer" "package.json" "package-lock.json" "yarn.lock" "docker" "kubernetes" "k8s" "helm" "deploy" "deployment" "ci" "cd" "gitlab-ci.yml" "travis.yml" "jenkins" "circleci" "ansible" "terraform" "vagrant" "chef" "puppet" "salt" "conf" "cfg" "settings"
 "params" "properties" "xml" "yaml" "yml" "json" "ini" "env.example" "env.production" "env.local" "htaccess" "htpasswd" "well-known" "security.txt" "robots.txt" "sitemap.xml" "favicon.ico" "apple-touch-icon.png" "android-chrome-192x192.png")
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

