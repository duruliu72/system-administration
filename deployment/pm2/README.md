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