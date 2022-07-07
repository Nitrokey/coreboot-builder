
COREBOOT_REF = 7f69d690d22efb4d0c9e79acd94bf138a3a81b47 
# ref: tags/4.16

coreboot/build/coreboot.rom: coreboot/bootsplash.bmp coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs-update
	cp blobs/nitrowall/vgabios.bin coreboot/
	cp blobs/nitrowall/vgabios.bin coreboot/vgabios_c0.bin
	cp blobs/nitrowall/fd.bin coreboot/
	cp blobs/nitrowall/me.bin coreboot/
	
	make -C coreboot CPUS=$(CPU_COUNT)

