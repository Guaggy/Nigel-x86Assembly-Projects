#!/bin/bash

nasm -f elf64 -g -F dwarf -o manage.o manage.asm
nasm -f elf64 -g -F dwarf -o input_array.o input_array.asm
nasm -f elf64 -g -F dwarf -o show_array.o show_array.asm
nasm -f elf64 -g -F dwarf -o rot_right.o rot_right.asm
nasm -f elf64 -g -F dwarf -o sum_array.o sum_array.asm

g++ -g -c -o main.o main.c
g++ -o main main.o show_array.o manage.o input_array.o rot_right.o sum_array.o -no-pie -lc

./main
