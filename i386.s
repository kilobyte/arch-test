.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	cmovz	%eax, %ebx	# 686 required as of Debian stretch
	lfence			# SSE2 required as of Debian forky

	movl	$4, %eax	# syscall: write(ebx, ecx, edx)
	movl	$1, %ebx
	movl	$msg, %ecx
	movl	$3, %edx
	int	$0x80

	xorl	%eax, %eax
	incl	%eax		# syscall: _exit(bl)
	xorb	%bl, %bl
	int	$0x80
