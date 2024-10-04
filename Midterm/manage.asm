section .data
    prompt_input db `\033[45mPlease enter floating point numbers separated by ws. After the last valid input enter one more ws followed by control+d.\n\0`
    show_array db `\033[45m\nThis is the array: \0`
    print_rotations db `\033[45mFunction rot_right was called %d times consecutively\n\0`

section .bss
    array_of_floats resq 10

section .text
    global Manage

    extern printf
    extern input_array
    extern output_array
    extern rot_right
    extern sum_array

    Manage:
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

    mov rdi, prompt_input
    xor rax, rax
    call printf

    mov rdi, array_of_floats
    mov rsi, 10                    ;max elements is 10
    
    call input_array            ;input the array of doubles into array_of_floats
    mov r12, rax                ;r12 now holds size of inputted array

    mov rdi, show_array
    xor rax, rax
    call printf                 ;print pre-show-array message

    mov rdi, array_of_floats
    mov rsi, r12                    ;input the size
    call output_array

    mov rdi, array_of_floats
    mov rsi, r12
    call rot_right                    ;rotate the loop once

    mov rdi, print_rotations
    mov rsi, 1
    xor rax, rax
    call printf

    mov rdi, show_array
    xor rax, rax
    call printf                 ;print pre-show-array message

    mov rdi, array_of_floats
    mov rsi, r12                    ;input the size
    call output_array
            
    mov r15, 3
    xor r13, r13                    ;r13 is the counter for the loop
rotate_loop_3:
    cmp r13, r15
    jge continue_manage

    mov rdi, array_of_floats
    mov rsi, r12
    call rot_right

    inc r13
    jmp rotate_loop_3

continue_manage:
    mov rdi, print_rotations
    mov rsi, r15
    xor rax, rax
    call printf

    mov rdi, show_array
    xor rax, rax
    call printf                 ;print pre-show-array message

    mov rdi, array_of_floats
    mov rsi, r12                    ;input the size
    call output_array

    mov r15, 2
    xor r13, r13                 ;zero out the counter
rotate_loop_2:
    cmp r13, r15
    jge continue_manage_again

    mov rdi, array_of_floats
    mov rsi, r12
    call rot_right

    inc r13
    jmp rotate_loop_2

continue_manage_again:
    mov rdi, print_rotations
    mov rsi, r15
    xor rax, rax
    call printf

    mov rdi, show_array
    xor rax, rax
    call printf                 ;print pre-show-array message

    mov rdi, array_of_floats
    mov rsi, r12                    ;input the size
    call output_array

    mov rdi, array_of_floats
    mov rsi, r12
    call sum_array                  ;will put sum in xmm0

    ;Can't use xsave and xrstor - we have to return a double!

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
    