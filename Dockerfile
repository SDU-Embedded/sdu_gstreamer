FROM ubuntu:rolling

RUN apt-get -y update

# Install dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  autoconf \
  automake \
  autopoint \
  bison \
  flex \
  libtool \
  yasm \
  nasm \
  git-core \
  build-essential \
  gettext \
  libegl1-mesa-dev \
  libgl1-mesa-dev \
  libgles2-mesa-dev \
  libavfilter-dev \
  libglib2.0-dev \
  libgirepository1.0-dev \
  libpthread-stubs0-dev \
  libssl-dev \
  liborc-dev \
  libmpg123-dev \
  libmp3lame-dev \
  libsoup2.4-dev \
  libshout3-dev \
  libpulse-dev \
  libva-dev \
  libxv-dev \
  libalsa-ocaml-dev \
  libcdparanoia-dev \
  libopus-dev \
  libpango1.0-dev \
  libvisual-0.4-dev \
  libvorbisidec-dev \
  libaa1-dev \
  libcaca-dev \
  libdv4-dev \
  libflac-dev \
  libjack-dev \
  libtag1-dev \
  libdrm-dev \
  libvpx-dev \
  libwavpack-dev \
  libass-dev \
  libzbar-dev \
  libx265-dev \
  libx264-dev \
  libwildmidi-dev \
  libvulkan-dev \
  libx11-dev \
  libxrandr-dev \
  libwayland-dev \
  wayland-protocols \
  libwebp-dev \
  libwebrtc-audio-processing-dev \
  libvdpau-dev \
  libsrtp0-dev \
  libvo-aacenc-dev \
  libvo-amrwbenc-dev \
  libbs2b-dev \
  libdc1394-22-dev \
  libdts-dev \
  libfaac-dev \
  libfaad-dev \
  libfdk-aac-dev \
  libfluidsynth-dev \
  libcurl-ocaml-dev \
  libgme-dev \
  libgsm1-dev \
  librtmp-dev \
  libcurl-ocaml-dev \
  libjpeg-turbo8-dev \
  liba52-0.7.4-dev \
  libcdio-dev \
  libtwolame-dev \
  libx264-dev \
  libmpeg2-4-dev \
  libsidplay1-dev \
  gobject-introspection \
  libudev-dev \
  python3-pip \
  python3-gi \
  python-gi-dev \
  graphviz \
  ninja-build \
  libopencv-dev \
  iproute2 \
  vim 

# Install app dependencies
RUN pip3 install --upgrade pip
RUN pip3 install meson

# Fetch and build GStreamer
RUN git clone --depth 1 https://github.com/SDU-Embedded/gst-build.git && \
  cd gst-build && \
  mkdir build/ && \
  meson build --prefix=/usr --libdir=/usr/lib --buildtype=release && \
  ninja -C build -j `nproc` && \
  ninja -C build install && \
  cd ..

# Do some cleanup
RUN DEBIAN_FRONTEND=noninteractive  apt-get clean && \
  apt-get autoremove -y

