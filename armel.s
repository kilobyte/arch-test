.globl _start
.data
msg:	.ascii "nk\n" // first byte later amended to 'o'
.text
_start:
	ldr	r1, =msg
	mov	r0, #0x6f // 'o'
	swpb	r0, r0, [r1] // SIGILL on some arm64 without CONFIG_ARMV8_DEPRECATED

	mov	r0, #1
	mov	r2, #3
	mov	r7, #4	// syscall: write(r0, r1, r2)
	swi	0

	mov	r0, #0
	mov	r7, #1	// syscall: _exit(r0)
	swi	0
