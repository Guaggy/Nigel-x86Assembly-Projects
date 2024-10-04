#include <stdio.h>

extern "C" double Manage();

int main(void) {
    printf("\033[43mWelcome to my array by Nigel Brigstocke\n");

    double sum_of_array = Manage();
    printf("\033[43mThe main received this number: %2.1lf and will study it.\n", sum_of_array);
    printf("\033[43m0 will be returned to the operating system.\x1B[0m\n");

    return 0;
}