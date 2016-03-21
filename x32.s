.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	mov	$0x40000001, %rax	# syscall: write(rdi, rsi, rdx)
	mov	$1, %rdi
	mov	$msg, %rsi
	mov	$3, %rdx
	syscall

	mov	$0x4000003c, %rax	# syscall: _exit(rdi)
	xor	%rdi, %rdi
	syscall
