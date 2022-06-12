podman run -v $PWD/src:/src:ro -v $PWD/build-cache:/build -v $PWD/result:/result audioserve-builder

build-cache is optional, will speed up repeated builds if you pass it in.
