#!/bin/sh
echo Hello from $(uname -m)!

git clone https://github.com/godaddy/cobhan-rust.git
cd cobhan-rust || exit

cargo update
