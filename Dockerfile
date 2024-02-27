FROM debian:11
RUN apt-get update && apt-get install -y \
	git build-essential gnat flex bison libncurses5-dev wget zlib1g-dev python3 nasm uuid-dev python pkg-config imagemagick openssl libssl-dev curl python3-apt python3-distutils iasl nasm  python3-pip

RUN pip3 install -q uefi_firmware
