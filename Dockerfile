FROM ubuntu:jammy AS buildenv
ARG apt_proxy
RUN { [ -n "$apt_proxy" ] && echo "Acquire::http::proxy \"$apt_proxy\";" >/etc/apt/apt.conf.d/02proxy; } || true
COPY sources.list /etc/apt/sources.list
RUN dpkg --add-architecture arm64 && \
        apt-get update || true
RUN apt-get install -y --no-install-recommends eatmydata
RUN eatmydata apt-get install -y --no-install-recommends \
                git ca-certificates \
                cargo \
                libstd-rust-dev:arm64 \
                gcc-aarch64-linux-gnu \
                pkg-config \
                libc6-dev-arm64-cross \
                libssl-dev \
                libssl-dev:arm64 \
                libavformat-dev:arm64 \
		npm
RUN rm -f /var/cache/apt/archives/*.deb
COPY cargo-config /cargo-config
COPY build.sh /
RUN chmod a+x /build.sh
CMD /build.sh

