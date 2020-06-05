#!/bin/bash
STARTMODEL=$1
LANG=$2
cd ./tesseract

echo -e "\n***** Stop lstmtraining and convert to traineddata. \n"
lstmtraining \
  --stop_training \
  --continue_from ../tesstutorial/$LANG-from-$STARTMODEL/${LANG}_checkpoint \
  --traineddata ../tesstutorial/TRAIN/$LANG/$LANG.traineddata\
  --old_traineddata ../tessdata/best/$STARTMODEL.traineddata \
  --model_output  ../tessdata/best/$LANG-plus.traineddata

lstmtraining \
  --stop_training \
  --convert_to_int  \
  --continue_from ../tesstutorial/$LANG-from-$STARTMODEL/${LANG}_checkpoint \
  --traineddata ../tesstutorial/TRAIN/$LANG/$LANG.traineddata\
  --old_traineddata ../tessdata/best/$STARTMODEL.traineddata \
  --model_output  ../tessdata/best/$LANG-plus-fast.traineddata

echo -e "IAST:best:shreeshrii:`date +%Y%m%d`:plusminus:from:$STARTMODEL" > $LANG-plus.version
combine_tessdata -o ../tessdata/best/$LANG-plus.traineddata  $LANG-plus.version

echo -e "IAST:fast:shreeshrii:`date +%Y%m%d`:plusminus:from:$STARTMODEL" > iast_fast.version
combine_tessdata -o ../tessdata/best/$LANG-plus-fast.traineddata  iast_fast.version

rm  ../tessdata/best/*.__tmp__
###
###
###echo -e "\n***** Run lstmeval for best plus on tesstutorial/EVAL set. \n"
###lstmeval --model ../tessdata/best/$LANG-plus.traineddata \
###  --verbosity 0 \
###  --eval_listfile ../tesstutorial/EVAL/$LANG.training_files.txt
###
echo -e "\n***** Run lstmeval for fast plus on tesstutorial/EVAL set. \n"
lstmeval --model ../tessdata/best/$LANG-plus-fast.traineddata \
  --verbosity 0 \
  --eval_listfile ../tesstutorial/EVAL/$LANG.training_files.txt
