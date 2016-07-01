.rdata
msg: .ascii "ok\n"
.text
.globl __start
__start:
	li	$4, 1
	la	$5, msg
	li	$6, 3
	li	$2, 6001	# write
	syscall
	move	$4, $0
	li	$2, 6058	# _exit
	syscall

	# <-- unreachable
	# exit gracefully on o32
	li	$4, 1
	li	$2, 4001
	syscall
