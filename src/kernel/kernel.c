#include "std.c"

void _start()
{
    mv_cursor(position_xy(12, 3));
    write_string(12,"astronaut_8 space tester");
    loop();
}
