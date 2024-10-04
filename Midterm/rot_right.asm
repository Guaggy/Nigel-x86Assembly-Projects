section .text
    global rot_right

    extern printf

rot_right:
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

    mov r12, rdi                         ;r12 contains address of array of doubles
    mov r13, rsi                         ;r13 contains the size of the array

    xor r14, r14                         ;r14 will act as the counter for the loop
    mov r15, [r12 + 8*r13 - 8]           ;r15 contains the last element

rotate_loop:
    cmp r14, r13
    jge end_rotate

    push r12
    shl r13, 3
    shl r14, 3

    add r12, r13
    sub r12, 8                           ;r12 is now the end of the array instead of the beginning
    
    sub r12, r14

    mov r9, r12                          ;r9 now contains address of current element
    
    sub r12, 8                           ;r12 is now second to current element

    mov r8, r12                          ;r8 now contains address of second to current element
    mov r8, [r8]                         ;r8 now contains second to current element

    mov [r9], r8

    shr r14, 3
    shr r13, 3                           ;reset r12 and r13
    pop r12

    inc r14
    
    jmp rotate_loop

end_rotate:
    mov [r12], r15                       ;First element is now the last element

    popf            ;Epilogue
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
    