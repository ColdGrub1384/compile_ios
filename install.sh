#!/bin/bash

cd `dirname "$0"`

PRODUCTS="build/Build/Products/Release"
OUTPUT="/usr/local/bin"

xcodebuild -scheme "compile_ios" -configuration Release -derivedDataPath build build

if [ $? -eq 0 ]; then
    cp "$PRODUCTS/compile_ios" "$OUTPUT/"
    cp "$PRODUCTS/iosenv" "$OUTPUT/"
    cp "$PRODUCTS/iosxcrun" "$OUTPUT/"
fi
