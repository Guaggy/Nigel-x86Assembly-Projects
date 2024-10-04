section .text
    global sum_array

    extern printf

sum_array:
    push rbp                        ;Prologue
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    mov r12, rdi                    ;r12 contains array pointer
    mov r13, rsi                    ;r13 contains size
    xor r14, r14                    ;r14 contains counter

    xorpd xmm15, xmm15

sum_loop:
    cmp r14, r13
    jge end_sum

    addsd xmm15, [r12 + 8 * r14]

    movsd xmm0, xmm15

    inc r14
    jmp sum_loop

end_sum:
    movsd xmm0, xmm15

    popf                            ;Epilogue
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

    ret
