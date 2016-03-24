.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	mov	1, %o0
	sethi	%hi(msg), %g1
	or	%g1, %lo(msg), %o1
	mov	3, %o2
	mov	4, %g1		! syscall: write(o0, o1, o2)
	t	0x10

	mov	0, %o0
	mov	1, %g1		! syscall: _exit(o0)
	t	0x10
