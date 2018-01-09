.globl _start
.extern _GetStdHandle@4
.extern _WriteFile@20
.extern _ExitProcess@4

.data
msg:
	.ascii	"ok\n"
.text
_start:
	mov	%esp, %ebp
	sub	$4, %esp	# dummy variable

	push	$-11
	call	_GetStdHandle@4	# GetStdHandle(STD_OUTPUT_HANDLE)

	mov	%eax, %ebx
	push	$0
	lea	-4(%ebp), %eax
	push	%eax
	push	$3
	push	$msg
	push	%ebx
	call	_WriteFile@20	# WriteFile(stdout, msg, 3, &dummy, 0)

	push	$0
	call	_ExitProcess@4	# _ExitProcess(0)
