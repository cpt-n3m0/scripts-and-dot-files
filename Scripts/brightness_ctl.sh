#!/usr/bin/bash


while [ 1 -eq 1 ]
do
	MIN=5000
	MAX=$(< /sys/class/backlight/intel_backlight/max_brightness)
	OUT=/sys/class/backlight/intel_backlight/brightness

	AMBIENT=$(ffmpeg -i /dev/video0 -vf scale=1:1 -pix_fmt gray -f rawvideo -frames:v 1 -v quiet pipe:1 | od -t u | sed "s/000000[01]\s*//" | sed q)

	BRIGHTNESS=$(( $AMBIENT  * $MAX / 255 + 2000 ))
	echo $(( $BRIGHTNESS > $MIN ? $BRIGHTNESS : $MIN )) | sudo tee $OUT
	sleep 0.5
done
