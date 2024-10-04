/****************************************************************************************************************************
Program name: "Sort Doubles by Pointers".  This program demonstrates how to sort an array of double pointers.                *
Copyright (C) 2023  Nigel Brigstocke                                                                                       *
                                                                                                                           *
This file is part of the software program "Sort Doubles by Pointers".                                                       *                         
"Sort Doubles by Pointers" is free software: you can redistribute it and/or modify it under the terms of the GNU General    *
Public License version 3 as published by the Free Software Foundation.                                                     *
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
A copy of the GNU General Public License v3 has been distributed with this software.  If not found it is available here:   *
<https://www.gnu.org/licenses/>.   The copyright holder may be contacted here: nigelbrigstocke@csu.fullerton.edu           *
****************************************************************************************************************************




========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
Author information
  Author name: Nigel Brigstocke
  Author email: nigelbrigstocke@csu.fullerton.edu

Program information
  Program name: Sort Doubles by Pointers
  Programming languages: Modules in C++, modules in X86-64, and one module in Bash.
  Date program began: 2023-Oct-8
  Date of last update: 2023-Oct-8
  Files in this program: main.cpp, director.asm, inputarray.asm, outputarray.cpp, sortpointers.cpp, r.sh
  Status: This program was tested over a dozen times on Ubuntu (Oct 2023) without errors.
  Purpose: The intent of this program is to show how to sort an array of double pointers.

This file
  Name: main.cpp
  Language: C++
  Syntax: Intel
  Assemble: g++ -g -c -o main.o main.cpp
  Purpose: Welcome the user, call Direct to store the actual size
  of the inputted array in a variable, access the array of double pointers,
  and display that array while keeping the user informed of program details. */

#include <cstdio>
#include <cstdlib>

extern "C" double** Direct(int*);

int main(void) {
    int size;
    double* pointer_to_double_array_start;

    printf("\x1B[43mWelcome to a great program developed by Nigel Brigstocke\n");
    //Get an array of pointers and change the size of the size variable to the size of the array
    double** pointer_to_array_start = Direct(&size);

    //Print out the received array
    printf("\x1B[43mThe main function received this set of numbers:\n");
    for (int i = 0; i < size; i++) {
        printf("%2.2lf\n", *pointer_to_array_start[i]);
    }
    
    free(pointer_to_array_start[0]);
    free(pointer_to_array_start);
    
    printf("Main will keep these and send a zero to the operating system.\x1B[0m\n");
    
    return 0;
}
