.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	mov	x0, #1
	adr	x1, msg
	mov	x2, #3
	mov	x8, 64		// syscall: write(x0, x1, x2)
	svc	0

	mov	x0, #0
	mov	x8, 93		// syscall: _exit(x0)
	svc	0
