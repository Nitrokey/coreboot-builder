
##### docker env

BASEDIR=$(shell pwd)
CONTNAME=coreboot-builder
SRCDIR=$(BASEDIR)

DOCKERDIR=$(BASEDIR)
#DOCKERUIDGID=--user $(shell id -u):$(shell id -g)
DOCKERUIDGID=

firmware.rom: raw_firmware.rom 
	cp raw_firmware.rom firmware.rom
	#
	# -> BUILD DONE
	# 
	# you can now flash the firmware: 
	# $ ./flash.sh firmware.rom
	# 
	#

docker-image: Dockerfile
	docker build -t $(CONTNAME)-img .
	touch $@

raw_firmware.rom: docker-image
	-docker stop $(CONTNAME)
	-docker rm $(CONTNAME)
	docker run -i $(DOCKERUIDGID) --name $(CONTNAME) --mount type=bind,source=$(SRCDIR),target=/build $(CONTNAME)-img make -C /build coreboot/build/coreboot.rom
	cp coreboot/build/coreboot.rom raw_firmware.rom
	chmod 777 raw_firmware.rom

coreboot/build/coreboot.rom: coreboot/bootsplash.bmp coreboot/purism-blobs coreboot/configs/defconfig coreboot/util/crossgcc/xgcc
	make -C coreboot CPUS=14
	
coreboot/util/crossgcc/xgcc: coreboot
	make -C coreboot crossgcc-i386 CPUS=14

coreboot:
	git clone https://review.coreboot.org/coreboot coreboot
	cd coreboot && \
		git submodule update --init --checkout && \
		git checkout 4.13

coreboot/bootsplash.bmp: coreboot bootsplash.bmp
	cp bootsplash.bmp coreboot/

coreboot/purism-blobs: 
	rm -rf coreboot/purism-blobs
	mkdir -p coreboot
	git clone https://source.puri.sm/coreboot/purism-blobs.git coreboot/purism-blobs
	cd coreboot/purism-blobs &&  \
		git checkout 557176e7

coreboot/configs/defconfig: coreboot defconfig
	cp defconfig coreboot/configs/defconfig
	make -C coreboot defconfig

clean-all: clean
	rm -rf coreboot docker-image

clean:
	rm -f firmware.rom raw_firmware.rom
	rm -f run-build 


