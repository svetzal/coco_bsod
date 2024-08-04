import imageio.v3 as iio

img = iio.imread("Problem.png")
list = img.tolist()

with open("imgdata.asm", "w") as f:
    for r in range(0, len(list)):
        row = list[r]
        if r == 0:
            s = "IMGDATA FCB "
        else:
            s = "        FCB "
        bytes = []
        for pixel in range(0, len(row), 4):
            byte = 0
            for i in range(4):
                byte = byte << 2
                bit = row[pixel + i][0] == 255
                if bit:
                    tb = 2
                else:
                    tb = 0
                byte += tb
            bytes.append(byte)
        els = [f"${byte:02X}" for byte in bytes]
        s += ",".join(els) + "\n"
        f.write(s)
