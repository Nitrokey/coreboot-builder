
##### docker env

CPU_COUNT = $(shell nproc)
BASEDIR = $(shell pwd)

CONTNAME = coreboot-builder
SRCDIR = $(BASEDIR)

COREBOOT_REMOTE ?= https://review.coreboot.org/coreboot

DOCKERDIR = $(BASEDIR)
DOCKERUIDGID = --user $(shell id -u):$(shell id -g)
#DOCKERUIDGID=

COREBOOT_ORIGIN = https://review.coreboot.org/coreboot
COREBOOT_DASHARO = git@github.com:Dasharo/coreboot.git

all: 
	@echo "no default target"
	@echo "choose any of: "
	@echo "  nitropc, nitrowall, nitrowall-pro"

nitropc:
	$(MAKE) TARGET=nitropc firmware-nitropc.rom	
nitrowall:
	$(MAKE) TARGET=nitrowall firmware-nitrowall.rom	
nitrowall-pro:
	$(MAKE) TARGET=nitrowall-pro firmware-nitrowall-pro.rom	

coreboot/configs/defconfig: coreboot-update $(TARGET)-defconfig
	cp $(TARGET)-defconfig coreboot/configs/defconfig

-include mk.$(TARGET).inc

firmware-$(TARGET).rom: raw_firmware.rom 
	cp raw_firmware.rom firmware-$(TARGET).rom
	# -> BUILD DONE

docker-image: Dockerfile
	docker build -t $(CONTNAME)-img .
	touch $@

blobs:
	git clone https://github.com/Nitrokey/firmware-blobs.git blobs
.PHONY: blobs-update
blobs-update: blobs
	cd blobs && git pull

raw_firmware.rom: docker-image coreboot/configs/defconfig blobs-update

	make -C coreboot defconfig

	-docker stop $(CONTNAME)
	-docker rm $(CONTNAME)
	
	docker run -it $(DOCKERUIDGID) --name $(CONTNAME) \
		--mount type=bind,source=$(SRCDIR),target=/build \
		$(CONTNAME)-img \
		make -C /build TARGET=$(TARGET) coreboot/build/coreboot.rom 

	cp coreboot/build/coreboot.rom raw_firmware.rom
	
coreboot/util/crossgcc/xgcc: coreboot-update
	make -C coreboot crossgcc-i386 CPUS=$(CPU_COUNT)

coreboot/bootsplash.bmp: blobs/common/bootsplash.bmp coreboot-update blobs-update
	cp $< $@
coreboot/bootsplash.jpg: blobs/common/bootsplash.jpg coreboot-update blobs-update
	cp $< $@

coreboot:
	git clone $(COREBOOT_ORIGIN) coreboot
	cd coreboot && \
		git remote add dasharo $(COREBOOT_DASHARO) && \
		git fetch dasharo && \
		git fetch origin 


.PHONY: coreboot-update
coreboot-update: coreboot
	cd coreboot && \
		git reset --hard && \
		git checkout $(COREBOOT_REF) 

clean-all: clean
	rm -rf coreboot docker-image
	rm -rf blobs

clean:
	rm -f firmware.rom raw_firmware.rom firmware-*.rom
	rm -f run-build defconfig


