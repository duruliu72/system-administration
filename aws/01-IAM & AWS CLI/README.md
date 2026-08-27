
sudo yum  install -y bind-utils 
#### IAM 
1. IAM=Identity and Access Management
2. Root account created by detault,shouldn't be used or shared.
3. Users are can be grouped
4. Groups only contain users,not other groups
5. Users don't have to belong to a group,and user can belong to multiple  groups.
6. Don't use the root account except for aws account setup
7. One physical user = One AWS user
8. Assing users to groups and assing permissions to groups
9. Create a strong password policy
10. Use and enforce the use of Multi Factor Authentication (MFA)
11. Create and use Roles for giving permissions to AWS services(not parctical use yet)
12. Use Access Keys for Programmatic Access (CLI / SDK)
13. Audit permissions of your account using IAM Credentials Report @ IAM Access Advisior
14. Never share IAM users & Access Keys