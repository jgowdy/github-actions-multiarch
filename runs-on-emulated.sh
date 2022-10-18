#!/bin/sh
echo Hello from $(uname -m)!

apt-get update
apt-get install -y git build-essential gcc make curl

git clone https://github.com/godaddy/cobhan-rust.git
cd cobhan-rust/cobhan || exit

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

. "$HOME/.cargo/env"

export CARGO_HTTP_DEBUG=true
export CARGO_LOG=cargo=debug
export RUST_LOG=cargo=debug

cargo update
