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
