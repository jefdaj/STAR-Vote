#!/usr/bin/env bash

# TODO get nix-build working, which will require updating the Arithmoi code

# ...but but for now, build each one individually with Stack
for d in append-only-bb star-*; do
  pushd $d
	while true; do stack build && break || sleep 10; done
	popd
done

# and add all of them to the PATH
export PATH=$(find append-only-bb star-* -type d -name bin | xargs realpath | while read d; do echo -n "${d}:"; done)$PATH
