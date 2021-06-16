#include "std.c"

void _start()
{
    clear_screen(14);
    mv_cursor(position_xy(12, 3));
    write_string(VGA_BACKGROUND_RED, VGA_FOREGROUND_COLOR_WHITE, "astronaut_42 \n new line tester");
}
