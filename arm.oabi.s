.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	mov	a1, #1
	ldr	a2, =msg
	mov	a3, #3
	swi	0x900004	// syscall: write(a1, a2, a3)

	mov	a1, #0
	swi	0x900001	// syscall: _exit(a1)
