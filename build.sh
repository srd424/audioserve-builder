# /bin/bash

set -e
set -x

cd /
rm -r -f /audioserve
git clone https://github.com/izderadicka/audioserve.git
cd audioserve
export PKG_CONFIG_ALLOW_CROSS=1
export CARGO_TARGET_DIR=/target
export CARGO_HOME=/cargo
cp /cargo-config /cargo/config
cargo build --target=aarch64-unknown-linux-gnu
cp $CARGO_TARGET_DIR/aarch64-unknown-linux-gnu/debug/audioserve /result

exit 0
