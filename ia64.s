.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	alloc   loc0 = ar.pfs,0,32,3,0

	mov	out0=1
	movl	out1=msg
	mov	out2=3
	mov	r15=1027
	break.i	0x100000		// syscall: write(out0, out1, out2)

	mov	out0=0
	mov	r15=1025
	break.i	0x100000		// syscall: _exit(out0)
