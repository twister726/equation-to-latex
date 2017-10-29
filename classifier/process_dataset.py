from PIL import Image
import csv
import math
import os
#
# with open('OcrCodeList.txt', newline='') as csvfile:
#     spamreader = csv.reader(csvfile, delimiter=',')
#     for row in spamreader:

with open('CharInfoDB-3-A.txt', newline='') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',')
    for row in spamreader:
        h = int(row[3])
        w = int(row[4])
        bw = math.ceil(w/8)
        # print(h, bw, h * bw, len(row))
        if not (len(row) - 16 == h * bw):
            print('chut')
            continue
        wt = bw * 8

        img = Image.new( 'RGB', (w, h), "black") # create a new black image
        pixels = img.load() # create the pixel map

        for i in range(h):
            for j in range(bw):
                for z in range(7, -1, -1):
                    if j * 8 + 7 - z >= w:
                        continue
                    # print(row[i * bw + j + 15])
                    pv = (int(row[i * bw + j + 15]) >> z) % 2
                    if pv == 1:
                        pixels[j * 8 + 7 - z, i] = (0, 0, 0)
                    else:
                        pixels[j * 8 + 7 - z, i] = (255, 255, 255)

        # for i in range(img.size[0]):    # for every pixel:
        #     for j in range(img.size[1]):
        #         pixels[i,j] = (105, 5, i) # set the colour accordingly

        os.makedirs('data/' + row[2], exist_ok=True)
        img.save('data/' + row[2] + '/' + row[0] + ".png")
        # print('chut')

    # img = Image.new( 'RGB', (255,255), "black") # create a new black image
    # pixels = img.load() # create the pixel map
    #
    # for i in range(img.size[0]):    # for every pixel:
    #     for j in range(img.size[1]):
    #         pixels[i,j] = (105, 5, i) # set the colour accordingly
    #
    # img.show()
    # img.save("tmp.png")
