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

# define VGA_MEM (uint_8 *)0xb8000
# define VGA_WIDTH (uint_16)80

void loop(){while(1){}}

void enable_cursor(uint_8 cursor_start, uint_8 cursor_end)
{
	outbyte(0x3D4, 0x0A);
	outbyte(0x3D5, (inbyte(0x3D5) & 0xC0) | cursor_start);
 
	outbyte(0x3D4, 0x0B);
	outbyte(0x3D5, (inbyte(0x3D5) & 0xE0) | cursor_end);
}

void disable_cursor()
{
	outbyte(0x3D4, 0x0A);
	outbyte(0x3D5, 0x20);
}

void move_cursor(int pos)
{
	outbyte(0x3D4, 0x0F);
	outbyte(0x3D5, (uint_8) (pos & 0xFF));
	outbyte(0x3D4, 0x0E);
	outbyte(0x3D5, (uint_8) ((pos >> 8) & 0xFF));
}

void move_cursor_xy(int x, int y)
{
	uint_16 pos = y * VGA_WIDTH + x;
 
	outbyte(0x3D4, 0x0F);
	outbyte(0x3D5, (uint_8) (pos & 0xFF));
	outbyte(0x3D4, 0x0E);
	outbyte(0x3D5, (uint_8) ((pos >> 8) & 0xFF));
}

uint_16 get_cursor_position(void)
{
    uint_16 pos = 0;
    outbyte(0x3D4, 0x0F);
    pos |= inbyte(0x3D5);
    outbyte(0x3D4, 0x0E);
    pos |= ((uint_16)inbyte(0x3D5)) << 8;
    return pos;
}

void write_string(enum vga_background_color bg, enum vga_foreground_color fg, const char *string)
{
    uint_16 position = get_cursor_position(); 
    while( *string != 0 )
    {
        switch (*string) 
        {
            case 10:
                position += VGA_WIDTH;
                string++;
                break;
            default:
                *( VGA_MEM + position*2 ) = *string++;
                *( VGA_MEM + position*2 + 1) = fg|bg;
                position++;
                break;
        }
    }
    move_cursor(position);
}
