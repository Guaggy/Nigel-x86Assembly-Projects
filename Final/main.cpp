#include <cstdio>

extern "C" double Manager();

int main() {
    printf("This is Square Root Benchmark by Nigel Brigstocke\n\n");

    double nanoseconds = Manager();
    printf("The driver program received this number %.3f and will investigate it.\n", nanoseconds);
    printf("Have a great winter fiesta after finals week.\n");
    printf("A zero will be returned to the operating system.\n\n");

    return 0;
}
