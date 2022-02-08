
##### docker env

BASEDIR=$(shell pwd)
CONTNAME=coreboot-builder
SRCDIR=$(BASEDIR)
COREBOOT_VERSION = 4.13

DOCKERDIR=$(BASEDIR)
#DOCKERUIDGID=--user $(shell id -u):$(shell id -g)
DOCKERUIDGID=

all: 
ifndef TARGET
	@echo "###############################################"
	@echo "Make sure you run make with TARGET=<yourtarget>"
	@echo "###############################################"
	@false
else
	make TARGET=$(TARGET) firmware-$(TARGET).rom	
endif

defconfig: $(TARGET)-defconfig
	cp $(TARGET)-defconfig defconfig


firmware-$(TARGET).rom: raw_firmware.rom 
	cp raw_firmware.rom firmware-$(TARGET).rom
	#
	# -> BUILD DONE
	# 
	# you can now flash the firmware: 
	# $ ./flash.sh firmware-$(TARGET).rom
	# 
	#

docker-image: Dockerfile
	docker build -t $(CONTNAME)-img .
	touch $@

blobs:
	git clone git@github.com:Nitrokey/firmware-blobs.git blobs

raw_firmware.rom: docker-image defconfig blobs
	-docker stop $(CONTNAME)
	-docker rm $(CONTNAME)
	docker run -i $(DOCKERUIDGID) --name $(CONTNAME) --mount type=bind,source=$(SRCDIR),target=/build $(CONTNAME)-img make -C /build TARGET=$(TARGET) coreboot/build/coreboot.rom 
	cp coreboot/build/coreboot.rom raw_firmware.rom
	chmod 777 raw_firmware.rom

coreboot/build/coreboot.rom: coreboot/bootsplash.bmp coreboot/purism-blobs coreboot/configs/defconfig coreboot/util/crossgcc/xgcc blobs

  # nitrowall
	mkdir -p coreboot/3rdparty/blobs/mainboard/protectli/vault_bsw/
	cp blobs/nitrowall/vgabios.bin coreboot/3rdparty/blobs/mainboard/protectli/vault_bsw/
	cp blobs/nitrowall/vgabios.bin coreboot/3rdparty/blobs/mainboard/protectli/vault_bsw/vgabios_c0.bin
	cp blobs/nitrowall/fd.bin coreboot/3rdparty/blobs/mainboard/protectli/vault_bsw/
	cp blobs/nitrowall/me.bin coreboot/3rdparty/blobs/mainboard/protectli/vault_bsw/

	# nitropc
	rm coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/devicetree.cb 
	cp devicetree.cb coreboot/src/mainboard/purism/librem_cnl/variants/librem_mini/

	make -C coreboot CPUS=14
	
coreboot/util/crossgcc/xgcc: coreboot
	make -C coreboot crossgcc-i386 CPUS=14

coreboot:
	git clone https://review.coreboot.org/coreboot coreboot
	cd coreboot && \
		git submodule update --init --checkout && \
		git checkout $(COREBOOT_VERSION)

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
	rm -rf blobs

clean:
	rm -f firmware.rom raw_firmware.rom firmware-nitrowall.rom firmware-nitropc.rom
	rm -f run-build 
	rm -f defconfig


