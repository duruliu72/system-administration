
###Special Shell Variables
1.Allow us to access information about the current shell environment and the command-line arguments passed to a script or command.
2.Special shell variables depend 
on how the user interacts with the command lines. 
###We have to learn some special shell variables bellow
$0  Name of the script being run
$?  Returns exit code value
$#  Number of arguments being passed
$*  String of all arguments being passed
$@  List/ separated values of all arguments being passed
$$  Current process ID
$!  ID of the background job
$-  Contains flags in use by your script
####Special Shell Variables $?
1.How to use Special Shell Variable  $?
2.How to implement Special Shell Variable $? in our own scripts
$? Reserve exit codes:
Exit Code Number            Meaning
0                           Success
1                           General Error
2                           Misuse of shell built-ins
126                         Command found but not executable
127                         Command not found
128                         Invalid argument to exit 
128+n                       Command terminated by signal n
130                         Terminated by Ctrl+C (SIGINT = 2)
137                         Killed (SIGKILL = 9)
139                         Segmentation fault (SIGSEGV = 11)
143                         Terminated (SIGTERM = 15)
255                         Exit status out of range / general failure

bob@srv660797:~$ filename="example.script.sh"
bob@srv660797:~$ echo  ${filename#*.}
here the syntax is:${variable#pattern}
It means:Remove the shortest matching prefix from the beginning of the variable that matches pattern.

Common file test operators

Operator        Meaning
-e file         File exists
-f file         Regular file exists
-d file         Directory exists
-r file         File is readable
-w file         File is writable
-x file         File is executable
-s file         File exists and is not empty