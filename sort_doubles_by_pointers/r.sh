#!/bin/bash

nasm -f elf64 -g -F dwarf -o director.o director.asm
nasm -f elf64 -g -F dwarf -o inputarray.o inputarray.asm
nasm -f elf64 -g -F dwarf -o sortpointers.o sortpointers.asm

g++ -g -c -o main.o main.cpp
g++ -g -c -o outputarray.o outputarray.cpp
g++ -o main main.o outputarray.o sortpointers.o inputarray.o director.o -no-pie -lc

./main
