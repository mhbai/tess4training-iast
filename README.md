# tess4training-iast

## LSTM Training for IAST (Sanskrit written in Latin/Roman script)

In order to successfully run this Tesseract 4 LSTM Training, you need to have a working installation of Tesseract 
and Tesseract Training Tools (4.00 +). 

For running Tesseract 4 training, it is useful, but not essential to have a multi-core (4 is good) machine, with OpenMP
and Intel Intrinsics support for SSE/AVX extensions. Basically it will still run on anything with enough memory,
but the higher-end your processor is, the faster it will go.

Please note that only traineddata files from [tessdata_best](https://github.com/tesseract-ocr/tessdata_best/)
can be used as a base for further training. The `integer` models in [tessdata](https://github.com/tesseract-ocr/tessdata) and
[tessdata_fast](https://github.com/tesseract-ocr/tessdata_fast) can not be used for this purpose and will
cause an assertion.

The fonts needed for Training must be installed first, if not already available on your system.
Otherwise the training script will not find the required fonts and fail.

Scripts from [pytesstrain](https://github.com/wincentbalin/pytesstrain) were used to create wordlist from the training texts.

OCR evaluation can be done using [ISRI Analytic Tools for OCR Evaluation with UTF-8 support](https://github.com/eddieantonio/ocreval). 

## Training Texts

Since this traineddata is meant to recognize Sanskrit-English dictionary with some text in IAST, the training text used for finetuning is in similar format. Additionally langdata/san/san.training_text was converted from Devanagari script to IAST for additional training. `text2image` gives error if there is no text rendered for a page (search for errors in [makedata](https://raw.githubusercontent.com/Shreeshrii/tess4training-iast/master/makedata.log) logfile), so linenumbers were added to one training_text to avoid the error.

* [dictEVAL.training_text](https://github.com/Shreeshrii/tess4training-iast/blob/master/langdata/iast/dictEVAL.training_text)
* [dictTRAIN.training_text](https://github.com/Shreeshrii/tess4training-iast/blob/master/langdata/iast/dictTRAIN.training_text)
* [saniastTRAIN.training_text](https://github.com/Shreeshrii/tess4training-iast/blob/master/langdata/iast/saniastTRAIN.training_text)

## Fonts Used

Fonts for training were selected to be similar to the scanned pages to be recognized. Training box/tif pairs were created for `exposure levels, -3, -2, -1, 0, 1 and 2`. Additional box/tif pairs were created for exposure level 0 with the `distort-image` flag.

* "FreeSerif Italic" 
* "FreeSerif" 
* "Island Roman," 
* "Libre Baskerville" 
* "Libre Baskerville Bold" 
* "Libre Baskerville Italic" 
* "Old Standard Indologique" 
* "Old Standard Indologique Italic" 
* "RoundslabSerif Medium" 
* "TeX Gyre Schola" 
* "TeX Gyre Schola Bold" 
* "TeX Gyre Schola Bold Italic" 
* "TeX Gyre Schola Italic" 
* "Trocchi" 

## Scanned Pages

A few scanned pages and their groundtruth was used to create wordstrbox files and these box/tiff pairs were also used for training and for further finetuning.

## Training Steps

1. Put the scanned pages and their ground truth (*.tif and *.gt.txt) in `test` directory. Run `bash makescanned.sh`.
2. Put the training text for use with fonts in `langdata/iast` directory. Name as xxxTRAIN.training_text to use for training and as xxxEVAL.training_text to use for model evaluation. Run `bash makedata.sh xxxTRAIN` or  `bash makedata.sh xxxEVAL`. 
3. 