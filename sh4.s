.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	mov	#4, r3		! syscall: write(r4, r5, r6)
	mov	#1, r4
	mov.l	msg_ptr, r5
	mov	#3, r6
	trapa	#0x11		! 1-argument syscall

	mov	#1, r3		! syscall: _exit(r4)
	mov	#0, r4
	trapa	#0x13		! 3-argument syscall
msg_ptr: .long msg
