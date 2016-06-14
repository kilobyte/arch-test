.rodata
msg:	.ascii "ok\n"
.text
.globl _start
_start:
	li	0, 1	# if not SPE but no SIGILL, we want r0=1 (_exit)
	li	3, 1	# ... with exit code 1
	li	4, 4
	efscfsi	0, 4	# f0 = r4 (4)
	efsctsi	0, 0	# r0 = f0

	# r0 will be 4	# syscall write(r3, r4, r5)
	li	3, 1
	lis	4, msg@ha
	addi	4, 4, msg@l
	li	5, 3
	sc

	li	0, 1	# syscall _exit(r3)
	li	3, 0
	sc
