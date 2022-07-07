
COREBOOT_REF = tags/4.13

coreboot/build/coreboot.rom: coreboot/bootsplash.bmp coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs-update
	rm coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/devicetree.cb 
	cp devicetree.cb coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/
	cp blobs/nitropc/*	coreboot/
	
	make -C coreboot CPUS=$(CPU_COUNT)

