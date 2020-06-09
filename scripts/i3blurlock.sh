#!/bin/sh

# i3lock blurred screen inspired by /u/patopop007 and the blog post
# http://plankenau.com/blog/post-10/gaussianlock

# Dependencies:
# imagemagick
# i3lock
# scrot or gnome-screenshot

IMAGE=/tmp/i3lock.png
SCREENSHOT="gnome-screenshot -f $IMAGE"

# All options are here: http://www.imagemagick.org/Usage/blur/#blur_args
BLURTYPE="0x4" # 7.52s

# Get the screenshot, add the blur and lock the screen with it
$SCREENSHOT
convert $IMAGE -blur $BLURTYPE $IMAGE
i3lock -i $IMAGE
rm $IMAGE
