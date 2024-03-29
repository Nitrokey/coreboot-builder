
COREBOOT_REF = novacustom_nv4x_adl_v1.7.2

coreboot/build/coreboot.rom: coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs-update
	
	cp blobs/nitropad-nv41/*.bin coreboot/
	cp blobs/common/bootsplash-1080.bmp coreboot/bootsplash.bmp
	cd coreboot && git checkout $(COREBOOT_REF)

	make -C coreboot CPUS=$(CPU_COUNT)

