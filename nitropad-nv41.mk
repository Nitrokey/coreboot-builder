
COREBOOT_REF = novacustom_nv4x_adl_v1.4.0 

coreboot/build/coreboot.rom: coreboot/bootsplash.jpg coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs-update
	
	cp blobs/nitropad-nv41/*.bin coreboot/
	cp blobs/common/bootsplash-1080.bmp coreboot/bootsplash.bmp
	cd coreboot && git checkout $(COREBOOT_REF)

	make -C coreboot CPUS=$(CPU_COUNT)

