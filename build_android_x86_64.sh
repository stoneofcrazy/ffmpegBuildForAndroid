#!/bin/bash
#change NDK to your Android NDK location
NDK=/home/zhaowei/ndk-r10e/android-ndk-r10e
PLATFORM=$NDK/platforms/android-21/arch-x86_64/
PREBUILT=$NDK/toolchains/x86_64-4.9/prebuilt/linux-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--cc=$PREBUILT/bin/x86_64-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/x86_64-linux-android- \
--nm=$PREBUILT/bin/x86_64-linux-android-nm "


MODULES="\
--enable-gpl"

function build_x86_64
{
  ./configure \
  --target-os=android \
  --prefix=./android/x86_64 \
  --arch=x86_64 \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --extra-cflags="-march=x86-64 -msse4.2 -mpopcnt -m64 -mtune=intel" \
  --enable-shared \
  --disable-static \
  --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-zlib \
  ${MODULES} \
  --disable-doc \
  --enable-neon

  make clean
  make
  make install
}



build_x86_64

echo Android x86_64 builds finished
