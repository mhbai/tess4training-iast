#!/bin/bash
cd ./tesseract

LANG=iast
## dictEVAL saniastTRAIN dictTRAIN
for PREFIX in  dictTRAIN  ; do

echo -e "$PREFIX -----------------------------------------------------------------------------------------------------------------"

rm -rf  ../training/${PREFIX}
rm -rf  ../training/${PREFIX}-distort

echo -e "\n***** Making training data for ${PREFIX} set for $LANG training."

python3 ~/tesstrain-tam/normalize.py -v ../langdata/$LANG/${PREFIX}.training_text

bash src/training/tesstrain.sh \
--fonts_dir /home/ubuntu/.fonts/iast \
--lang iast \
--linedata_only \
--noextract_font_properties \
--langdata_dir ../langdata \
--training_text ../langdata/$LANG/${PREFIX}.training_text \
--tessdata_dir ../tessdata \
--output_dir ../training/${PREFIX} \
--exposures   "-3 -2 -1 0 1 2" \
--save_box_tiff \
--maxpages 0 \
--fontlist \
"FreeSerif Italic" \
"FreeSerif" \
"Island Roman," \
"Libre Baskerville" \
"Libre Baskerville Italic" \
"Old Standard Indologique" \
"Old Standard Indologique Italic" \
"RoundslabSerif Medium" \
"TeX Gyre Schola" \
"TeX Gyre Schola Italic" \
"Trocchi" 

echo "-----------------------------------------------------------------------------------------------------------------"

bash src/training/tesstrain.sh \
--fonts_dir /home/ubuntu/.fonts/iast \
--lang iast \
--linedata_only \
--noextract_font_properties \
--langdata_dir ../langdata \
--training_text ../langdata/$LANG/${PREFIX}.training_text \
--tessdata_dir ../tessdata \
--output_dir ../training/${PREFIX}-distort \
--distort_image \
--save_box_tiff \
--maxpages 0 \
--fontlist \
"FreeSerif Italic" \
"FreeSerif" \
"Island Roman," \
"Libre Baskerville" \
"Libre Baskerville Bold" \
"Libre Baskerville Italic" \
"Old Standard Indologique" \
"Old Standard Indologique Italic" \
"RoundslabSerif Medium" \
"TeX Gyre Schola" \
"TeX Gyre Schola Bold" \
"TeX Gyre Schola Bold Italic" \
"TeX Gyre Schola Italic" \
"Trocchi" 

echo "-----------------------------------------------------------------------------------------------------------------"

done

echo "-----------------------------------------------------------------------------------------------------------------"

