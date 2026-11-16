# Haotian (Xiaomi 15 Pro) XNU kernel build

GitHub Actions workflow builds the project's XNU 26 snapshot on Ubuntu with a
cctools ld64 and uploads kernel-haotian-c02.bin.

The SDK under deps/ is the project's cached compile-check SDK, so the output is
a compile-check kernel, not a release kernel, and has not been hardware tested.
