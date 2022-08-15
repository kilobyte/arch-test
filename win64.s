.globl _start
.extern GetStdHandle
.extern WriteFile
.extern ExitProcess

.data
msg:
	.ascii	"ok\n"
.text
_start:
	mov	%rsp, %rbp
	sub	$40, %rsp

	mov	$-11, %rcx	# STD_OUTPUT_HANDLE
	call	GetStdHandle

	sub	$8, %rsp	# make the stack 16-aligned for a 8-byte arg
	pushq	$0		# 0
	mov	%rbp, %r9	# &dummy
	mov	$3, %r8		# 3
	lea	msg(%rip), %rdx	# msg
	mov	%rax, %rcx	# stdout
	call	WriteFile
	# cleaning the stack is for wimps

	xor	%rcx, %rcx	# 0
	call	ExitProcess
