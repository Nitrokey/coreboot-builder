

firmware.rom: coreboot/build/coreboot.rom
	cp coreboot/build/coreboot.rom firmware.rom
	# you can now flash the firmware: 
	# $ ./flash.sh firmware.rom

coreboot/build/coreboot.rom: coreboot/bootsplash.bmp coreboot/purism-blobs coreboot/configs/defconfig coreboot/util/crossgcc/xgcc
	make -C coreboot CPUS=14
	
coreboot/util/crossgcc/xgcc: coreboot
	make -C coreboot crossgcc CPUS=14

coreboot:
	git clone https://review.coreboot.org/coreboot coreboot
	cd coreboot && \
		git submodule update --init --checkout && \
		git checkout 4.13

coreboot/bootsplash.bmp: coreboot bootsplash.bmp
	cp bootsplash.bmp coreboot/

coreboot/purism-blobs: coreboot
	rm -rf coreboot/purism-blobs
	git clone https://source.puri.sm/coreboot/purism-blobs.git coreboot/purism-blobs
	cd coreboot/purism-blobs &&  \
		git checkout 557176e7

coreboot/configs/defconfig: coreboot defconfig
	cp defconfig coreboot/configs/defconfig
	make -C coreboot defconfig

clean:
	rm -rf coreboot
	rm -f firmware.rom
