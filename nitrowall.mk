
COREBOOT_REF = 4.22
# 6c05f0de191afb35781896da00473dc24e048e48
# 0895a061d5fd356c0a951954d4714265bbbc04b8
# 7f69d690d22efb4d0c9e79acd94bf138a3a81b47 
# ref: tags/4.16

coreboot/build/coreboot.rom: coreboot/bootsplash.bmp coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs-update
	cp blobs/nitrowall/vgabios.bin coreboot/
	cp blobs/nitrowall/vgabios.bin coreboot/vgabios_c0.bin
	cp blobs/nitrowall/fd.bin coreboot/
	cp blobs/nitrowall/me.bin coreboot/
	
	make -C coreboot CPUS=$(CPU_COUNT)

