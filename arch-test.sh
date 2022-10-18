#!/bin/bash

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
export CARGO_NET_GIT_FETCH_WITH_CLI=true
time cargo update
cd ../..

echo "Testing ${TEST_ARCH} emulation"
#-v "${HOME}/.cargo/git:/root/.cargo/git" -v "${HOME}/.cargo/registry:/root/.cargo/registry"
docker run --rm -v $(pwd):/build -v $(pwd)/cobhan-rust:/cobhan-rust "${TEST_ARCH}/debian:sid" /build/runs-on-emulated.sh
