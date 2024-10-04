section .data
    set_color_blue db `\033[44m\0`
    double_format db "%lf", 0

section .text
    global input_array

    extern scanf
    extern printf

input_array:
    push rbp        ;Prologue
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

    mov r12, rdi                  ;r12 now contains address of the array
    mov r13, rsi                  ;r13 holds max elements

    xor r15, r15                 ;r15 will be the counter for scanf

    mov rdi, set_color_blue
    xor rax, rax                      ;print input message
    call printf

    push r10                     ;to align stack for scanf

input_loop:
    cmp r15, r13
    jge end_input

    push qword 0
    mov rdi, double_format
    mov rsi, rsp
    xor rax, rax
    call scanf
    pop r14

    cdqe
    cmp rax, -1
    je end_input

    movq xmm0, r14
    movq [r12 + 8 * r15], xmm0

    inc r15

    jmp input_loop               ;go to start of loop

end_input:
    pop r10
    mov rax, r15                 ;return the size

    popf                         ;Epilogue
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
