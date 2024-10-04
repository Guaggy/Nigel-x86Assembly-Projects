section .data 
    explanation_format db `\x1B[44mThis program will sort all of your doubles.\x1B[0m\n\0`
    print_float db `%lf\n\0`
    print_size db `This is the size: %d\n\0`
    print_outer db `This is the outer counter: %d\n\0`
    print_inner db `This is the inner counter: %d\n\0`
    print_size_minus_outer db `This is the size minus 1 minus outer counter: %d\n\0`
    print_preswap db `This is xmm0 and xmm1: %lf %lf\n\0`

section .text
    global sortarray
    extern printf

    sortarray:
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
        
        mov r12, rdi            ;store address of array of double pointers
        mov r13, rsi            ;store size of array        
        xor r14, r14            ;store counter for outer loop of bubble sort

        xor rax, rax
        mov rdi, print_size
        mov rsi, r13
        call printf

    bubble_sort_outer_loop:
        dec r13
        cmp r14, r13
        inc r13
        je continue

        xor rax, rax
        mov rdi, print_outer
        mov rsi, r14
        call printf
        
        xor r15, r15      
        
    bubble_sort_inner_loop:
        xor rax, rax
        mov rdi, print_inner
        mov rsi, r15
        call printf
    
        sub r13, r14
        dec r13

        mov rdi, print_size_minus_outer
        mov rsi, r13
        xor rax, rax
        call printf
        
        cmp r15, r13
        je bubble_sort_outer_loop_end

        add r13, r14
        inc r13

        ;This is the code for my swap operation
        
        mov rax, [r12 + r15*8]
        movsd xmm0, [rax]
        
        mov r8, [r12 + r15*8 + 8]
        movsd xmm1, [r8]

        mov rdi, [r12 + r15*8]
        mov rsi, [r12 + r15*8 + 8]

        comisd xmm0, xmm1
        jnc swap

    bubble_sort_inner_loop_end:
        inc r15
        jmp bubble_sort_inner_loop

    bubble_sort_outer_loop_end:
        inc r14
        jmp bubble_sort_outer_loop

    continue:
    
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

    swap:
        mov r8, rdi
        mov r9, rsi

        mov r10, r8            ;hold temp value for swap
        mov [r8], r9
        mov [r9], r10

        mov rax, 2
        mov rdi, print_preswap
        call printf

        jmp bubble_sort_inner_loop_end
