import cv2
import sys
import os
import numpy as np
# from matplotlib import pyplot as plt

def localthreshold(img, blocksize, c):
	rows = img.shape[0]
	cols = img.shape[1]
	print img.shape

	temp = cv2.getGaussianKernel(blocksize, -1)
	kernel = np.matmul(temp, np.transpose(temp))

	pad_img = np.lib.pad(img, blocksize/2, 'constant', constant_values=(0,0))
	print pad_img.shape
	for i in range(blocksize/2, rows + blocksize/2):
		for j in range(blocksize/2, cols + blocksize/2):
			img_window = pad_img[i - blocksize/2 : i + blocksize/2 + 1, j - blocksize/2 : j + blocksize/2 + 1]

			thres = np.multiply(kernel, img_window).sum() - c

			if pad_img[i][j] <= thres:
				pad_img[i][j] = 0
			else:
				pad_img[i][j] = 255

	final = pad_img[blocksize/2 : rows + blocksize/2,blocksize/2 : cols + blocksize/2]
	print final.shape
	return final

# tempim = localthreshold(cv2.imread('shadow.jpg',0), 11, 2)
# cv2.imwrite('tempshadow.jpg', tempim)
# sys.exit(0)

filename = os.path.abspath(sys.argv[1])
outpath = os.path.abspath(sys.argv[2])

img = cv2.imread(filename,0)

# img = cv2.medianBlur(img,5)
img = cv2.bilateralFilter(img,5,75,75)
# ret,th1 = cv2.threshold(img,127,255,cv2.THRESH_BINARY)
# th2 = cv2.adaptiveThreshold(img,255,cv2.ADAPTIVE_THRESH_MEAN_C,\
#             cv2.THRESH_BINARY,11,2)

th3= cv2.adaptiveThreshold(img,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C,cv2.THRESH_BINARY,11,2)
# th3 = localthreshold(img,11,2)

cv2.imwrite(outpath, th3)
# titles = ['Original Image', 'Global Thresholding (v = 127)',
#             'Adaptive Mean Thresholding', 'Adaptive Gaussian Thresholding']
# images = [img, th1, th2, th3]
# for i in xrange(4):
#     plt.subplot(2,2,i+1),plt.imshow(images[i],'gray')
#     plt.title(titles[i])
#     plt.xticks([]),plt.yticks([])
# plt.show()
