FROM ubuntu:jammy AS buildenv
COPY sources.list /etc/apt/sources.list
RUN dpkg --add-architecture arm64 && \
        apt-get update || true
RUN apt-get install -y --no-install-recommends \
                git ca-certificates \
                cargo \
                libstd-rust-dev:arm64 \
                gcc-aarch64-linux-gnu \
                pkg-config \
                libc6-dev-arm64-cross \
                libssl-dev \
                libssl-dev:arm64 \
                libavformat-dev:arm64
RUN rm -f /var/cache/apt/archives/*.deb

FROM buildenv AS build
WORKDIR /
RUN git clone https://github.com/izderadicka/audioserve.git
WORKDIR /audioserve
ARG PKG_CONFIG_ALLOW_CROSS=1
RUN mkdir /root/.cargo
COPY cargo-config /root/.cargo/config
RUN cargo build --target=aarch64-unknown-linux-gnu

FROM scratch AS result
COPY --from=build /audioserve/target/aarch64-unknown-linux-gnu/debug/audioserve /
