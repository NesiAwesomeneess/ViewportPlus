 ViewportPlus
For best results read:
 Tip #1: ensure that all smoothing on the camera in the viewport is diabled (this includes drag margins and camera offsets)
 any custom camera movement script attached to the camera inside the viewport should be detached and moved to the 2DCamera node (The camera outside
the subviewport)

Tip #2: If you're running into any problems with your parallax layers i made a work around in the Miscellaneour folder it has code you are going
add to the 2DCamera node in order and another script named "ParallaxLayer" which has the "ParallaxLayer2D" class_name, just add a node2d and attach
that script to it or just search "ParallaxLayer2D" in the add node menu. 
You can test out the motion and offset values you would like.

 Tip #3: you can make a any node that's render to the resolution of your screen by just adding it to the "HD" group thanks to the HDsprite singleton,
you can look through the code in the miscellaneous folder.

Thanks so much for watching the video, I hope you don't run into any problems using this.
