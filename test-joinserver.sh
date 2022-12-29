#!/bin/bash
echo running server and client...
cmake-build-debug/join_server --port 9000 & (cat ./datagen.sh | nc localhost 9000) && fg
sleep 7s
echo done, exiting
