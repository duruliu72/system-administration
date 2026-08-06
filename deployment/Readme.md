## Java Apps on Ubuntu Server with Public Access

### Prerequisites

- Ubuntu server (fresh install)
- Root or sudo access
- Public IP address (202.51.190.114 in your case)
- Your JAR file: demo-0.0.1-SNAPSHOT.jar

### PART 1: Initial Server Setup

#### Required Packages

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y openjdk-17-jdk nginx curl wget net-tools ufw
java -version
```

### PART 2: Create Application Directories

#### Create Directory Structure

```bash
# Create main directory
sudo mkdir -p /opt/java-apps

# Create app directories
sudo mkdir -p /opt/java-apps/app1
sudo mkdir -p /opt/java-apps/app2
sudo mkdir -p /opt/java-apps/app3

# Set ownership
sudo chown -R $USER:$USER /opt/java-apps
```

#### Upload Your JAR Files

```bash
scp demo-0.0.1-SNAPSHOT.jar root@202.51.190.114:/opt/java-apps/app1/
scp demo-0.0.1-SNAPSHOT.jar root@202.51.190.114:/opt/java-apps/app2/
scp demo-0.0.1-SNAPSHOT.jar root@202.51.190.114:/opt/java-apps/app3/
```

#### Verify JAR Files

```bash
ls -la /opt/java-apps/app1/*.jar
ls -la /opt/java-apps/app2/*.jar
ls -la /opt/java-apps/app3/*.jar
```

### PART 3: Configure Application Properties

#### Create Properties for Each App

```bash
cat  /opt/java-apps/app1/application.properties  'EOF'
server.port=8090
server.address=0.0.0.0
spring.application.name=app1-mangobd
EOF
```

```bash
cat  /opt/java-apps/app2/application.properties  'EOF'
server.port=8091
server.address=0.0.0.0
spring.application.name=app2-bberrybd
EOF
```

```bash
cat  /opt/java-apps/app3/application.properties  'EOF'
server.port=8092
server.address=0.0.0.0
spring.application.name=app3-applebd
EOF
```

### PART 4: Create Systemd Services

#### Create Service for Apps

```bash
sudo tee /etc/systemd/system/java-app1.service  /dev/null  'EOF'
[Unit]
Description=Java Application 1 - mangobd.com
After=network.target network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/java-apps/app1
Environment="JAVA_OPTS=-Xms256m -Xmx512m -Djava.net.preferIPv4Stack=true"
ExecStart=/usr/bin/java $JAVA_OPTS -jar demo-0.0.1-SNAPSHOT.jar --server.port=8090 --server.address=0.0.0.0
SuccessExitStatus=143
Restart=always
RestartSec=10
StandardOutput=append:/opt/java-apps/app1/app.log
StandardError=append:/opt/java-apps/app1/error.log

[Install]
WantedBy=multi-user.target
EOF
```

```bash
sudo tee /etc/systemd/system/java-app2.service  /dev/null  'EOF'
[Unit]
Description=Java Application 2 - bberrybd.com
After=network.target network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/java-apps/app2
Environment="JAVA_OPTS=-Xms256m -Xmx512m -Djava.net.preferIPv4Stack=true"
ExecStart=/usr/bin/java $JAVA_OPTS -jar demo-0.0.1-SNAPSHOT.jar --server.port=8091 --server.address=0.0.0.0
SuccessExitStatus=143
Restart=always
RestartSec=10
StandardOutput=append:/opt/java-apps/app2/app.log
StandardError=append:/opt/java-apps/app2/error.log

[Install]
WantedBy=multi-user.target
EOF
```

```bash
sudo tee /etc/systemd/system/java-app3.service  /dev/null  'EOF'
[Unit]
Description=Java Application 3 - applebd.com
After=network.target network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/java-apps/app3
Environment="JAVA_OPTS=-Xms256m -Xmx512m -Djava.net.preferIPv4Stack=true"
ExecStart=/usr/bin/java $JAVA_OPTS -jar demo-0.0.1-SNAPSHOT.jar --server.port=8092 --server.address=0.0.0.0
SuccessExitStatus=143
Restart=always
RestartSec=10
StandardOutput=append:/opt/java-apps/app3/app.log
StandardError=append:/opt/java-apps/app3/error.log

[Install]
WantedBy=multi-user.target
EOF
```

### PART 5: Start and Enable Services

#### Start All Services

```bash
# Reload systemd
sudo systemctl daemon-reload

# Enable services for auto-start
sudo systemctl enable java-app1 java-app2 java-app3

# Start services
sudo systemctl start java-app1
sudo systemctl start java-app2
sudo systemctl start java-app3

# Check status
sudo systemctl status java-app1 --no-pager
sudo systemctl status java-app2 --no-pager
sudo systemctl status java-app3 --no-pager
```

#### Verify Apps Are Running

```bash
# Check ports
sudo netstat -tulpn | grep -E "8090|8091|8092"

# Test local access
curl http://127.0.0.1:8090
curl http://127.0.0.1:8091
curl http://127.0.0.1:8092
```

### PART 6: Configure Nginx as Reverse Proxy

#### Configure Nginx as Reverse Proxy

```bash
sudo tee /etc/nginx/sites-available/default  'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name _;

    # Status page
    location / {
        return 200 '=== Java Applications Running ===

✅ Your applications are ready:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  App 1 (mangobd):    http://202.51.190.114/app1
  App 2 (bberrybd):   http://202.51.190.114/app2
  App 3 (applebd):    http://202.51.190.114/app3
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Direct Access (via ports):
  App 1: http://202.51.190.114:8090
  App 2: http://202.51.190.114:8091
  App 3: http://202.51.190.114:8092

Server: Nginx + Java Spring Boot
';
        add_header Content-Type text/plain;
    }

    # App 1 Proxy
    location /app1 {
        proxy_pass http://127.0.0.1:8090;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /app1/ {
        proxy_pass http://127.0.0.1:8090/;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # App 2 Proxy
    location /app2 {
        proxy_pass http://127.0.0.1:8091;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /app2/ {
        proxy_pass http://127.0.0.1:8091/;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # App 3 Proxy
    location /app3 {
        proxy_pass http://127.0.0.1:8092;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /app3/ {
        proxy_pass http://127.0.0.1:8092/;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
EOF
```

#### Test and Reload Nginx

```bash
# Test configuration
sudo nginx -t

# Reload Nginx
sudo systemctl reload nginx

# Test Nginx proxy
curl http://localhost/app1
curl http://localhost/app2
curl http://localhost/app3
```

### PART 7: Configure Firewall

#### Setup UFW Firewall

```bash
# Allow SSH (important - do first!)
sudo ufw allow 22/tcp

# Allow HTTP and HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Allow Java app ports (if direct access needed)
sudo ufw allow 8090/tcp
sudo ufw allow 8091/tcp
sudo ufw allow 8092/tcp

# Enable firewall
sudo ufw --force enable

# Check status
sudo ufw status verbose
```

### PART 8: Configure Port Forwarding (If Behind NAT)

#### Check Your Network Configuration

```bash
# Get your internal IP
INTERNAL_IP=$(ip addr show | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1)
echo "Your internal IP: $INTERNAL_IP"

# Get your public IP
PUBLIC_IP=$(curl -s ifconfig.me)
echo "Your public IP: $PUBLIC_IP"
```

#### Enable IP Forwarding (If Same Machine)

```bash
# Enable IP forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# Make permanent
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf

# Add iptables rules (if public IP is on this server)
sudo iptables -t nat -A PREROUTING -p tcp --dport 8090 -d 202.51.190.114 -j DNAT --to-destination $INTERNAL_IP:8090
sudo iptables -t nat -A PREROUTING -p tcp --dport 8091 -d 202.51.190.114 -j DNAT --to-destination $INTERNAL_IP:8091
sudo iptables -t nat -A PREROUTING -p tcp --dport 8092 -d 202.51.190.114 -j DNAT --to-destination $INTERNAL_IP:8092
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -d 202.51.190.114 -j DNAT --to-destination $INTERNAL_IP:80

# Save iptables rules
sudo apt install iptables-persistent -y
sudo netfilter-persistent save
```

#### If Using Separate Router

Log into your router (usually <http://192.168.1.1> or <http://192.168.6.1>) and add port forwarding:

| External Port | Internal IP   | Internal Port | Protocol |
| ------------- | ------------- | ------------- | -------- |
| 8090          | 192.168.6.104 | 8090          | TCP      |
| 8091          | 192.168.6.104 | 8091          | TCP      |
| 8092          | 192.168.6.104 | 8092          | TCP      |
| 80            | 192.168.6.104 | 80            | TCP      |

#### Testing

```bash
# Test direct ports
curl http://127.0.0.1:8090
curl http://127.0.0.1:8091
curl http://127.0.0.1:8092

# Test Nginx proxy
curl http://localhost/app1
curl http://localhost/app2
curl http://localhost/app3
```

#### Public Access Test

```bash
# Test via public IP
curl http://202.51.190.114:8090
curl http://202.51.190.114:8091
curl http://202.51.190.114:8092

# Test via Nginx
curl http://202.51.190.114/app1
curl http://202.51.190.114/app2
curl http://202.51.190.114/app3
```

#### Access Your Applications - From anywhere in the world

| Method        | URL                          |
| ------------- | ---------------------------- |
| Direct (Port) | <http://202.51.190.114:8090> |
| Proxy (Path)  | <http://202.51.190.114/app1> |
| Direct (Port) | <http://202.51.190.114:8091> |
| Proxy (Path)  | <http://202.51.190.114/app2> |
| Direct (Port) | <http://202.51.190.114:8092> |
| Proxy (Path)  | <http://202.51.190.114/app3> |
