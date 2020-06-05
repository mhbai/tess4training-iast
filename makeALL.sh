#!/bin/bash
cd tesseract

ls -1 ../training/*/*.lstmf > ../training/all-lstmf

ls -1 ../training/*EVAL*/*.lstmf > /tmp/ALLlist.eval
shuf  /tmp/ALLlist.eval > ../training/list.eval

ls -1 ../training/*TRAIN*/*.lstmf > /tmp/ALLlist.train
ls -1 ../training/*scanned*/*.lstmf >> /tmp/ALLlist.train
shuf /tmp/ALLlist.train > ../training/list.train

cat ../training/dictscanned/*.gt.txt ../langdata/iast/dictTRAIN.training_text ../langdata/iast/dictEVAL.training_text  ../langdata/iast/saniastTRAIN.training_text  > ../training/all-gt

unicharset_extractor --output_unicharset ../training/iast.unicharset --norm_mode 1 ../training/all-gt

### uses https://github.com/wincentbalin/pytesstrain to create wordlist from all-gt
create_dictdata -d ../langdata/iast/ -i  ../training/all-gt -l iast
rm ../langdata/iast/*bigram*

combine_lang_model --input_unicharset ../training/iast.unicharset --script_dir ../langdata --words ../langdata/iast/iast.wordlist --numbers ../langdata/iast/iast.numbers --puncs ../langdata/iast/iast.punc --output_dir ../training --lang iast

cd ..
