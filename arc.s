.globl __start
.section .rodata
msg:	.ascii "ok\n"
.text
__start:
	mov_s r0, 1
	mov_s r1, msg
	mov_s r2, 3
	mov r8, 64
	trap_s	0		# syscall: write(r0, r1, r2)

	mov_s r0, 0
	mov r8, 93
	trap_s	0		# syscall: _exit(r0)
