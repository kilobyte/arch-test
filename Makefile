ARCHS=amd64 x32 i386 \
	win32 win64 \
	mips mipsel mips64 mips64el \
	illumos-amd64 \
	powerpc ppc64 ppc64el \
	s390x \
	arm64 arm armel armhf \
	sh4 \
	m68k \
	sparc sparc64
all: $(ARCHS:%=arch-detect-%)

clean:
	rm -f *.o arch-detect-* core *.core

DESTDIR=
PREFIX=/usr/local
install: all
	mkdir -p $(DESTDIR)$(PREFIX)/lib/arch-detect/
	sed -e "s|^HELPERS.*|HELPERS=$(PREFIX)/lib/arch-detect/|" \
		<arch-detect >$(DESTDIR)$(PREFIX)/bin/arch-detect
	chmod a+x $(DESTDIR)$(PREFIX)/bin/arch-detect
	for x in $(ARCHS); do cp -p arch-detect-$$x \
		$(DESTDIR)$(PREFIX)/lib/arch-detect/$$x;done
	mkdir -p $(DESTDIR)$(PREFIX)/share/man/man1/
	install -p *.1 $(DESTDIR)$(PREFIX)/share/man/man1/

arch-detect-amd64: amd64.s
	x86_64-linux-gnu-as $^ -o amd64.o
	x86_64-linux-gnu-ld -s amd64.o -o $@

arch-detect-x32: x32.s
	x86_64-linux-gnu-as --x32 $^ -o x32.o
	x86_64-linux-gnu-ld -melf32_x86_64 -s x32.o -o $@

arch-detect-i386: i386.s
	x86_64-linux-gnu-as --32 $^ -o i386.o
	x86_64-linux-gnu-ld -melf_i386 -s i386.o -o $@

arch-detect-win32: generic.c
	i686-w64-mingw32-gcc $^ -s -o $@

arch-detect-win64: generic.c
	x86_64-w64-mingw32-gcc $^ -s -o $@

arch-detect-mips: mips.s
	mips-linux-gnu-as -32 -EB $^ -o mips.o
	mips-linux-gnu-ld -melf32btsmip -s mips.o -o $@

arch-detect-mipsel: mips.s
	mips-linux-gnu-as -32 -EL $^ -o mipsel.o
	mips-linux-gnu-ld -melf32ltsmip -s mipsel.o -o $@

arch-detect-mips64: mips64.s
	mips-linux-gnu-as -64 -EB $^ -o mips64.o
	mips-linux-gnu-ld -melf64btsmip -s mips64.o -o $@

arch-detect-mips64el: mips64.s
	mips-linux-gnu-as -64 -EL $^ -o mips64el.o
	mips-linux-gnu-ld -melf64ltsmip -s mips64el.o -o $@

arch-detect-illumos-amd64: solaris-amd64.s
	x86_64-linux-gnu-as $^ -o illumos-amd64.o
	x86_64-linux-gnu-ld -s illumos-amd64.o -o $@

arch-detect-powerpc: powerpc.s
	powerpc-linux-gnu-as $^ -o powerpc.o
	powerpc-linux-gnu-ld -s powerpc.o -o $@

arch-detect-ppc64: ppc64.s
	powerpc-linux-gnu-as -a64 $^ -o ppc64.o
	powerpc-linux-gnu-ld -melf64ppc -s ppc64.o -o $@

arch-detect-ppc64el: ppc64el.s
	powerpc64le-linux-gnu-as -mpower8 $^ -o ppc64el.o
	powerpc64le-linux-gnu-ld -s ppc64el.o -o $@

arch-detect-s390x: s390x.s
	s390x-linux-gnu-as $^ -o s390x.o
	s390x-linux-gnu-ld -s s390x.o -o $@

arch-detect-arm64: arm64.s
	aarch64-linux-gnu-as $^ -o arm64.o
	aarch64-linux-gnu-ld -s arm64.o -o $@

arch-detect-arm: arm.oabi.s
	arm-linux-gnueabihf-as $^ -o arm.o
	arm-linux-gnueabihf-ld -s arm.o -o $@

arch-detect-armel: arm.eabi.s
	arm-linux-gnueabihf-as $^ -o armel.o
	arm-linux-gnueabihf-ld -s armel.o -o $@

arch-detect-armhf: armhf.s
	arm-linux-gnueabihf-as $^ -o armhf.o
	arm-linux-gnueabihf-ld -s armhf.o -o $@

arch-detect-sh4: sh4.s
	sh4-linux-gnu-as $^ -o sh4.o
	sh4-linux-gnu-ld -s sh4.o -o $@

arch-detect-m68k: m68k.s
	m68k-linux-gnu-as $^ -o m68k.o
	m68k-linux-gnu-ld -s m68k.o -o $@

arch-detect-sparc64: sparc64.s
	sparc64-linux-gnu-as $^ -o sparc64.o
	sparc64-linux-gnu-ld -s sparc64.o -o $@

arch-detect-sparc: sparc.s
	sparc64-linux-gnu-as --32 $^ -o sparc.o
	sparc64-linux-gnu-ld -melf32_sparc -s sparc.o -o $@
