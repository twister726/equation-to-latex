# import the necessary packages
import numpy as np
import sys
import cv2
import os
from scipy.spatial import ConvexHull
from min_bounding_rect import minBoundingRect

# construct the argument parse and parse the arguments
filename = os.path.abspath(sys.argv[1])
outpath = os.path.abspath(sys.argv[2])

# load the image from disk
image = cv2.imread(filename)

# convert the image to grayscale and flip the foreground
# and background to ensure foreground is now "white" and
# the background is "black"
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
gray = cv2.bitwise_not(gray)

# threshold the image, setting all foreground pixels to
# 255 and all background pixels to 0
thresh = cv2.threshold(gray, 0, 255,
	cv2.THRESH_BINARY | cv2.THRESH_OTSU)[1]

	# grab the (x, y) coordinates of all pixel values that
# are greater than zero, then use these coordinates to
# compute a rotated bounding box that contains all
# coordinates
coords = np.column_stack(np.where(thresh > 0))
hull = ConvexHull(coords)
hull_points = hull.points[hull.vertices]
# print hull_points
# print hull_points[0], hull_points[-1]
angle = minBoundingRect(hull_points)[0]
angle =  np.degrees(angle)
# INBUILT
# angle = cv2.minAreaRect(coords)[-1]

# the `cv2.minAreaRect` function returns values in the
# range [-90, 0); as the rectangle rotates clockwise the
# returned angle trends to 0 -- in this special case we
# need to add 90 degrees to the angle
if angle < -45:
	angle = -(90 + angle)

# otherwise, just take the inverse of the angle to make
# it positive
else:
	angle = -angle

# NOT INBUILT
angle = 90 + angle # Only when not using inbuilt
if angle > 90:
	angle -= 90
# rotate the image to deskew it
(h, w) = image.shape[:2]
image = cv2.copyMakeBorder(image, h, h, w, w, cv2.BORDER_CONSTANT, value=[255, 255, 255])
(h, w) = image.shape[:2]
center = (w // 2, h // 2)
M = cv2.getRotationMatrix2D(center, angle, 1.0)
rotated = cv2.warpAffine(image, M, (w, h),
	flags=cv2.INTER_CUBIC, borderMode=cv2.BORDER_REPLICATE)

# draw the correction angle on the image so we can validate it
# cv2.putText(rotated, "Angle: {:.2f} degrees".format(angle),
# 	(10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)

# show the output image
print("[INFO] angle: {:.3f}".format(angle))
# cv2.imshow("Input", image)
cv2.imwrite(outpath, rotated)
