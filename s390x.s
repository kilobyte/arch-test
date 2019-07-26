.globl _start
.data
msg:    .ascii "ok\n"
.text
_start:
	basr	%r1, 0
base:
	la	%r2, base
	sr	%r1, %r2
	lhi	%r2, 1
	la	%r3, msg(%r1)
	lghi	%r4, 3
	svc	4

	xr	%r2, %r2
	svc	1
