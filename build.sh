lwasm --format=decb source.asm -oBSOD.BIN

rm bsod.dsk
decb dskini -3 -n bsod.dsk
decb copy -2 -b BSOD.BIN bsod.dsk,BSOD.BIN

