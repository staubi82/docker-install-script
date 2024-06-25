### Docker und Docker Compose auf Debian installieren und konfigurieren

#### 1. Docker und Docker Compose Installations-Skript herunterladen und ausführen

Um Docker und Docker Compose auf Debian zu installieren und zu konfigurieren, führen Sie das folgende Skript aus. Es erledigt alle notwendigen Schritte automatisch:

```bash
bash -c "$(wget -qO- https://raw.githubusercontent.com/staubi82/docker-install-script/main/install_docker.sh)"
```

#### 2. Manuelle Schritte zur Installation und Konfiguration

Falls Sie die Schritte manuell durchführen möchten, finden Sie hier die detaillierte Anleitung:

##### a. Paketquellen aktualisieren und Systemupgrade durchführen

Aktualisieren Sie die Paketliste und führen Sie ein Systemupgrade durch:

```bash
apt update && apt upgrade -y
```

##### b. Benötigte Pakete installieren

Installieren Sie die benötigten Pakete:

```bash
apt install curl sudo apt-transport-https ca-certificates gnupg-agent software-properties-common -y
```

##### c. Docker-Repository hinzufügen

Fügen Sie das Docker-Repository zur Paketquelle hinzu:

```bash
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
```

##### d. Docker und Docker Compose installieren

Installieren Sie Docker und Docker Compose:

```bash
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose -y
```

##### e. Portainer einrichten

Erstellen Sie ein Docker-Volume für die Portainer-Daten:

```bash
docker volume create portainer_data
```

Starten Sie den Portainer-Container:

```bash
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```

#### 3. Zugriff auf die Portainer Web-Oberfläche

Öffnen Sie Ihren Webbrowser und gehen Sie zur Adresse:

```http
https://[Ihre-IP]:9443
```

Die IP-Adresse des Servers wird am Ende der Installation im Skript angezeigt.

#### 4. Portainer Template hinzufügen

Navigieren Sie in den Einstellungen von Portainer zu "Templates" und fügen Sie die folgende URL hinzu:

```
https://raw.githubusercontent.com/Lissy93/portainer-templates/main/templates.json
```

Wechseln Sie dann in die Umgebung "local" und passen Sie die "Public IP" an.
