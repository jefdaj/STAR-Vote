#!/usr/bin/env bash

sudo apt-get install llvm libsqlite3-dev zlib1g-dev python3-pip

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

rm -rf ~/starvote/*
mkdir -p ~/starvote/bin
for b in bbserver bbclient star-keygen star-terminal star-voter-db star-controller; do
  cp $(which $b) ~/starvote/bin/
done
# tree bin

# TODO how to add star-vote binaries to PATH here?
pushd startup-script
pip3 install --user virtualenv
virtualenv .venv
source .venv/bin/activate
pip3 install -r requirements.txt

# export PATH=$(find ../append-only-bb ../star-* -type d -name bin | xargs realpath | while read d; do echo -n "$(realpath $d):"; done)$PATH
PATH=$HOME/starvote/bin:$PATH python3 startup.py
