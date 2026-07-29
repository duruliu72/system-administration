### Have to  remove the Old Key if 
  1. The server was reinstalled
  2. SSH was reconfigured
  3. A new SSH key was generated
  ```bash
     ssh-keygen -R 147.79.66.183
  ```

## SSH and SCP

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
