#!/bin/bash
# Install n64graphics for texture conversion
# Create a shortcut so #include <ultra64.h> works
mkdir -p include
ln -s ../tools/libreultra/include/PR include/PR
git clone https://github.com/n64decomp/n64graphics.git tools/n64graphics
make -C tools/n64graphics

# Grab the modern libultra headers (ModernN64SDK style)
git clone https://github.com/n64decomp/ultra.git include/PR

