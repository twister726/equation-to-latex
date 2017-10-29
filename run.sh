#!/bin/bash

rm -rf output
mkdir output

fname="processing.png"
convert "$1" $fname

cd page_optimization
mkdir ../output/segmented
matlab -nodesktop -nosplash -r "remove_shadow('../$fname', '../output/thresholded_$fname'); exit"
cd ..

python page_optimization/skew_correction.py "output/thresholded_$fname" "output/rotated_$fname"

cd segmentation
mkdir ../output/segmented
matlab -nodesktop -nosplash -r "main('../output/rotated_$fname', '../output/segmented/'); exit"
cd ..

cd output/segmented
for file in `ls -1`; do
  predicted=`tesseract -l eng+ell+lat --psm 10 $file stdout 2>/dev/null | head -n 1`
  if [ predicted == "/" ]; then
    predicted="slash"
  fi
  mv "$file" "${file}_predicted_${predicted}.png"
done
cd -

mv "$fname" "output/original.png"
