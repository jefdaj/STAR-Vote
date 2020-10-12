#!/usr/bin/env bash

# TODO get nix-build working, which will require updating the Arithmoi code

dirs="append-only-bb star-controller star-crypto star-keygen star-terminal star-types star-util star-voter-db"

# ...but but for now, build each one individually with Stack
for d in $dirs; do
  pushd $d
	while true; do stack build && break || sleep 10; done
	popd
done

# and add all of them to the PATH
export PATH=$(find $dirs -type d -name bin | xargs realpath | while read d; do echo -n "${d}:"; done)$PATH
