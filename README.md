# Docker: SDU gstreamer
Build of gstreamer based on https://github.com/SDU-Embedded including plugins under development. If you just need a build from source use https://hub.docker.com/r/halftome/docker-gstreamer/ instead.

There are two use-cases for this container:

1. You want to use one of the developed plugins. We typically use gstreamer in containers as data processors. Below is an example of processing sound into spectrogram video.
2. You want to develop a plugin. Working in the container saves you the trouble of intalling dependencies and makes it easy to share your work.

# Test
The test will run a container processing sound data into video of a spectrogram. It assumes that you have gstreamer installed on your computer (the host). Instructions on how to install can be found here:
https://gstreamer.freedesktop.org/documentation/installing/on-linux.html

You will need three terminal windows for the test. The first one will generate an audio signal, the second will run the container and the third will display the spectrogram video.

## Generate test sound on host
```
gst-launch-1.0 -v audiotestsrc wave=8 is-live=true ! "audio/x-raw, format=S16LE, rate=48000" ! audioconvert ! rtpL16pay ! udpsink host=172.17.0.2 port=5004
```

## Process sound to spectrogram in the container
```
docker run -t leonbondelarsen/sdu_gstreamer gst-launch-1.0 -v udpsrc port=5004 caps='application/x-rtp, media=audio, clock-rate=48000, encoding-name=L16, encoding-params=1, payload=96, format=S16BE, rate=48000, channels=1, layout=interleaved' ! rtpL16depay ! audioconvert ! spectrogramscope colormap=1 ! videoconvert ! x264enc tune=zerolatency bitrate=500 speed-preset=superfast ! rtph264pay config-interval=1 ! udpsink host=172.17.0.1 port=5005 auto-multicast=true
```

## Show video on host
```
gst-launch-1.0 -v udpsrc port=5005 ! "application/x-rtp, media=video, clock-rate=90000, encoding-name=H264, payload=96" ! rtph264depay ! avdec_h264 ! videoconvert ! autovideosink
```

# License
MIT
