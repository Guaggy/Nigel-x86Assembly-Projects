#!/bin/bash

nasm -f elf64 -g -F dwarf -o faraday.o faraday.asm

g++ -g -c -o main.o main.cpp
g++ -o main main.o faraday.o -no-pie -lc

./main
