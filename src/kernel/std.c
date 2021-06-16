#pragma once
#include "typedef.c"
#include "io.c"

enum vga_foreground_color {
	VGA_FOREGROUND_COLOR_BLACK = 0x00,
	VGA_FOREGROUND_COLOR_BLUE = 0x01,
	VGA_FOREGROUND_COLOR_GREEN = 0x02,
	VGA_FOREGROUND_COLOR_CYAN = 0x03,
	VGA_FOREGROUND_COLOR_RED = 0x04,
	VGA_FOREGROUND_COLOR_MAGENTA = 0x05,
	VGA_FOREGROUND_COLOR_BROWN = 0x06,
	VGA_FOREGROUND_COLOR_LIGHT_GREY = 0x07,
	VGA_FOREGROUND_COLOR_DARK_GREY = 0x08,
	VGA_FOREGROUND_COLOR_LIGHT_BLUE = 0x09,
	VGA_FOREGROUND_COLOR_LIGHT_GREEN = 0x0a,
	VGA_FOREGROUND_COLOR_LIGHT_CYAN = 0x0b,
	VGA_FOREGROUND_COLOR_LIGHT_RED = 0x0c,
	VGA_FOREGROUND_COLOR_LIGHT_MAGENTA = 0x0d,
	VGA_FOREGROUND_COLOR_LIGHT_BROWN = 0x0e,
	VGA_FOREGROUND_COLOR_WHITE = 0x0f,
};

enum vga_background_color {
    VGA_BACKGROUND_BLACK = 0x00,
    VGA_BACKGROUND_BLUE = 0x10,
    VGA_BACKGROUND_GREEN = 0x20,
    VGA_BACKGROUND_CYAN = 0x30,
    VGA_BACKGROUND_RED = 0x40,
    VGA_BACKGROUND_MAGENTA = 0x50,
    VGA_BACKGROUND_BROWN = 0x60,
    VGA_BACKGROUND_LIGHTGRAY = 0x70,
    VGA_BACKGROUND_BLINKINGBLACK = 0x80,
    VGA_BACKGROUND_BLINKINGBLUE = 0x90,
    VGA_BACKGROUND_BLINKINGGREEN = 0xA0,
    VGA_BACKGROUND_BLINKINGCYAN = 0xB0,
    VGA_BACKGROUND_BLINKINGRED = 0xC0,
    VGA_BACKGROUND_BLINKINGMAGENTA = 0xD0,
    VGA_BACKGROUND_BLINKINGYELLOW = 0xE0,
    VGA_BACKGROUND_BLINKINGWHITE = 0xF0,
};

# define vga_mem (uint_8 *)0xb8000
# define vga_width 80

uint_16 cursorpos;

void loop(){while(1){}}

void mv_cursor(uint_16 position)
{
    outbyte(0x3d4, 0x0f);
    outbyte(0x3d5, (uint_8)(cursorpos & 0xff));
    outbyte(0x3d4, 0x0e);
    outbyte(0x3d5, (uint_8)((cursorpos >> 8) & 0xff));
    cursorpos = position;
}

uint_16 position_xy(uint_8 x, uint_8 y)
{
    return y*vga_width+x;
}

void write_string(enum vga_background_color bg, enum vga_foreground_color fg, const char *string)
{
    uint_16 position = cursorpos; 
    while( *string != 0 )
    {
        switch (*string) {
            case 10:
                position+= vga_width;
        }
        
        *( vga_mem + position*2 ) = *string++;
        *( vga_mem + position*2 + 1) = fg|bg;
        mv_cursor(position++);
    }
}

void clear_screen(int colour)
{
    for(short * i = (short *)0xb8000; i < (short *)0xb8001; i ++)
    {
        *(i) = 't';
        *(i+1) = colour;
    }
}
