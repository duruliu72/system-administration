### Have to  remove the Old Key if 
  1. The server was reinstalled
  2. SSH was reconfigured
  3. A new SSH key was generated
  ```bash
     ssh-keygen -R 147.79.66.183
  ```

## SSH and SCP
Two Machine ubuntu1 and ubuntu2
Then fllowing have to do in ubuntu1
```bash
ssh-keygen
ssh-copy-id vagrant@192.168.56.11
```
If Messahge show like ubuntu1@192.168.56.11: Permission denied (publickey).
Then fllowing have to do in ubuntu2
```bash
sudo nano /etc/ssh/sshd_config.d/50-cloud-init.conf
sudo sshd -t
sudo systemctl restart ssh
ssh-copy-id vagrant@192.168.56.11
```
Change 
PasswordAuthentication yes
from 
PasswordAuthentication no
```bash
eval $(ssh-agent)
ssh-add
```
### SSH for client side configuration
```bash
ssh-keygen -t rsa
ssh-copy-id bob@147.79.66.183
ssh bob@147.79.66.183
cat /home/bob/.ssh/authorized_keys
```
Here 147.79.66.183 Server Machine host address and bob is server Machine User. If i run ssh-copy-id bob@147.79.66.183 then Server Machine User password Will have to given at prompt.After this  ssh bob@147.79.66.183 will no required password for login.cat /home/bob/.ssh/authorized_keys is shown in server Machine.

### SCP for client side vs server configuration
```bash
scp /home/talha/file1.txt bob@147.79.66.183:/home/bob/osudpotro
scp bob@147.79.66.183:/home/bob/osudpotro/file1.txt /home/talha
```
copy file1.txt file into osudpotro .here bob is the server machine user 
