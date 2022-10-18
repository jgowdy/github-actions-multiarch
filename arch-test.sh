#!/bin/sh

echo "Updating apt"
sudo apt-get update -y

echo "Installing qemu support"
sudo apt-get install qemu binfmt-support qemu-user-static -y

echo "Register qemu support with docker"
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

git clone https://github.com/godaddy/cobhan-rust.git
cd cobhan-rust/cobhan || exit
cargo update
cd ../..

echo "Testing ${TEST_ARCH} emulation"
docker run --rm -v $(pwd):/build    -v "${HOME}/.cargo/git:/usr/local/cargo/git" -v "${HOME}/.cargo/registry:/usr/local/cargo/registry" "${TEST_ARCH}/debian:sid" /build/runs-on-emulated.sh
