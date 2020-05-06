#!/bin/bash

cd `dirname "$0"`

PRODUCTS="build/Build/Products/Release"
OUTPUT="/usr/local/bin"

xcodebuild -scheme "compile_ios" -configuration Release -derivedDataPath build build

if [ $? -eq 0 ]; then
    rm  "$OUTPUT/compile_ios" || true
    cp "$PRODUCTS/compile_ios" "$OUTPUT/"
    
    rm  "$OUTPUT/iosenv" || true
    cp "$PRODUCTS/iosenv" "$OUTPUT/"
    
    rm  "$OUTPUT/iosxcrun" || true
    cp "$PRODUCTS/iosxcrun" "$OUTPUT/"
    
    rm  "$OUTPUT/gfortran" || true
    cp "$PRODUCTS/gfortran" "$OUTPUT/"
fi
