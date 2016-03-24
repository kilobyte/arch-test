.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	moveq.l	#1, %d1
	lea	msg, %a1
	move.l	%a1, %d2
	moveq.l	#3, %d3
	moveq.l	#4, %d0		| syscall: write(d1, d2, d3)
	trap	#0

	moveq.l	#0, %d1
	moveq.l	#1, %d0		| syscall: _exit(d1)
	trap	#0
