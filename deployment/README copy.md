
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


