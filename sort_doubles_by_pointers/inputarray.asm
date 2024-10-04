;****************************************************************************************************************************
;Program name: "Sort Doubles by Pointers".  This program demonstrates how to sort an array of double pointers.                *
;Copyright (C) 2023  Nigel Brigstocke                                                                                       *
;                                                                                                                           *
;This file is part of the software program "Sort Doubles by Pointers".                                                       *                         
;"Sort Doubles by Pointers" is free software: you can redistribute it and/or modify it under the terms of the GNU General    *
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
;  Program name: Sort Doubles by Pointers
;  Programming languages: Modules in C++, modules in X86-64, and one module in Bash.
;  Date program began: 2023-Oct-8
;  Date of last update: 2023-Oct-8
;  Files in this program: main.cpp, director.asm, inputarray.asm, outputarray.cpp, sortpointers.cpp, r.sh
;  Status: This program was tested over a dozen times on Ubuntu (Oct 2023) without errors.
;  Purpose: The intent of this program is to show how to sort an array of double pointers.
;
;This file
;  Name: inputarray.asm
;  Language: x86-64
;  Syntax: Intel
;  Assemble: nasm -f elf64 -g -F dwarf -o inputarray.o inputarray.asm
;  Purpose: Set up a loop to fill an array with up to 10 doubles, then load the addresses of those doubles into and array of double pointers passed by director.asm

section .data
    ;initialize all messages for printf and format for scanf
    input_message db `\x1B[42mPlease enter floating point numbers separated by white space. After the last numeric input enter at least one more white space and press cntl+d.\x1B[0m\n\0`
    thank_for_inputting db `\x1B[42mThank you. You entered these numbers:\n\0`
    print_empty_line db "", 10, 0
    double_format db "%lf", 0

section .text
    extern printf
    extern scanf
    extern malloc
    global inputarray

inputarray:
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

    mov r14, rsi         ;r14 now holds address of array of pointers
    mov r15, rdi         ;r15 now holds the maximum amount of elements

    xor rax, rax
    mov rdi, input_message      ;print the input message
    call printf

    mov r10, 0          ;r10 now holds the counter of elements

    shl r15, 3
    mov rdi, r15
    shr r15, 3
    xor rax, rax
    call malloc
    mov r13, rax

inputloop:
    xor rax, rax
    push r10        ;save the value of r10 since it is volatile
    push qword 0
    mov rdi, double_format
    mov rsi, rsp
    call scanf
    pop r12
    pop r10         ;restore r10 to be the counter

    cdqe
    cmp rax, -1
    je inputend         ;if user entered ctrl + d, jump to the end of the loop

    movq xmm0, r12
    movq [r13 + 8*r10], xmm0    ;move inputted double into double array

    inc r10                 ;increment counter
    cmp r10, r15            ;check if counter has reached max
    je inputend

    jmp inputloop           ;go to start of loop
    
inputend:
    push r10
    push r10

    push r10        ;save the counter
    push r10        ;align stack
    xor rax, rax
    mov rdi, print_empty_line
    call printf
    pop r10         ;load counter
    pop r10         ;realign stack

    xor r9, r9      ;will store new counter

loadpointersintoarray:          ;loop through and add pointers to the float array to the array of double pointers.
    mov [r14], r13      
    inc r9

    cmp r9, r10
    je endinputarray            ;if you reach the number of inputted values, end the loop

    add r13, 8
    add r14, 8

    jmp loadpointersintoarray   ;jump to top of loop if it has not reached the number of inputted values

endinputarray:
    xor rax, rax
    mov rdi, thank_for_inputting
    call printf                     ;print the thank you message

    pop r10
    pop rax         ;move the counter into the return value

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

