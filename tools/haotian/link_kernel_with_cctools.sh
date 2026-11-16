#!/usr/bin/env bash
# Link the already-compiled XNU objects once a cctools ld64 is available.
set -euo pipefail
W="${1:-/home/xiao/haotian-build/haotian-kernel-c02}"
CCTOOLS="${CCTOOLS:?set CCTOOLS to the directory containing cctools ld64}"
B="$W/deps/host/bin"
rm -f "$B/ld64"
ln -sfn "$CCTOOLS/ld64" "$B/ld64"
export PATH="$B:$PATH" XNUDEPS="$W/deps" XNU_SDK_PATH="$W/deps/sdk" XNU_SDK_VERSION=16.5
export RC_DARWIN_KERNEL_VERSION=25.6.0
cd "$W/xnu12377"
make SDKROOT=iphoneos ARCH_CONFIGS=ARM64 MACHINE_CONFIGS=BCM2837 \
  KERNEL_CONFIGS=DEVELOPMENT ARCH_STRING_FOR_CURRENT_MACHINE_CONFIG=arm64 \
  BUILD_WERROR=0 BUILD_LTO=0 DO_CTFMERGE=0 BUILD_DSYM=0 \
  HOST_FLEX=flex HOST_BISON=bison HOST_GM4=m4 \
  CC=xnu-clang CXX=xnu-clang++ LOGCOLORS=n MAKEJOBS=--jobs="$(nproc)" \
  KEXT_CREATE_SYMBOL_SET=/usr/bin/true
K="$W/xnu12377/BUILD/obj/DEVELOPMENT_ARM64_BCM2837/mach.development.bcm2837"
test -s "$K"
mkdir -p "$W/out"
cp "$K" "$W/out/kernel-haotian-c02.bin"
sha256sum "$W/out/kernel-haotian-c02.bin"
