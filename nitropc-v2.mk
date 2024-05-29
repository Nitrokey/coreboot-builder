
COREBOOT_REF = 4.22

coreboot/build/coreboot.rom: coreboot/bootsplash.jpg coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs-update
	rm coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/overridetree.cb
	cp devicetree-v2.cb coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/overridetree.cb
	cp gpio.c coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/gpio.c
	cp nitropc-v2-mainboard.c coreboot/src/mainboard/purism/librem_cnl/mainboard.c
	cp nitropc-v2-Kconfig coreboot/src/mainboard/purism/librem_cnl/Kconfig
	cp cmos.default coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/
	cp cmos.layout coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/
	cp blobs/nitropc/*	coreboot/
	cp -r blobs/common coreboot/common-blobs

# Run defconfig again after overriding mainbaord's Kconfig file
	make -C coreboot defconfig
	make -C coreboot CPUS=$(CPU_COUNT)

