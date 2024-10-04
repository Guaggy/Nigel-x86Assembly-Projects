/*
****************************************************************************************************************************
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
;  Name: main.cpp
;  Language: C++
;  Assemble: g++ -g -c -o main.o main.cpp
;  Purpose: Welcome the user, call Faraday to prompt the user for necessary inputs, and print the results.




;**************************************************************************************

*/

#include <stdio.h>

extern "C" double Faraday();

int main(void) {
    //Welcome the user
    printf("\nWelcome to Majestic Power Systems, LLC\n");
    printf("Project Director, Sharon Winners, Senior Software Engineer.\n\n");

    double receivedNumber = Faraday();

    //Print the results
    printf("The main function received this number %.2f and will keep it for future study.\n", receivedNumber);
    printf("A zero will be returned to the operating system. Bye.\n\n");

    return 0;
}

