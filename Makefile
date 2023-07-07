VERSION=$(shell git describe)
ARCHS=amd64 x32 i386 \
	win32 win64 \
	mips mipsel mipsn32 mipsn32el mips64 mips64el \
	illumos-amd64 \
	kfreebsd-amd64 kfreebsd-i386 \
	powerpc ppc64 ppc64el powerpcspe \
	s390x \
	arm64 arm64ilp32 \
	arm armel armhf \
	sh4 \
	m68k \
	sparc sparc64 \
	alpha \
	hppa \
	ia64 \
	riscv32 riscv64 \
	loong64 \
	arc \

X86=x86_64-linux-gnu
MIPS=mips-linux-gnu
POWERPC=powerpc-linux-gnu
ARM=arm-linux-gnueabihf
SPARC=sparc64-linux-gnu
-include config
all: $(ARCHS:%=arch-test-%)

clean:
	rm -f *.o arch-test-* core *.core

distclean: clean
	rm -f config

DESTDIR=
PREFIX=/usr/local
install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(DESTDIR)$(PREFIX)/lib/arch-test/
	sed -e "s|^HELPERS.*|HELPERS=$(PREFIX)/lib/arch-test/|;s&..git describe.&$(VERSION)&" \
		<arch-test >$(DESTDIR)$(PREFIX)/bin/arch-test
	chmod a+x $(DESTDIR)$(PREFIX)/bin/arch-test
	for x in $(ARCHS); do cp -p arch-test-$$x \
		$(DESTDIR)$(PREFIX)/lib/arch-test/$$x;done
	mkdir -p $(DESTDIR)$(PREFIX)/share/man/man1/
	install -p *.1 $(DESTDIR)$(PREFIX)/share/man/man1/
	install -p elf-arch $(DESTDIR)$(PREFIX)/bin/

arch-test-amd64: amd64.s
	$(X86)-as --64 $^ -o amd64.o
	$(X86)-ld -z noexecstack -melf_x86_64 -s amd64.o -o $@

arch-test-x32: x32.s
	$(X86)-as --x32 $^ -o x32.o
	$(X86)-ld -z noexecstack -melf32_x86_64 -s x32.o -o $@

arch-test-i386: i386.s
	$(X86)-as --32 $^ -o i386.o
	$(X86)-ld -z noexecstack -melf_i386 -s i386.o -o $@

arch-test-win32: win32.s
	i686-w64-mingw32-as $^ -o win32.o
	i686-w64-mingw32-ld -s win32.o -lkernel32 -o $@

arch-test-win64: win64.s
	x86_64-w64-mingw32-as $^ -o win64.o
	x86_64-w64-mingw32-ld -s win64.o -lkernel32 -o $@

arch-test-mips: mips.s
	$(MIPS)-as -32 -EB $^ -o mips.o
	$(MIPS)-ld -z noexecstack -melf32btsmip -s mips.o -o $@

arch-test-mipsel: mips.s
	$(MIPS)-as -32 -EL $^ -o mipsel.o
	$(MIPS)-ld -z noexecstack -melf32ltsmip -s mipsel.o -o $@

arch-test-mipsn32: mipsn32.s
	$(MIPS)-as -n32 -EB $^ -o mipsn32.o
	$(MIPS)-ld -z noexecstack -melf32btsmipn32 -s mipsn32.o -o $@

arch-test-mipsn32el: mipsn32.s
	$(MIPS)-as -n32 -EL $^ -o mipsn32el.o
	$(MIPS)-ld -z noexecstack -melf32ltsmipn32 -s mipsn32el.o -o $@

arch-test-mips64: mips64.s
	$(MIPS)-as -64 -EB $^ -o mips64.o
	$(MIPS)-ld -z noexecstack -melf64btsmip -s mips64.o -o $@

arch-test-mips64el: mips64.s
	$(MIPS)-as -64 -EL $^ -o mips64el.o
	$(MIPS)-ld -z noexecstack -melf64ltsmip -s mips64el.o -o $@

arch-test-illumos-amd64: solaris-amd64.s
	$(X86)-as --64 $^ -o illumos-amd64.o
	$(X86)-ld -z noexecstack -melf_x86_64 -s illumos-amd64.o -o $@

# same ABI as Solaris, save for branding.
arch-test-kfreebsd-amd64: solaris-amd64.s
	$(X86)-as --64 $^ -o kfreebsd-amd64.o
	$(X86)-ld -z noexecstack -melf_x86_64 -s kfreebsd-amd64.o -o $@
	# FreeBSD relies on "branding" of ELF files.
	printf '\t'|dd of=$@ bs=1 count=1 seek=7 conv=notrunc

