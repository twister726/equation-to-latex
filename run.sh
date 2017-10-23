#!/bin/bash

rm -rf output
mkdir output

fname="processing.png"
cp "$1" $fname

python page_optimization/shadow_removal.py "$fname" "output/thresholded_$fname"
python page_optimization/skew_correction.py "output/thresholded_$fname" "output/rotated_$fname"

cd segmentation
mkdir ../output/segmented
matlab -nodesktop -nosplash -r "main('../output/rotated_$fname', '../output/segmented/'); exit"

cd ..
mv "$fname" "output/original.png"
