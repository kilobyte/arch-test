.globl _start
.section .rodata
msg:	.ascii "ok\n"
.text
_start:
	li a0, 1
	lui a1,      %hi(msg)
	addi a1, a1, %lo(msg)
	li a2, 3
	li a7, 64
	scall			# syscall: write(a0, a1, a2)

	li a0, 0
	li a7, 93
	scall			# syscall: _exit(a0)
