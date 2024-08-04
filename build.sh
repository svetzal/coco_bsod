#!/bin/zsh

TARGET=output
DISK_FILENAME=BSOD.BIN
BINARY=$TARGET/$DISK_FILENAME
DISK_IMAGE=$TARGET/bsod.dsk

if [ ! -d $TARGET ]; then
    mkdir $TARGET
fi

if [ -f $DISK_IMAGE ]; then
    rm $DISK_IMAGE
fi

lwasm --format=decb source.asm -o$BINARY

decb dskini -3 -n $DISK_IMAGE
decb copy -2 -b $BINARY $DISK_IMAGE,$DISK_FILENAME

