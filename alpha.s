.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	br	$27, 0
	ldgp	$gp, 0($27)

	ldil	$0, 4
	ldil	$16, 1
	lda	$17, msg
	ldil	$18, 3
	callsys

	clr	$16
	ldil	$0, 1
	callsys
