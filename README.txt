podman run -e CARGO_RELEASE=<profile> -v <src-dir>:/src:ro -v <build-cache-dir>:/build -v <result-dir>/result:/result audioserve-builder

CARGO_RELEASE defaults to 'release', pass 'dev' or 'debug' for a normal (and faster) development build.
<build-cache-dir> is optional, will speed up repeated builds if you pass it in.
