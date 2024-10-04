;****************************************************************************************************************************
;Program name: "Faraday".  This program performs a calculation of the work done by a
;system based on prompts by the user. It has perfect error checking.                *
;Copyright (C) 2023  Nigel Brigstocke                                                                                       *
;                                                                                                                           *
;This file is part of the software program "Faraday".                                                       *                         
;"Faraday" is free software: you can redistribute it and/or modify it under the terms of the GNU General    *
;Public License version 3 as published by the Free Software Foundation.                                                     *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 has been distributed with this software.  If not found it is available here:   *
;<https://www.gnu.org/licenses/>.   The copyright holder may be contacted here: nigelbrigstocke@csu.fullerton.edu           *
;****************************************************************************************************************************
;
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Nigel Brigstocke
;  Author email: nigelbrigstocke@csu.fullerton.edu
;
;Program information
;  Program name: Faraday
;  Programming languages: 1 Module in C++, 1 module in X86-64, and one module in Bash.
;  Date program began: 2023-Nov-1
;  Date of last update: 2023-Nov-12
;  Files in this program: main.cpp, faraday.asm, r.sh
;  Status: This program was tested over a dozen times on Ubuntu (Nov 2023) without errors.
;  Purpose: The intent of this program is to perform a calculation of work done on a system based on user input with proper error checking.
;
;This file
;  Name: faraday.asm
;  Language: x86-64
;  Syntax: Intel
;  Assemble: nasm -f elf64 -g -F dwarf -o faraday.o faraday.asm
;  Purpose: Prompt the user for inputs necessary for calculation as well as name and
;  profession. Perform the calculation and return it. Uses proper error checking with
;  functions like Is_Float.




;**************************************************************************************


section .data

    ;initialize messages for printf
    
    prompt_name db `Please enter your name: \0`
    prompt_title db `Please enter your title or profession: \0`
    welcome_title db `\nWe always welcome a %s to our electrical lab.\n\0`

    prompt_voltage db `Please enter the voltage of the electrical system at your site (volts): \0`
    prompt_resistance db `Please enter the electrical resistance in the system at your site (ohms): \0`
    prompt_time db `Please enter the time your system was operating (seconds): \0`

    thank db `\nThank you %s. We at Majestic are pleased to inform you that your system performed %1.2lf joules of work.\n\0`
    congratulate db `\nCongratulations %s. Come back any time and make use of our software. Everyone with title %s is welcome to use our programs at a reduced price.\n\n\0`

    invalid db `\n\nAttention %s. Invalid inputs have been encountered. Please run the program again.\n\n\0`

section .bss

    store_num resb 64
    store_name resb 100
    store_title resb 100

section .text
    global Faraday
    extern printf
    extern fgets
    extern stdin
    extern scanf
    extern strlen
    extern atof

