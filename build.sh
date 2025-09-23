# /bin/bash

set -e
set -x

[ -z "$CARGO_PROFILE" ] && CARGO_PROFILE=release
[ "$CARGO_PROFILE" = "debug" ] && CARGO_PROFILE=dev
CARGO_RESULT=release
[ "$CARGO_PROFILE" = "dev" ] && CARGO_RESULT=debug

#cd /src
cp -av /src /src.real
cd /src.real

export PKG_CONFIG_ALLOW_CROSS=1
export PKG_CONFIG_PATH=/usr/lib/aarch64-linux-gnu/pkgconfig
export CARGO_TARGET_DIR=/build/target
export CARGO_HOME=/build/cargo
export npm_config_cache=/build/npm

mkdir -p $CARGO_TARGET_DIR $CARGO_HOME $npm_config_cache
cp /cargo-config /$CARGO_HOME/config

if [ -e /fixups/script.sh ]; then
	bash /fixups/script.sh
fi

cargo build --target=aarch64-unknown-linux-gnu --profile ${CARGO_PROFILE}
cp $CARGO_TARGET_DIR/aarch64-unknown-linux-gnu/${CARGO_RESULT}/audioserve /result

#cd client
#npm --no-save install
#npm run build
#mkdir -p /result/client
#cp -av dist /result/client

chmod a+rX -R /build

exit 0
