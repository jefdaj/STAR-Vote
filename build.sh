#!/usr/bin/env bash

# TODO merge this all into one cabal/stack/nix project

# but for now, build each one individually
for d in append-only-bb star-{controller,crypto,keygen,terminal,types,util,voter-db}; do
  pushd $d
  while true; do stack build && break || sleep 10; done
  popd
done

# and add all of them to the PATH
export PATH=$(find append-only-bb star-* -type d -name bin | xargs realpath | while read d; do echo -n "${d}:"; done)$PATH

# check that it works
echo
echo "STAR-Vote binaries:"
for b in bbserver bbclient star-keygen star-terminal star-voter-db star-controller; do
  which $b
done
