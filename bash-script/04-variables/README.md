
### Special Shell Variables
1.Allow us to access information about the current shell environment and the command-line arguments passed to a script or command.
2.Special shell variables depend 
on how the user interacts with the command lines. 
### We have to learn some special shell variables bellow
1. $0  Name of the script being run
2. $?  Returns exit code value
3. $#  Number of arguments being passed
4. $*  String of all arguments being passed
5. $@  List/ separated values of all arguments being passed
6. $$  Current process ID
7. $!  ID of the background job
8. $-  Contains flags in use by your script
#### Special Shell Variables $?

- How to use Special Shell Variable  $?
- How to implement Special Shell Variable $? in our own scripts

#### $? Reserve exit codes:         
| Exit Code Number   | Meaning                                   |
| ------------- | ---------------------------------------------- |
| 0             |Success                                         |
| 1             | General Error                                  |
| 2             | Misuse of shell built-ins                      |
| 126           | Command found but not executable               |
| 127           | Command not found                              |
| 128           | Invalid argument to exit                       |
| 128+n         | Command terminated by signal n                 |
| 130           | Terminated by Ctrl+C (SIGINT = 2)              |
| 137           | Killed (SIGKILL = 9)                           |
| 139           | Segmentation fault (SIGSEGV = 11)              |
| 143           | Terminated (SIGTERM = 15)                      |
| 255           | Exit status out of range / general failure     |

1. filename="example.script.sh"
2. echo  ${filename#*.}
   
here the syntax is:${variable#pattern}
It means:Remove the shortest matching prefix from the beginning of the variable that matches pattern.

#### Common file test operators

| Operator        | Meaning                        |
| --------------- | ------------------------------ |
| -e file         | File exists                    |
| -f file         | Regular file exists            |
| -d file         | Directory exists               |
| -r file         | File is readable               | 
| -w file         | File is writable               |
| -x file         | File is executable             |
| -s file         | File exists and is not empty   |

#### common numeric comparison operators are:
1. -eq → equal
2. -ne → not equal
3. -gt → greater than
4. -ge → greater than or equal
5. -lt → less than
6. -le → less than or equal
#### IFS:IFS stands for Internal Field Separator in Bash. It is a special shell variable that determines how Bash splits a string into words or fields.
By default, IFS contains:space ( ),tab (\t),newline (\n)
```bash
printf '%q\n' "$IFS"
text="apple banana orange"
for item in $text; do
    echo "$item"
done
```
Here Bash used the default IFS (space) to split the string.

