section .data
    number_message db `Number is 0x%08X \n\0`
    sqrt_message   db `Square root is 0x%08X \n\0`

    test_message db `testing: %1.3lf\n\0`

    before_message db `Clock time before the computation is %d tics\n\0`
    after_message  db `Clock time after the computation is %d tics\n\0`

    time_message   db `Time required for computation is %d tics\n\0`
    CPU_message    db `Please enter the max frequency of your CPU (GHz): \0`

    execution_message db `\n\nThe execution time is %1.3lf nanosec.\n\n\0`

    invalid_message db `Invalid number found. Get another.\n\0`

    double_format db "%lf", 0
    

section .text

    extern printf
    extern scanf

    global Manager

    Manager:
        push rbp                        ;Epilogue
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

        loop:
            rdrand rax
            jnc loop
            mov r13, rax

            xor rax, rax
            mov rdi, number_message
            mov rsi, r13
            call printf

            call get_frequency
            mov r14, rax                    ;r14 will hold initial tics

            cvtsi2sd xmm1, r13

            sqrtsd xmm0, xmm1
            
            ucomisd xmm0, xmm0
            jp invalid_xmm

            cvtsd2si rax, xmm0
            mov r13, rax

            call get_frequency
            mov r15, rax                    ;r15 will hold final tics

        xor rax, rax
        mov rdi, sqrt_message
        mov rsi, r13

        call printf

        xor rax, rax
        mov rdi, before_message
        mov rsi, r14

        call printf

        xor rax, rax
        mov rdi, after_message
        mov rsi, r15

        call printf

        sub r15, r14

        xor rax, rax
        mov rdi, time_message
        mov rsi, r15

        call printf

        xor rax, rax
        mov rdi, CPU_message
        call printf

        xor rax, rax
        push r15                    ;to align stack
        push qword 0

        mov rdi, double_format
        mov rsi, rsp
        call scanf

        pop r12
        pop r15

        cvtsi2sd xmm0, r15              ;tics
        movq xmm1, r12                  ;max GHz

        divsd xmm0, xmm1

        movsd xmm15, xmm0           ;save xmm0

        mov rax, 1
        mov rdi, execution_message

        call printf
        
        movsd xmm0, xmm15            ;restore xmm0
    
        popf                            ;Prologue
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

invalid_xmm:
    xor rax, rax
    mov rdi, invalid_message

    call printf

    jmp loop

get_frequency:
    xor         rax, rax
    xor         rdx, rdx
    cpuid
    rdtsc
    shl         rdx, 32
    or          rax, rdx        ;answer is now in rax
    
    ret
    