.rodata
msg:	.ascii "ok\n"
.text
.globl _start
.align 3
_start:
	addis	2, 12, .TOC. - _start@ha
	addi	2, 2,  .TOC. - _start@l
.localentry _start, . -_start
	mtvsrd	0, 0	# trigger SIGILL on power7 CPUs

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
