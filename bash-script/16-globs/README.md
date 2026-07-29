### Globs Details
If there are test1-2.txt,tes1t.txt,test2.txt,test.sh,test1.txt,file1.txt then the output of
  ```bash
   ls test?.txt
  ```
  will be test2.txt,test1.txt;
  For * symbol
  If there are report.txt,report.docx,report.pdf,image1.jpg,report.,backup2.tar.gz,1.log2.log then output of

  ```bash
   ls report.*
  ```
  will be report.txt,report.docx,report.pdf,report.
  ```bash
   ls *.pdf
  ```
  will be report.pdf .
  ####Expansion Globs
  ```bash
   touch fail hail mail sail tail
   ls ?ail
  ```
  Out put of ls ?ail is fail hail mail sail tail.

  1. * Zero or more characters
  2. ? Exactly one character
###Globs Square

####Brance Expansion
1.Brace
  ${variable/pattern/replacement}

```bash
  touch {MKT,SL,DEV}{001..004}
  echo file{1,2,3}.txt
  echo file{1..5}
  echo {a,b}{1,2,3}
  echo file{1..10..2}
  echo pre-{A..C}-post
  for i in {1..3}; do touch "file${i}.txt";done
```
2.Command Substitutin Expansion
```bash
name="Jhon"
echo "${name}"
find . -type f | wc -l
```
3.Expansions subshells