arch-test-kfreebsd-i386: kfreebsd-i386.s
	$(X86)-as --32 $^ -o kfreebsd-i386.o
	$(X86)-ld -z noexecstack -melf_i386 -s kfreebsd-i386.o -o $@
	# FreeBSD relies on "branding" of ELF files.
	printf '\t'|dd of=$@ bs=1 count=1 seek=7 conv=notrunc

arch-test-powerpc: powerpc.s
	$(POWERPC)-as -a32 $^ -o powerpc.o
	$(POWERPC)-ld -z noexecstack -melf32ppc -s powerpc.o -o $@

arch-test-ppc64: ppc64.s
	$(POWERPC)-as -a64 $^ -o ppc64.o
	$(POWERPC)-ld -z noexecstack -melf64ppc -s ppc64.o -o $@

arch-test-ppc64el: ppc64el.s
	powerpc64le-linux-gnu-as -mpower8 $^ -o ppc64el.o
	powerpc64le-linux-gnu-ld -z noexecstack -s ppc64el.o -o $@

arch-test-powerpcspe: powerpcspe.s
	$(POWERPC)-as -a32 -me500 $^ -o powerpcspe.o
	$(POWERPC)-ld -z noexecstack -melf32ppc -s powerpcspe.o -o $@

arch-test-s390x: s390x.s
	s390x-linux-gnu-as $^ -o s390x.o
	s390x-linux-gnu-ld -z noexecstack -s s390x.o -o $@

arch-test-arm64: arm64.s
	aarch64-linux-gnu-as $^ -o arm64.o
	aarch64-linux-gnu-ld -z noexecstack -s arm64.o -o $@

arch-test-arm64ilp32: arm64.s
	aarch64-linux-gnu-as -mabi=ilp32 $^ -o arm64ilp32.o
	aarch64-linux-gnu-ld -z noexecstack -maarch64linux32 -s arm64ilp32.o -o $@

arch-test-arm: arm.oabi.s
	$(ARM)-as $^ -o arm.o
	$(ARM)-ld -z noexecstack -s arm.o -o $@

arch-test-armel: armel.s
	$(ARM)-as $^ -o armel.o
	$(ARM)-ld -z noexecstack -s armel.o -o $@

arch-test-armhf: armhf.s
	$(ARM)-as $^ -o armhf.o
	$(ARM)-ld -z noexecstack -s armhf.o -o $@

arch-test-sh4: sh4.s
	sh4-linux-gnu-as $^ -o sh4.o
	sh4-linux-gnu-ld -z noexecstack -s sh4.o -o $@

arch-test-m68k: m68k.s
	m68k-linux-gnu-as $^ -o m68k.o
	m68k-linux-gnu-ld -z noexecstack -s m68k.o -o $@

arch-test-sparc64: sparc64.s
	$(SPARC)-as --64 $^ -o sparc64.o
	$(SPARC)-ld -z noexecstack -melf64_sparc -s sparc64.o -o $@

arch-test-sparc: sparc.s
	$(SPARC)-as --32 $^ -o sparc.o
	$(SPARC)-ld -z noexecstack -melf32_sparc -s sparc.o -o $@

arch-test-alpha: alpha.s
	alpha-linux-gnu-as $^ -o alpha.o
	alpha-linux-gnu-ld -z noexecstack -s alpha.o -o $@

arch-test-hppa: hppa.s
	hppa-linux-gnu-as $^ -o hppa.o
	hppa-linux-gnu-ld -z noexecstack -s hppa.o -o $@

arch-test-ia64: ia64.s
	ia64-linux-gnu-as $^ -o ia64.o
	ia64-linux-gnu-ld -z noexecstack -s ia64.o -o $@

arch-test-riscv64: riscv64.s
	riscv64-linux-gnu-as $^ -o riscv64.o
	riscv64-linux-gnu-ld -z noexecstack -s riscv64.o -o $@

arch-test-loong64: loong64.s
	loongarch64-linux-gnu-as $^ -o loong64.o
	loongarch64-linux-gnu-ld -z noexecstack -s loong64.o -o $@

arch-test-arc: arc.s
	arc-linux-gnu-as $^ -o arc.o
	arc-linux-gnu-ld -z noexecstack -s arc.o -o $@

arch-test-riscv32: riscv32.s
	riscv32-linux-gnu-as $^ -o riscv32.o
	riscv32-linux-gnu-ld -z noexecstack -s riscv32.o -o $@
