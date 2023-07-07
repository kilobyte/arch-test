.globl _start
.section .rodata
msg:    .ascii  "ok\n"
.text
_start:
        li a0, 1
        la a1,     msg
        li a2, 3
        li a7, 64
        ecall                   # syscall: write(a0, a1, a2)

        li a0, 0
        li a7, 93
        ecall                   # syscall: _exit(a0)
