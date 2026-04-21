// crt0.S
    .section .init
    .globl _start
_start:
    la  sp, _stack_top

    // Zero .bss
    la  a0, __bss_start
    la  a1, __bss_end
1:
    bgeu a0, a1, 2f
    sw   x0, 0(a0)
    addi a0, a0, 4
    j    1b
2:
    // Call main()
    call main

// If main ever returns, park
halt:
    j halt

