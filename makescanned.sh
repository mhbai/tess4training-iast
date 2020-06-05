#!/bin/bash
### Uses default language eng  and also wordstrbox config from TESSDATA_PREFIX

### my_files=$(ls test/*.png)
### for my_file in ${my_files}; do
###    convert ${my_file%.*}.png ${my_file%.*}.tif
### done

my_files=$(ls test/*.tif)
for my_file in ${my_files}; do
    echo -e "\n${my_file%.*}"
    python3 ~/tesstrain-tam/normalize.py -v ${my_file%.*}.gt.txt
    OMP_THREAD_LIMIT=1 tesseract ${my_file%.*}.tif        ${my_file%.*} --psm 6 -c page_separator='' -c paragraph_text_based=false -c tessedit_do_invert=0 wordstrbox
    mv "${my_file%.*}.box" "${my_file%.*}.wordstrbox" 
    sed -i -e "s/ \#.*/ \#/g"  ${my_file%.*}.wordstrbox
    sed -e '/^$/d' ${my_file%.*}.gt.txt > ${my_file%.*}.tmp
    sed -e  's/$/\n/g'  ${my_file%.*}.tmp > ${my_file%.*}.gt.txt
    paste --delimiters="\0"  ${my_file%.*}.wordstrbox  ${my_file%.*}.gt.txt > ${my_file%.*}.box
    rm ${my_file%.*}.wordstrbox  ${my_file%.*}.tmp
    echo "*************  check the box files for any errors and fix those before running training  **************"
    OMP_THREAD_LIMIT=1 tesseract ${my_file%.*}.tif ${my_file%.*}  --psm 6 lstm.train
 done

rm -rf  training/dictscanned
mkdir  training/dictscanned
cp -v test/*.* training/dictscanned/
