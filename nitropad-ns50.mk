
COREBOOT_REF = novacustom_ns5x_adl_v1.6.0

coreboot/build/coreboot.rom: coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs-update
	
	cp blobs/nitropad-ns51/*.bin coreboot/
	cp blobs/common/bootsplash-1080.bmp coreboot/bootsplash.bmp
	cd coreboot && git checkout $(COREBOOT_REF)

	make -C coreboot CPUS=$(CPU_COUNT)

