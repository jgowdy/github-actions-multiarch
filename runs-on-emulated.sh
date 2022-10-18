#!/bin/sh
echo Hello from $(uname -m)!

apt-get update
apt-get install -y git build-essential gcc make curl

git clone https://github.com/godaddy/cobhan-rust.git
cd cobhan-rust || exit

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

cargo update
