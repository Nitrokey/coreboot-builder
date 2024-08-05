
COREBOOT_REF = novacustom_v56x_mtl_v0.9.0

coreboot/build/coreboot.rom: coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs-update

	cp blobs/nitropad-v56/*.bin coreboot/
	cp blobs/common/bootsplash-1080.bmp coreboot/bootsplash.bmp
	cd coreboot && git checkout $(COREBOOT_REF)

	make -C coreboot CPUS=$(CPU_COUNT)
