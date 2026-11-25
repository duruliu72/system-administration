
#### Attached EBS Storage to EC2 Instance (instance1)
```bash
lsblk
```
```bash
sudo file -s /dev/xvdf
```
/dev/xvdf: data 
That means no file system there
```bash
sudo mkfs.
sudo mkfs.ex4 /dev/xvdf
sudo file -s /dev/xvdf
```

/dev/xvdf: Linux rev 1.0 ......... 
```bash
sudo mkdir /ebsdemo
lsblk
```
Now mounted that Disk
```bash
sudo mount /dev/xvdf /ebsdemo/
lsblk
df -h
cd /ebsdebo/
sudo blikid
sudo vi /etc/fstab
```
Write to file 
UUID=7f069dd0-42c8-4589-97ff-47953f36fbde /ebsdemo ext4 devaults

```bash
sudo vi examplefile.txt
```
#### Detached from instance1 and Attached that EBS Storage to EC2 Instance (instance2)

```bash
lsblk
sudo file -s /dev/xvdf
```
/dev/xvdf: Linux rev 1.0 .........  that means file system still there
```bash
sudo mkdir /instance2ebs
sudo mount /dev/xvdf /instance2ebs/
cd /instance2ebs/
ls
cat examplefile.txt
```
Text is still there


#### EFS for  EC2 Instance
Run bellow command for boath instance1 and instance2
```bash
sudo yum install -y amazon-efs-utils
```
In instance1 and instance2
```bash
sudo moun
sudo mount.efs efs.instance-id /folter/
df -h
sudo vi /etc/fstab
```
Write here
fs-id:/ /efsdemo dfs _netdev,noresvport,tls,iam 0 0
then create a text file and write something