#pragma once
#include "typedef.c"
#include "io.c"

# define vga_mem (uint_16 *)0xb8000
# define vga_width 80

uint_16 cursorpos = 0;

void loop(){while(1){}}

void mv_cursor(uint_16 position)
{
    outbyte(0x3d4, 0x0f);
    outbyte(0x3d5, (uint_8)(position & 0xff));
    outbyte(0x3d4, 0x0e);
    outbyte(0x3d5, (uint_8)((position >> 8) & 0xff));
    cursorpos = position;
}

uint_16 position_xy(uint_8 x, uint_8 y)
{
    return y*vga_width+x;
}

void write_string(int colour, const char *string)
{
    uint_16 position = cursorpos;
    uint_8 *video = (uint_8*)(0xB8000)+position*2;
    while( *string != 0 )
    {
        *video++ = *string++;
        *video++ = colour;
        position++;
    }
    mv_cursor(position);
}
