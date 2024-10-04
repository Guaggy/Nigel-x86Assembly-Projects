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
;  Name: sortpointers.asm
;  Language: x86-64
;  Syntax: Intel
;  Assemble: nasm -f elf64 -g -F dwarf -o sortpointers.o sortpointers.asm
;  Purpose: shift the pointers contained in the array of double pointers such that it is ordered by the doubles the array points to in increasing order.



section .text
    global sortarray

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

        cmp r13, 2
        jl end_sort             ;if there are less than 2 elements, it doesn’t need to be sorted
        
        xor r14, r14            ;store counter for outer loop of bubble sort, it starts at 0

    bubble_sort_outer_loop:
    
        mov r8, r13
        dec r8
    
        cmp r14, r8             ;End the loop if the outer counter is greater than or 
        jge end_sort            ;equal to the size - 1

        xor r15, r15            ;initialize the inner counter to 0
        
    bubble_sort_inner_loop:

        mov r8, r13
        dec r8
        sub r8, r14

        cmp r15, r8                          ;End the loop if the inner counter is greater
        jge bubble_sort_outer_loop_end       ;than or equal to size-outer_counter-1

        mov rax, [r12 + 8*r15]               ;Move the value at the current iteration into xmm0
        movsd xmm0, [rax]
        
        mov rax, [r12 + 8*r15 + 8]           ;Move the value directly after it to xmm1
        movsd xmm1, [rax]

        comisd xmm1, xmm0                    ;Determine if xmm1 is greater than xmm0
        jb swap                              ;if so, swap the addresses that hold them

    bubble_sort_inner_loop_end:

        inc r15
        jmp bubble_sort_inner_loop

    bubble_sort_outer_loop_end:
    
        inc r14
        jmp bubble_sort_outer_loop
    
    end_sort:
    
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
        mov r10, [r12]

        mov r8, [r10 + 8*r15]        ;temporarily store temp for swap operation
        mov r9, [r10 + 8*r15 + 8]
        
        mov [r10 + 8*r15], r9
        mov [r10 + 8*r15 + 8], r8

        jmp bubble_sort_inner_loop_end
