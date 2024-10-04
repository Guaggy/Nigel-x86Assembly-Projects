nasm -f elf64 -g -F dwarf -o manager.o manager.asm

g++ -g -c -o main.o main.cpp
g++ -o main main.o manager.o -no-pie -lc

./main
