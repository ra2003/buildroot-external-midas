#
# Copyright (C) 2010 Samsung Electronics Co., Ltd.
#              http://www.samsung.com/
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
####################################
if [ $# -lt 4 ]
then
    echo "usage: ./create_4412_sd_image.sh <fwbl1> <spl> <u-boot> <output file>"
    exit 1
fi

block_size=512
#sizes are multiplied by block_size
#512B empty header
reserved_size=1
#8kB
fwbl1_size=16
#16kB
bl2_size=32
#1024kB
uboot_size=2048

reserved_position=0
fwbl1_pos=$(($reserved_position + $reserved_size))
bl2_pos=$(($fwbl1_pos + $fwbl1_size))
uboot_pos=$(($bl2_pos + $bl2_size))

####################################
echo "Exynos4412 FWBL1 fusing"
dd if=$1 of=$4 bs=$block_size seek=$fwbl1_pos
####################################
echo "Exynos4412 BL2 fusing"
dd if=$2 of=$4 bs=$block_size seek=$bl2_pos
####################################
echo "Exynos4412 bootloader fusing"
dd if=$3 of=$4 bs=$block_size seek=$uboot_pos
####################################

#<Message Display>
echo "$4 - Exynos4412 U-Boot SD card image is ready."
