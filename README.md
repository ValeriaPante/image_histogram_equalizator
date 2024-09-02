# Image Histogram Equalizator

The method of equalizing the histogram of an image is a method designed to recalibrate the contrast of an image when the range of intensity values are very close by distributing them over the entire intensity range, in order to increase the contrast.

<img width="435" alt="Schermata 2021-11-27 alle 11 49 57" src="https://user-images.githubusercontent.com/79789250/143678179-f64cd36f-280c-44c5-a92e-0751df90d5e8.png">


This project aims at developing a simplified version of the equalizing algorithm.
The equalization algorithm will only be applied to 256-level grayscale images and must transform each of its pixels as follows:

>DELTA_VALUE = MAX_PIXEL_VALUE – MIN_PIXEL_VALUE
>
>SHIFT_LEVEL = (8 – FLOOR(LOG2(DELTA_VALUE +1))))
>
>TEMP_PIXEL = (CURRENT_PIXEL_VALUE - MIN_PIXEL_VALUE) << SHIFT_LEVEL 
>
>NEW_PIXEL_VALUE = MIN( 255 , TEMP_PIXEL)

The module to be implemented will have to read the image from a memory in which the image to be processed is stored sequentially and line by line. Each byte corresponds to one pixel of the image.
The size of the image is defined by 2 bytes, stored starting from address 0. The byte at address 0 refers to the column size; the byte in address 1 refers to the row size. The maximum image size is 128x128 pixels.
The image is stored starting from address 2 and in contiguous bytes. So the byte at address 2 is the first pixel of the first line of the image.
The equalized image must be written into memory immediately after the original image.

In this repository you can find the component realized in VHDL, the report of realization of the component (only in Italian) and a folder containing all the test to which the component has been subjected.
