#!/usr/bin/env bash

sudo apt-get install llvm libsqlite3-dev zlib1g-dev python3-pip

# TODO merge this all into one cabal/stack/nix project

# but for now, build each one individually
for d in append-only-bb star-{controller,crypto,keygen,terminal,types,util,voter-db}; do
  pushd $d
  stack build
  popd
done

# and add all of them to the PATH
# export PATH=$(find append-only-bb star-* -type d -name bin | xargs realpath | while read d; do echo -n "${d}:"; done)$PATH

# check that it works
# echo
# echo "STAR-Vote binaries:"
# for b in bbserver bbclient star-keygen star-terminal star-voter-db star-controller; do
#   which $b
# done
# 
# for b in bbserver bbclient star-keygen star-terminal star-voter-db star-controller; do
#   cp $(which $b) ~/starvote/bin/
# done

pushd startup-script
pip3 install --user virtualenv
virtualenv .venv
source .venv/bin/activate
pip3 install -r requirements.txt
python3 startup.py
popd

# TODO have more than one of these?
# TODO remove delay?
# TODO any reason to have it here rather than in startup.py?
# sleep 1
# ./star-terminal/start.sh 8004
