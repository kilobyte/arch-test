#include <unistd.h>

int main()
{
    write(1, "ok\n", 3);
    return 0;
}
