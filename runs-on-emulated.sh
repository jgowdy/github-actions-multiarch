#!/bin/sh
echo Hello from $(uname -m)!

apt-get update
apt-get install git -y

git clone https://github.com/godaddy/cobhan-rust.git
cd cobhan-rust || exit

cargo update
