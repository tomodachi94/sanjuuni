#!/usr/bin/env bash
BIN="../sanjuuni"
rm -rf ./out
mkdir ./out

$BIN --input=./example.png --blit-image --output=./out/example.bimg && \
 # A timestamp gets saved in the BIMG format, which messes with the tests; we remove that here.
 sed -i '176d' ./out/example.bimg && \ 
 # The version sometimes changes, we should omit that
 sed -i '173d' ./out/example.bimg && \
 cmp ./control/example.bimg ./out/example.bimg || \
 echo "Test 'png-to-blit' failed"
$BIN --input=./example.png --lua --output=./out/example.lua && \
 cmp ./control/example.lua ./out/example.lua || \
 echo "Test 'png-to-lua' failed"
$BIN --input=./example.png --raw --output=./out/example.raw && \
 cmp ./control/example.raw ./out/example.raw || \
 echo "Test 'png-to-rawmode' failed"
