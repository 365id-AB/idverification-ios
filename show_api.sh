#!/bin/sh

trap ctrl_c INT

function ctrl_c() {
        echo "...stopping documentation server."
        kill $pid
}

cd docs
ln -s ./ idverification-ios || true
echo "Starting documenation server..."
python3 -m http.server &
pid=$!
open http://localhost:8000/idverification-ios/documentation/idverification365id/
lsof -p $pid +r 1 &>/dev/null