.rodata
msg:	.ascii "ok\n"
.text
.globl _start
.section        ".opd","aw"
.align 3
_start:
.quad   ._start,.TOC.@tocbase,0
.previous

.global  ._start
._start:
	li	0, 4	# syscall write(r3, r4, r5)
	li	3, 1
	lis	4, msg@highest
	addi	4, 4, msg@higher
	rldicr	4, 4, 32, 31
	addis	4, 4, msg@h
	addi	4, 4, msg@l
	li	5, 3
	sc

	li	0, 1	# syscall _exit(r3)
	li	3, 0
	sc
