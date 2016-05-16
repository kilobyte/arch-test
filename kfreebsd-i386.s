.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	cmovz	%eax, %ebx	# 686 required as of Debian stretch

	pushl	$3
	pushl	$msg
	pushl	$1
	mov	$4, %eax	# syscall: write
	push	%eax
	int	$0x80
	add	$16, %esp	# pop 3 arguments + dummy * 4 bytes

	pushl	$0
	mov	$1, %eax	# syscall: _exit
	push	%eax
	int	$0x80
