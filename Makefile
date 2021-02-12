
##### docker env

BASEDIR=$(shell pwd)
CONTNAME=coreboot-builder
SRCDIR=$(BASEDIR)

DOCKERDIR=$(BASEDIR)
#DOCKERUIDGID=--user $(shell id -u):$(shell id -g)
DOCKERUIDGID=

run-build: docker-image
	-docker stop $(CONTNAME)
	-docker rm $(CONTNAME)
	docker run -ti $(DOCKERUIDGID) --name $(CONTNAME) --mount type=bind,source=$(SRCDIR),target=/build $(CONTNAME)-img make -C /build firmware.rom

docker-image: Dockerfile
	docker build -t $(CONTNAME)-img .
	touch $@




firmware.rom: coreboot/build/coreboot.rom
	cp coreboot/build/coreboot.rom firmware.rom
	chmod 777 firmware.rom
	#
	# -> BUILD DONE
	# 
	# you can now flash the firmware: 
	# $ ./flash.sh firmware.rom
	# 
	#

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

coreboot/purism-blobs: 
	rm -rf coreboot/purism-blobs
	mkdir -p coreboot
	git clone https://source.puri.sm/coreboot/purism-blobs.git coreboot/purism-blobs
	cd coreboot/purism-blobs &&  \
		git checkout 557176e7

coreboot/configs/defconfig: coreboot defconfig
	cp defconfig coreboot/configs/defconfig
	make -C coreboot defconfig

clean:
	rm -rf coreboot
	rm -f firmware.rom


