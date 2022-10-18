#!/bin/sh

echo "Updating apt"
sudo apt-get update -y

echo "Installing qemu support"
sudo apt-get install qemu binfmt-support qemu-user-static -y

echo "Register qemu support with docker"
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

echo "Clone cobhan-rust on host"
git clone https://github.com/godaddy/cobhan-rust.git
cd cobhan-rust/cobhan || exit
echo "Cargo update on host"
cargo update
ls -la "${HOME}/.cargo/git"
ls -la "${HOME}/.cargo/registry"
cd ../..

echo "Testing ${TEST_ARCH} emulation"
docker run --rm -v $(pwd):/build -v $(pwd)/cobhan-rust:/cobhan-rust -v "${HOME}/.cargo/git:/root/.cargo/git" -v "${HOME}/.cargo/registry:/root/.cargo/registry" "${TEST_ARCH}/debian:sid" /build/runs-on-emulated.sh
