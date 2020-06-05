#!/bin/bash
## lang=eng-fast - 93.85%  Accuracy
## lang=Latin-fast - 94.68%  Accuracy
## lang=IASTone - 96.36%  Accuracy
## lang=iast-IASTone-plus-fast - 96.72%  Accuracy 3/6 8:30
## lang=iast-Latin-plus-fast -    96.18%  Accuracy @ 0.269 @25000
lang=$1
PSM=3
cd test
my_files=$(ls *{*.jpg,*.tif,*.png,*.jp2})
    rm  *ALL*$lang*.txt *$lang.txt
    for my_file in ${my_files}; do
             echo -e "\n ***** "  $my_file "LANG" $lang  $PSM "****"
            OMP_THREAD_LIMIT=1 time -p tesseract $my_file  "${my_file%.*}-$lang" --oem 1 --psm $PSM -l "$lang"+Devanagari-fast --dpi 300 --tessdata-dir ../tessdata/best -c preserve_interword_spaces=1 -c page_separator='' -c paragraph_text_based=false -c tessedit_do_invert=0
            ## accuracy   "${my_file%.*}".gt.txt   "${my_file%.*}-$lang".txt  >   "${my_file%.*}-$lang"-accuracy.txt
            cat "${my_file%.*}-$lang".txt >> ALL-$lang.txt
            cat "${my_file%.*}".gt.txt >>  ALL-$lang-gt.txt
    done
    accuracy  ALL-$lang-gt.txt  ALL-$lang.txt  >  accuracy-ALL-$lang.txt
    wordacc  ALL-$lang-gt.txt  ALL-$lang.txt  >  wordacc-ALL-$lang.txt
echo "DONE with my_files"
