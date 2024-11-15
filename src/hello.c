#include <stdio.h>

int main()
{
    // Change in the code to trigger the workflow
    printf("Hello, Podman CI!\n");
    // Workflow fails sucessfully if not returning 0 :)
    return -1;
}