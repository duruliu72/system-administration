
# What is a Daemon?
Daemons are common in Unix-like operating systems (such as Linux) but also exist in other OS environments.
They typically start at boot time and remain running to manage tasks like network requests, hardware management, or scheduling jobs.
### Examples include:
1. cron: For scheduling tasks.
2. httpd or nginx: Web server daemons.
3. sshd: Handles SSH connections.
# How Daemon Services Work
1.  Startup: Daemons are usually launched during the system's initialization process (e.g., when the system boots).
2.  Process Characteristics:
Detached from any terminal or user session.
Operates independently in the background.
3. Control:
Controlled by init systems like systemd, SysVinit, or upstart.
Managed using commands like systemctl (for systemd) or service (older systems).
4. Logging: Most daemons log their activity to system log files, which can be reviewed using commands like journalctl or by inspecting files in /var/log.
# Creating a Custom Daemon(With Script)
1. Write a Script: Create a script that runs a task (e.g., /usr/local/bin/mydaemon.sh or /path/to/your/app/example.sh).
```
 #!/bin/bash
export NODE_ENV='production'
node /opt/erp/monolithic/contributors/server.js
```
2. Create a Service File: Place a .service file in /etc/systemd/system/. Example:
```bash
[Unit]
Description=My Custom Daemon Service
After=network.target

[Service]
ExecStart=/usr/local/bin/ecomdaemon.sh
Restart=always

[Install]
WantedBy=multi-user.target
```
3. Reload and Start:
```
sudo systemctl daemon-reload
sudo systemctl start ecomsh.service
sudo systemctl enable ecomsh.service
```
### Security and Best Practices
* Permission Management: Run daemons with the least privileges required.
* Monitoring: Use tools like ps, top, or specialized monitoring tools (e.g., Nagios, Prometheus) to monitor daemon processes.
* Logging: Ensure logs are properly managed and rotated to avoid storage issues
# Creating a Custom Daemon(Without Script)
```
[Unit]
Description=Node.js App
Documentation=https://yourappdocs.com
After=network.target

[Service]
ExecStart=/usr/bin/node /opt/erp/monolithic/contributors/backend/server.js
WorkingDirectory=/opt/erp/monolithic/contributors/backend
Restart=always
EnvironmentFile=/opt/erp/monolithic/contributors/backend/.env
RestartSec=10
Environment=NODE_ENV=production PORT=3000

[Install]
WantedBy=multi-user.target
```
 ### Fix the Path
 If Node.js is already installed but you see the error, the issue might be a missing or incorrect symlink to the node executable.
 1. Locate the actual node executable:
  ```
which node
```  
 2. If this returns a path (e.g., /usr/local/bin/node), update the symlink:
  ```
sudo ln -s $(which node) /usr/bin/node
```  
 3. If the which node command doesn't return anything, try locating it manually
```
sudo find / -name node -type f
```
Update the symlink with the correct path if necessary.
#### Or
```
[Unit]
Description=Api Ecom Service
After=network.target
[Service]
ExecStart=node server.js
Restart=always
EnvironmentFile=/opt/erp/monolithic/contributors/backend/.env
Environment=NODE_ENV=production
Environment=PATH=/usr/bin:/usr/local/bin
WorkingDirectory=/opt/erp/monolithic/contributors/backend
[Install]
WantedBy=multi.user.target
```

## Common Commands for Daemon Management in Linux (Systemd-based Systems)
1. ####  Check Status of a Daemon
```
systemctl status <service_name>
```
2. ####  Start a Daemon
```
systemctl start <service_name>
```
3. #### Stop a Daemon
```
sudo systemctl stop <service_name>
```
4. #### Enable a Daemon to Start at Boot
```
sudo systemctl enable <service_name>
```
5. #### Disable a Daemon
```
sudo systemctl disable <service_name>
```

# Configure Reverse Proxy (Optional)
If you want to make your app accessible on a domain or subdomain, configure a reverse proxy using Nginx or Apache.
#### Using Nginx:
1. Install Nginx:
```
sudo apt install nginx
```
2. Configure Nginx: Create a configuration file for your app (e.g., /etc/nginx/sites-available/ecom.conf):
```
   server {
    listen 80;
    server_name durulhoda.info;

    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```
3. Enable the configuration:
```
sudo ln -s /etc/nginx/sites-available/nextjs /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```
4.Test it by visiting http://durulhoda.info


#### ###########  ----------------------------------------------------------------------------------------------------------------------------------------------------

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

#### For Mongodb data dumping (Windows)

& "C:\Program Files\MongoDB\Tools\100\bin\mongodump.exe" ` --uri="mongodb://opl-dev-db-user:lIpV7R75SYgBt@52.76.196.213:27888/opl_dev_db?authSource=admin" `  --out "F:\mongo-backup"
