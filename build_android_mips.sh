#!/bin/bash
#Change NDK to your Android NDK location
NDK=/home/zhaowei/ndk-r10e/android-ndk-r10e
PLATFORM=$NDK/platforms/android-21/arch-mips/
PREBUILT=$NDK/toolchains/mipsel-linux-android-4.9/prebuilt/linux-x86_64


GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--cc=$PREBUILT/bin/mipsel-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/mipsel-linux-android- \
--nm=$PREBUILT/bin/mipsel-linux-android-nm"

MODULES="\
--enable-gpl"


function build_mips
{
  ./configure \
  --logfile=conflog.txt \
  --target-os=android \
  --prefix=$PREFIX  \
  --arch=mips \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --disable-shared \
  --enable-static \
  --disable-mipsdsp --disable-mipsdspr2 --disable-mipsfpu \
  --extra-ldflags=" -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
--disable-ffplay \
--disable-programs \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
\
--disable-doc \
--disable-htmlpages \
--disable-manpages \
--disable-podpages \
--disable-txtpages \
--disable-outdevs \
--disable-indevs \
\
--disable-avfilter \
--disable-avdevice \
--disable-everything \
--disable-network \
--enable-decoder=h264 \
\
--enable-parser=h264 \
--enable-zlib \
  --disable-doc \
  ${MODULES}

  make clean
  make -j8
  make install
}

build_mips


echo Android MIPS builds finished
