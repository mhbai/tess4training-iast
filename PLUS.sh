#!/bin/bash
STARTMODEL=$1
LANG=iast
PREFIX=dict
TRAINDIR=$PREFIX-$LANG-from-$STARTMODEL
cd ./tesseract

echo "-----------------------------------------------------------------------------------------------------------------"

rm -rf ../training/$TRAINDIR
mkdir -p ../training/$TRAINDIR

echo -e "\n***** Extract LSTM model from best traineddata for $STARTMODEL. \n"
combine_tessdata -u ../tessdata/best/$STARTMODEL.traineddata ../training/$TRAINDIR/$STARTMODEL.

echo "-----------------------------------------------------------------------------------------------------------------"
lstmtraining --debug_interval -1 \
  --continue_from ../training/$TRAINDIR/$STARTMODEL.lstm \
  --old_traineddata ../tessdata/best/$STARTMODEL.traineddata \
  --traineddata ../training/$LANG/$LANG.traineddata\
  --model_output ../training/$TRAINDIR/$LANG \
  --train_listfile ../training/list.train \
  --eval_listfile ../training/list.eval \
  --max_iterations 5000

### cd ..
### bash plustessdata.sh $STARTMODEL $LANG $PREFIX
