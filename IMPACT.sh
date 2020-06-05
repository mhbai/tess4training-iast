#!/bin/bash
STARTMODEL=IASTone
LANG=impact
cd ./tesseract

rm -rf  ../tesstutorial/$LANG-from-$STARTMODEL
mkdir  -p ../tesstutorial/$LANG-from-$STARTMODEL

echo -e "\n***** Extract LSTM model from best traineddata for $STARTMODEL. \n"
combine_tessdata -e ../tessdata/best/$STARTMODEL.traineddata \
../tesstutorial/$LANG-from-$STARTMODEL/$STARTMODEL.lstm

ls -1 ../tesstutorial/scanned/*.lstmf > ../tesstutorial/scanned/$LANG.training_files.txt

lstmtraining --debug_interval -1 \
  --continue_from ../tesstutorial/$LANG-from-$STARTMODEL/$STARTMODEL.lstm \
  --traineddata ../tessdata/best/$STARTMODEL.traineddata \
  --model_output ../tesstutorial/$LANG-from-$STARTMODEL/$LANG \
  --train_listfile ../tesstutorial/scanned/$LANG.training_files.txt \
   --max_iterations 2000

lstmtraining \
  --stop_training \
  --continue_from ../tesstutorial/$LANG-from-$STARTMODEL/${LANG}_checkpoint \
  --traineddata ../tessdata/best/$STARTMODEL.traineddata \
  --model_output  ../tessdata/best/$LANG.traineddata

lstmeval --model  ../tessdata/best/$LANG.traineddata \
  --verbosity 1 \
  --eval_listfile ../tesstutorial/scanned/$LANG.training_files.txt

### lstmeval --model  ../tessdata/best/$LANG.traineddata \
###   --verbosity 0 \
###   --eval_listfile /home/ubuntu/tess4training-iast/tesstutorial/prachiEVAL/iast.training_files.txt
### 
### lstmeval --model  ../tessdata/best/IASTone.traineddata \
###   --verbosity 0 \
###   --eval_listfile /home/ubuntu/tess4training-iast/tesstutorial/prachiEVAL/iast.training_files.txt

echo -e "IAST:best:shreeshrii:`date +%Y%m%d`:from:$STARTMODEL" > Version_str
combine_tessdata -o ../tessdata/best/$LANG.traineddata Version_str

cp  ../tessdata/best/$LANG.traineddata  ../tessdata/best/$LANG-`date +%Y%m%d`-fast.traineddata
combine_tessdata -c ../tessdata/best/$LANG-`date +%Y%m%d`-fast.traineddata
