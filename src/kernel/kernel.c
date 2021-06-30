#include "std.c"

void _start()
{
    move_cursor_xy(12, 3);
    write_string(VGA_BACKGROUND_RED, VGA_FOREGROUND_COLOR_WHITE, "astronaut 59:\n new function tester");
    disable_cursor();
}
