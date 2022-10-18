#!/bin/sh

echo "Updating apt"
sudo apt-get update -y

echo "Installing qemu support"
sudo apt-get install qemu binfmt-support qemu-user-static -y

echo "Register qemu support with docker"
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

echo "Testing ${TEST_ARCH} emulation"
docker run --rm -v $(pwd):/build "${TEST_ARCH}/debian:sid" /build/runs-on-emulated.sh
