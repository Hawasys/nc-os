#include "std.c"
extern const char Test[];
void _start()
{
    move_cursor_xy(0, 0);
    write_string(VGA_BACKGROUND_RED, VGA_FOREGROUND_COLOR_WHITE, "astronaut 70:\nnw");
    clear_screen(VGA_BACKGROUND_BLACK);
    write_string(VGA_BACKGROUND_BLACK, VGA_FOREGROUND_COLOR_WHITE, Test);
    disable_cursor();
}
