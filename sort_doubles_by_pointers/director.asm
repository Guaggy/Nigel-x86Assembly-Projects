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
;  Name: director.asm
;  Language: x86-64
;  Syntax: Intel
;  Assemble: nasm -f elf64 -g -F dwarf -o director.o director.asm
;  Purpose: set up an array of double pointers, fill it with inputarray, output
;  it with outputarray, sort it with sortarray, and output it again with
;  outputarray. Change the value at the inputted address to the size of the array
;  and return a pointer to the array of double pointers.


section .data
    ;initialize messages for printf
    explanation_format db `\x1B[44mThis program will sort all of your doubles.\x1B[0m\n\0`
    sort_format db `\x1b[44mThe array is now being sorted without moving numbers.\x1B[0m\n\0`
    ordered_format db `\x1b[44mThe data in the array are now ordered as follows:\x1B[0m\n\0`
    max_size equ 10
section .bss
    align 64
    storexdata resb 832

section .text
    global Direct

    extern printf
    extern inputarray
    extern outputarray
    extern sortarray
    extern malloc

Direct:
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

    mov rax, 7
    mov rdx, 0
    xsave [storexdata]

                                    ;store the address of inputted number in 
    mov r13, rdi                    ;nonvolatile r13 so we can change the actual value later.
    xor rax, rax
    mov rdi, explanation_format
    call printf

    mov rdi, 8 * max_size
    xor rax, rax
    call malloc
    mov r14, rax

    mov rsi, r14                    ;address to array of pointers
    mov rdi, max_size               ;max size is 10
    call inputarray                 ;scan floats from the user, put them into a double array,
                                    ;and make the array of pointers point to that double array
    
    mov r12, rax                    ;r12 now contains size of inputted array                    
    mov rsi, r12
    mov rdi, r14
    call outputarray                ;Print out doubles array of pointers points to

    mov rdi, sort_format
    xor rax, rax
    call printf                     ;Print sort format

    mov rsi, r12
    mov rdi, r14
    call sortarray                  ;Sort the array of pointers based on what they point to.
    
    mov rdi, ordered_format
    xor rax, rax
    call printf                     ;Print ordered format

    mov rsi, r12
    mov rdi, r14
    call outputarray                ;Print out the array sorted by doubles it point to

    mov [r13], r12                  ;The address in r13 now contains the length of the inputted array (change the size of "size" in main.cpp to the size of the inputted array)

    xrstor [storexdata]

    mov rax, r14      ;director will return the address of the array of pointers to doubles

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
