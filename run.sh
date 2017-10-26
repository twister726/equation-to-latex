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

cd output/segmented
for file in `ls -1`; do
  predicted=`tesseract -l eng+ell+lat --psm 10 $file stdout 2>/dev/null | head -n 1`
  mv "$file" "${file}_predicted_${predicted}.png"
done
cd -

mv "$fname" "output/original.png"
