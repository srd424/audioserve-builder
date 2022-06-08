podman run -v $PWD/build-cache:/target -v $PWD/result:/result -v $PWD/cargo-cache:/cargo audioserve-builder

build-cache and cargo-cache are optional, will speed up repeated builds if you pass them in.
