FROM debian:10
RUN apt-get update && apt-get install -y \
	git build-essential gnat flex bison libncurses5-dev wget zlib1g-dev python2 nasm uuid-dev python
