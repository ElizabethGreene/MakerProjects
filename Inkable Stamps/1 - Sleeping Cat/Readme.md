# Procedure

1. Generate the source image. Save the image.
* prompt for grok imagine 
```
"A simple, clean black-and-white line drawing of a cute cartoon cat curled up and sleeping. The style is minimal monochrome outline art with thick, bold, continuous black lines on a solid white background. Perfect for stickers, stamps, or coloring pages."
```

2. Open image in inkscape > Path > Trace Bitmap
3. Hide source image
4. Export as SVG
5. Open fusion
6. Draw bounding box rectangle
7. Extrude bounding box rectangle negative 5
8. Extrude path up 4
9. Extrude support block as new body
10. fillet corners
11. chamfer top edge 3
12. print top in TPU, bottom in PLA
13. scale x/y in slicer for size