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

	# <-- unreachable on Solaris
	# hack: don't segfault on Linux, exit cleanly with code 1
	mov	$60, %rax       # Linux syscall: _exit(rdi)
	mov	$1, %rdi
	syscall
