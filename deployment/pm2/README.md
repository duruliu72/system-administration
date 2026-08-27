#### PATH configuration for pnpm
```
pnpm setup
```

Then reload your shell:
```
source ~/.bashrc
```
Check the output 
```
echo $PATH
```
For Windows after install node
```
sudo corepack enable
sudo corepack prepare pnpm@latest --activate
pnpm -v
```
then install PM2
```
pnpm add -g pm2
pm2 update
```
Run service 
```
pm2 start "pnpm start" --name osudpotro.backend
pm2 start "pnpm start" --name admin-panel --cwd /var/www/admin-panel 
pm2 start "pnpm start" --name osudpotro.backend --cwd /var/www/backend 
pm2 start app1.sh --name osudpotro.backend --cwd /root/osudpotro/bash-script
pm2 start admin-panel.sh --name osudpotro.admin-panel --cwd /home/ubuntu/osudpotro/bash-script
pm2 start backend.sh --name osudpotro.backend --cwd /home/ubuntu/osudpotro/bash-script
```
Script May be
Script will be in "home/ubuntu/osudpotro/bash-script or your path"
```
#!/bin/bash
export NODE_ENV='production'
cd /home/ubuntu/osudpotro/osudpotro-platform/apps/backend || exit 1
pnpm build
pnpm start
```