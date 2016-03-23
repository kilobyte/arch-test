.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	mov	$3, %rdx
	mov	$msg, %rsi
	mov	$1, %rdi
	mov	$4, %eax	# syscall: write(rdi, rsi, rdx)
	syscall

	mov	$01, %eax	# syscall: _exit(rdi)
	xor	%rdi, %rdi
	syscall
