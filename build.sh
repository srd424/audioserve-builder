# /bin/bash

set -e
set -x

cd /
rm -r -f /audioserve
git clone https://github.com/izderadicka/audioserve.git
cd audioserve

export PKG_CONFIG_ALLOW_CROSS=1
#export CARGO_TARGET_DIR=/target
export CARGO_TARGET_DIR=/build/target
#export CARGO_HOME=/cargo
export CARGO_HOME=/build/cargo
export npm_config_cache=/build/npm

mkdir -p $CARGO_TARGET_DIR $CARGO_HOME $npm_config_cache
cp /cargo-config /$CARGO_HOME/config
cargo build --target=aarch64-unknown-linux-gnu
cp $CARGO_TARGET_DIR/aarch64-unknown-linux-gnu/debug/audioserve /result

cd client
npm install
npm run build
mkdir -p /result/client
cp -av dist /result/client

exit 0
