.globl _start
.section .rodata
msg:	.ascii "ok\n"
.text
_start:
	li.w $a0, 1
	la $a1, msg
	li.w $a2, 3
	li.w $a7, 64
	syscall 0		# syscall: write(a0, a1, a2)

	li.w $a0, 0
	li.w $a7, 93
	syscall 0		# syscall: _exit(a0)
