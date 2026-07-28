### Stdout and Stderr
  ```bash
   ls -z 1> stdout.txt 2>stderr.txt
   ls -z &> all-logs.txt
  ```
->Here 1 , 2 are File Descriptor.Here 1 for standerad output ,2 for standard error.File descriptor may be 0,1,2,3,4 ...N.Here is 0 for input stream(Stdin),3 for os files and 4 for socket etc.
->& combine all descriptor

/dev/null
&> file.txt , >& file.txt

  ```bash
   ls -z 1> 2>&1 file.txt
   ls -z > file.txt 2>&1
   ls -z > /dev/null 2>&1
  ```