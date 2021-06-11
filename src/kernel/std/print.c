#pragma once

const short color = 0x0f00;
short* vga = (short *)0xb8000;
short * cursorshift = 0;

void move_cursor(short * cursorshift, short * position)
{
    cursorshift = position;        
}

void shift_cursor(short * cursorshift, int shift)
{
    cursorshift = cursorshift + shift;
}

void cursor_xy(short * cursorshift, int x, int y)
{

}

unsigned int strlen(char* str)
{
    unsigned int length = 0;
    while (*str != 0)
    {
        str++;
        length++;
    }
    return length;
}
void write_to_memory(short * cursorshift, char* str)
{
    for(int i = 0; i < strlen(str); i++)
    {
        vga[(int)cursorshift+i] = color | str[i];
    }
    cursorshift=cursorshift+strlen(str);
}


