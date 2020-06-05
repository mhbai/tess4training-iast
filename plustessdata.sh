#!/bin/bash
STARTMODEL=$1
LANG=$2
PREFIX=$3
TRAINDIR=$LANG-from-$STARTMODEL
cd ./tesseract

echo -e "\n***** Stop lstmtraining and convert to traineddata. \n"
lstmtraining \
  --stop_training \
  --continue_from ../tesstutorial/$TRAINDIR/${LANG}_checkpoint \
  --traineddata ../tesstutorial/${PREFIX}TRAIN/$LANG/$LANG.traineddata\
  --old_traineddata ../tessdata/best/$STARTMODEL.traineddata \
  --model_output  ../tessdata/best/$LANG-$STARTMODEL-plus.traineddata

lstmtraining \
  --stop_training \
  --convert_to_int  \
  --continue_from ../tesstutorial/$TRAINDIR/${LANG}_checkpoint \
  --traineddata ../tesstutorial/${PREFIX}TRAIN/$LANG/$LANG.traineddata\
  --old_traineddata ../tessdata/best/$STARTMODEL.traineddata \
  --model_output  ../tessdata/best/$LANG-$STARTMODEL-plus-fast.traineddata

echo -e "IAST:best:shreeshrii:`date +%Y%m%d`:plusminus:from:$STARTMODEL" > $LANG-plus.version
combine_tessdata -o ../tessdata/best/$LANG-$STARTMODEL-plus.traineddata  $LANG-plus.version

echo -e "IAST:fast:shreeshrii:`date +%Y%m%d`:plusminus:from:$STARTMODEL" > iast_fast.version
combine_tessdata -o ../tessdata/best/$LANG-$STARTMODEL-plus-fast.traineddata  iast_fast.version

rm  ../tessdata/best/*.__tmp__

