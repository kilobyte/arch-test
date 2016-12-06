.globl _start
.data
msg:	.ascii "ok\n"
.text
_start:
	ldi	1, %r26
	ldil	L'msg, %r25
	ldo	R'msg(%r25), %r25
	ldi	3, %r24
	ble	0x100(%sr2,%r0)
	ldi	4, %r20			; syscall: write(r26, r25, r24)

	ldi	0, %r26
	ble	0x100(%sr2,%r0)
	ldi	1, %r20			; syscall: _exit(r26)