Faraday:
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

    ;Get the user's name and store it in store_name

    mov rax, 0
    mov rdi, prompt_name
    call printf

    mov rdi, store_name
    mov rsi, 100
    mov rdx, [stdin]
    xor rax, rax
    call fgets

    ;Remove the ws character from the end of store_name

    mov rax, 0
    mov rdi, store_name
    call strlen
    mov byte [store_name + rax - 1], byte 0

    ;Get the user's profession and store it in store_title

    mov rax, 0
    mov rdi, prompt_title
    call printf

    mov rdi, store_title
    mov rsi, 100
    mov rdx, [stdin]
    xor rax, rax
    call fgets

    ;Remove the ws character from the end of store_title

    mov rax, 0
    mov rdi, store_title
    call strlen
    mov byte [store_title + rax - 1], byte 0

    mov rax, 0
    mov rdi, welcome_title
    mov rsi, store_title
    call printf

    ;Get a float voltage string from the user and store it in store_num

    mov rax, 0
    mov rdi, prompt_voltage
    call printf

    mov rdi, store_num
    mov rsi, 64
    mov rdx, [stdin]
    xor rax, rax
    call fgets

    ;Remove the ws character from store_num

    mov rax, 0
    mov rdi, store_num
    call strlen
    mov byte [store_num + rax - 1], byte 0

    ;Check if the value in store_num is a valid float. If so, continue.
    ;Otherwise, inform the user and return a 0 to the driver

    call Is_Float
    cmp rax, 0
    je Bad_Input

    xor rax, rax
    mov rdi, store_num
    call atof

    movq xmm15, xmm0                ;xmm15 will store the voltage

    ;Get a float resistance string from the user and store it in store_num

    mov rax, 0
    mov rdi, prompt_resistance
    call printf

    mov rdi, store_num
    mov rsi, 64
    mov rdx, [stdin]
    xor rax, rax
    call fgets

    ;Get rid of the ws character at the end of store_num

    mov rax, 0
    mov rdi, store_num
    call strlen
    mov byte [store_num + rax - 1], byte 0

    ;If the resistance string is not a valid float, inform the user and return
    ;a 0 to the driver. Otherwise, continue.

    call Is_Float
    cmp rax, 0
    je Bad_Input

    xor rax, rax
    mov rdi, store_num
    call atof
    
    movq xmm14, xmm0                ;xmm14 will store the resistance

    ;Prompt the user for a float string of the system run time, and store it in store_num

    mov rax, 0
    mov rdi, prompt_time
    call printf

    mov rdi, store_num
    mov rsi, 64
    mov rdx, [stdin]
    xor rax, rax
    call fgets

    ;Remove the ws character at the end of store_num

    mov rax, 0
    mov rdi, store_num
    call strlen
    mov byte [store_num + rax - 1], byte 0

    ;If the time string in store_num is valid, convert it and continue. Otherwise,
    ;let the user know and return a 0 to the system.

    call Is_Float
    cmp rax, 0
    je Bad_Input

    xor rax, rax
    mov rdi, store_num
    call atof

    movq xmm13, xmm0                ;xmm13 will store the time the system was active

    ;Work in joules is ((V^2)/R)*T
    
    movq xmm0, xmm15
    mulsd xmm0, xmm15          ;V^2
    divsd xmm0, xmm14          ;/R
    mulsd xmm0, xmm13          ;*T
    movq xmm15, xmm0

    ;xmm0 and xmm15 now contains the work done on the system in joules.

    ;thank the user

    mov rax, 1
    mov rdi, thank
    mov rsi, store_title
    call printf

    ;congratulate the user

    mov rax, 0
    mov rdi, congratulate
    mov rsi, store_name
    mov rdx, store_title
    call printf
    
    movq xmm0, xmm15            ;re-set xmm0 to the value of work because of printf

Prologue:

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


Bad_Input: 

    ;If the input was bad, let the user know and return a 0 to the driver

    mov rax, 0
    mov rdi, invalid
    mov rsi, store_title
    call printf

    xorpd xmm0, xmm0

    jmp Prologue

Is_Float:

    ;check to see if the string in store_num is a number. If so, return 1.
    ;If it is not a number, return 0

    xor r15, r15            ;r15 will be the counter

    ;Check for leading plus or minus signs
    
    cmp byte [store_num] , '+'
    je increment_index
    
    cmp byte [store_num] , '-'
    jne continue_validation

increment_index:
    inc r15

continue_validation:

loop_before_point:

    ;Check for invalid characters before a decimal point and end of string.
    
    mov rax, 0
    xor rdi, rdi
    mov dil, byte [store_num + r15]
    call is_digit
       
    cmp rax, 0
    je is_it_decimal
       
    inc r15
    jmp loop_before_point

is_it_decimal:

    ;Upon first encountering a non digit character, check to see if it is
    ;either the end of the string or a decimal. If it is the end of the string,
    ;Is_Float will return true. If it is a decimal, continue to check after the
    ;decimal. Otherwise, return false.

    cmp byte [store_num + r15], 0
    je return_true

    cmp byte [store_num + r15], '.'
    jne return_false

after_point_loop:

    ;iterate through the loop after the decimal if there is a decimal.
    ;if there is an invalid character, Is_Float will return that it is not
    ;a float.

    inc r15
    mov rax, 0
    xor rdi, rdi
    mov dil, [store_num + r15]
    call is_digit
            
    cmp rax, 0
    jne after_point_loop

    cmp byte [store_num + r15], 0
    jne return_false
            
    mov rax, 1
    ret

is_digit:

    cmp dil, 0x30
    jl is_not_digit

    cmp dil, 0x39
    jg is_not_digit

    mov rax, 1                   ;if it is a digit, is_digit will return 1
    ret

is_not_digit:                    ;if it is not a digit, is_digit will return 0
    
    mov rax, 0
    ret

return_false:

    mov rax, 0
    ret

return_true:

    mov rax, 1
    ret
    