
COREBOOT_REF = dasharo/protectli_vault_kbl_v1.0.14

coreboot/build/coreboot.rom: coreboot/bootsplash.jpg coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs-update
	
	cp blobs/nitrowall-pro/{fd,me,vgabios,vgabios2}.bin coreboot/
	cd coreboot && \
		git checkout tags/4.17 -- payloads/external/SeaBIOS/Makefile

	make -C coreboot CPUS=$(CPU_COUNT)

