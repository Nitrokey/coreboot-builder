
COREBOOT_REF = 0895a061d5fd356c0a951954d4714265bbbc04b8
#dasharo
#9f221f6566e7bd3d1170903a4211a0ecc39c564c 
# ref: tags/protectli_vault_kbl_v1.0.14

coreboot/build/coreboot.rom: coreboot/bootsplash.jpg coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs-update
	
	cp blobs/nitrowall-pro/*.bin coreboot/
	cd coreboot && \
		git checkout 71899c9fc9697435a1309db40cfd05f0180065eb -- payloads/external/SeaBIOS/Makefile
	# ref: tags/4.17

	make -C coreboot CPUS=$(CPU_COUNT)

