section .data
    output_double db `\x1B[42m%2.1lf \0`
    go_down_line db `\n\0`

section .text
    global output_array

    extern printf

output_array:
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

    mov r12, rdi                    ;r12 contains the array of floats
    mov r13, rsi                    ;r13 contains the size                  

    xor r14, r14                    ;zero out r14 so it can be the counter

output_loop:
    cmp r14, r13
    jge end_output

    movsd xmm0, [r12 + 8 * r14]
    mov rdi, output_double
    mov rax, 1
    call printf

    inc r14
    jmp output_loop

end_output:
    mov rdi, go_down_line
    xor rax, rax
    call printf

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
