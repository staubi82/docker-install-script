#!/bin/bash

# Paketquellen aktualisieren und Systemupgrade durchführen
apt update && apt upgrade -y

# Benötigte Pakete installieren
apt install apt-transport-https ca-certificates gnupg-agent software-properties-common -y

# Docker-Repository zur Paketquelle hinzufügen
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update

# Docker und Docker Compose installieren
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose -y

# Docker-Volume für Portainer erstellen
docker volume create portainer_data

# Portainer-Container starten
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# Hinweis zur Erreichbarkeit von Portainer anzeigen
IP=$(hostname -I | awk '{print $1}')
echo -e "\n\n##############################################"
echo "Installation abgeschlossen. Du kannst jetzt auf die Portainer-Web-Oberfläche zugreifen:"
echo "https://$IP:9443"
echo "##############################################\n\n"
