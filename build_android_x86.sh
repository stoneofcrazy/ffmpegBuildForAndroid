#!/bin/bash
#change NDK to your Android NDK location
NDK=/home/zhaowei/ndk-r10e/android-ndk-r10e
PLATFORM=$NDK/platforms/android-18/arch-x86/
PREBUILT=$NDK/toolchains/x86-4.9/prebuilt/linux-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--cc=$PREBUILT/bin/i686-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/i686-linux-android- \
--nm=$PREBUILT/bin/i686-linux-android-nm "


MODULES="\
--enable-gpl"

function build_x86
{
  ./configure \
  --target-os=android \
  --prefix=./android/x86 \
  --arch=x86 \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --extra-cflags=" -O3 -DANDROID -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -fomit-frame-pointer -march=k8" \
  --enable-shared \
  --disable-static \
  --extra-cflags="-march=i686 -mtune=intel -mssse3 -mfpmath=sse -m32" \
  --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-zlib \
  ${MODULES} \
  --disable-doc \
  --enable-neon

  make clean
  make
  make install
}



build_x86

echo Android x86 builds finished
