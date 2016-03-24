.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	dmb	// SIGILL on CPUs below ARMv7

	mov	r0, #1
	ldr	r1, =msg
	mov	r2, #3
	mov	r7, #4	// syscall: write(r0, r1, r2)
	swi	0

	mov	r0, #0
	mov	r7, #1	// syscall: _exit(r0)
	swi	0
