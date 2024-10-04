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
  Name: outputarray.cpp
  Language: C++
  Syntax: Intel
  Assemble: g++ -g -c -o outputarray.o outputarray.cpp
  Purpose: Print out all of the pointed to doubles contained in the
  inputted array of double pointers.*/


#include <stdio.h>

extern "C" int outputarray(double** array_of_double_pointers, int size) {  
    //Print out values pointed to by array_of_double_pointers
    for (int i = 0; i < size; i++) {
        printf("\x1B[48;5;208m%2.8lf\n", *array_of_double_pointers[i]);
    }
    printf("End of output array.\x1B[0m\n");
    return size;
}
