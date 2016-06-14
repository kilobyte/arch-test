.rodata
msg:	.ascii "ok\n"
.text
.globl _start
_start:
	fsel	0, 1, 2, 3	# boom on SPE

	li	0, 4	# syscall write(r3, r4, r5)
	li	3, 1
	lis	4, msg@ha
	addi	4, 4, msg@l
	li	5, 3
	sc

	li	0, 1	# syscall _exit(r3)
	li	3, 0
	sc
