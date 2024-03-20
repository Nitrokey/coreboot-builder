
COREBOOT_REF = 4.22

coreboot/build/coreboot.rom: coreboot/bootsplash.bmp coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs-update
	rm coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/overridetree.cb
	cp devicetree-v2.cb coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/overridetree.cb
	cp gpio.c coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/gpio.c
	cp cmos.default coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/
	cp cmos.layout coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/
	cp blobs/nitropc/*	coreboot/
	cp variant.asl coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/include/variant/acpi/
	cp -r blobs/common coreboot/common-blobs
	
	make -C coreboot CPUS=$(CPU_COUNT)

