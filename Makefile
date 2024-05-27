
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
COREBOOT_DASHARO = https://github.com/Dasharo/coreboot.git

BLOBS_COMMIT = cba08e83d8bbd7d3470769afd7dbc8e61d6cd8b5

##
## switch mechanism for with or without docker 
##
DOCKER_RUN := docker run $(DOCKERUIDGID) --name $(CONTNAME) \
		--mount type=bind,source=$(SRCDIR),target=/build \
		$(CONTNAME)-img make -C /build

ifeq ($(SKIP_DOCKER),true)
	DOCKER_RUN := make
endif


all: 
	@echo "no default target"
	@echo "choose any of: "
	@echo "  nitropc, nitrowall, nitrowall-pro, nitropad-nv41, nitropad-ns50, nitropc-v2"

nitropc:
	$(MAKE) TARGET=nitropc firmware-nitropc.rom	
nitropc-v2:
	$(MAKE) TARGET=nitropc-v2 firmware-nitropc-v2.rom	
nitrowall:
	$(MAKE) TARGET=nitrowall firmware-nitrowall.rom	
nitrowall-pro:
	$(MAKE) TARGET=nitrowall-pro firmware-nitrowall-pro.rom	
nitropad-nv41:
	$(MAKE) TARGET=nitropad-nv41 firmware-nitropad-nv41.rom	
nitropad-ns50:
	$(MAKE) TARGET=nitropad-ns50 firmware-nitropad-ns50.rom	

coreboot/configs/defconfig: coreboot-update $(TARGET)-defconfig
	cp $(TARGET)-defconfig coreboot/configs/defconfig

-include $(TARGET).mk

firmware-$(TARGET).rom: raw_firmware.rom 
	cp raw_firmware.rom firmware-$(TARGET).rom
	# -> BUILD DONE

docker-image: Dockerfile
	docker build -t $(CONTNAME)-img .
	touch $@

docker-enter:
	-docker rm coreboot-builder
	docker run -it $(DOCKERUIDGUID) --name $(CONTNAME) \
		--mount type=bind,source=$(SRCDIR),target=/build \
		$(CONTNAME)-img bash

docker-run:
	-docker rm coreboot-builder
	docker run -it $(DOCKERUIDGUID) --name $(CONTNAME) \
		--mount type=bind,source=$(SRCDIR),target=/build \
		$(CONTNAME)-img $(CMD)


upload-docker-image:
	docker image tag $(CONTNAME)-img registry.git.nitrokey.com/nitrokey/coreboot-builder:latest
	docker login registry.git.nitrokey.com
	docker push registry.git.nitrokey.com/nitrokey/coreboot-builder:latest

blobs:
	git clone https://github.com/Nitrokey/firmware-blobs.git blobs
.PHONY: blobs-update
blobs-update: blobs
	cd blobs && git fetch
	cd blobs && git checkout $(BLOBS_COMMIT)

raw_firmware.rom: coreboot/configs/defconfig blobs-update

	make -C coreboot defconfig

	-docker rm coreboot-builder
	# for debug outputs:
	#$(DOCKER_RUN) TARGET=$(TARGET) V=1 coreboot/build/coreboot.rom 
	$(DOCKER_RUN) TARGET=$(TARGET) coreboot/build/coreboot.rom 

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
		git fetch dasharo --tags -f && \
		git fetch origin --tags -f && \
		git fetch origin 


.PHONY: coreboot-update
coreboot-update: coreboot
	cd coreboot && \
		git reset --hard && \
		git checkout $(COREBOOT_REF) 

distclean:
	make -C coreboot distclean

clean-all: clean
	rm -rf coreboot docker-image
	rm -rf blobs

clean:
	rm -f firmware.rom raw_firmware.rom firmware-*.rom
	rm -f run-build defconfig
	rm -rf coreboot blobs


