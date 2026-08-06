
#### Ec2 service
+ Ec2 is one of the most popular of AWS' offering
+ Ec2= Elastic compute cloud = Infrastructure as a Service
+ It mainly consists in the capability of :
  * Renting virual machines (Ec2)
  * Storing data on virtual drives (EBS)
  * Distributing load across machines (ELB)
  * Scaling the services using an auto-scaling group(ASG)
+ Knowing Ec2 is fundamental to understand how the Cloud works

##### Ec2 sizing & configuration options
+ Operating System (OS): Linux,Windows or Mac OS
+ How much compute power & cores (CPU)
+ How much random-access memory (RAM)
+ How much storage space:
 * Network-attached (EBS & EFS)
 * hardware (EC2 Instance Store)
+ Network card: Speed of the card,Public IP address
+ Firewall rules: security group
+ Bootstrap script (Configure at first lunch):Ec2 User Data

#### Ec2 User Data
+ It is possible to bootstrap our instances using an EC2 User data script.
+ bootstrapping means lunching commands when a machine starts
+ That script is only run once at the instance first start
+ EC2 user data is used to automate boot tasks such as :
 * Installing updates
 * Installing software
 * Downloading common files from the internet
 * Anything you can think of
+The EC2 User Data Script runs with the root user

#### EC2 Instance types expampes
 ![EC2 Instance types expampes](/ec2-instance-type.png)





