# /bin/bash

set -e
set -x

[ -z "$CARGO_RELEASE" ] && CARGO_RELEASE=release
[ "$CARGO_RELEASE" = "debug" ] && CARGO_RELEASE=dev

cd /src

export PKG_CONFIG_ALLOW_CROSS=1
export CARGO_TARGET_DIR=/build/target
export CARGO_HOME=/build/cargo
export npm_config_cache=/build/npm

mkdir -p $CARGO_TARGET_DIR $CARGO_HOME $npm_config_cache
cp /cargo-config /$CARGO_HOME/config
cargo build --target=aarch64-unknown-linux-gnu --profile ${CARGO_RELEASE}
cp $CARGO_TARGET_DIR/aarch64-unknown-linux-gnu/${CARGO_RELEASE}/audioserve /result

cd client
npm --no-save install
npm run build
mkdir -p /result/client
cp -av dist /result/client

chmod a+rX -R /build

exit 0
