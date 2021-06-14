#pragma once

void outbyte(uint_16 port, unsigned char val){
    asm volatile ("outb %0, %1":: "a"(val), "Nd"(port));
}

unsigned char inbyte(uint_16 port){
  unsigned char returnVal;
  asm volatile ("inb %1, %0" : "=a"(returnVal) : "Nd"(port));
  return returnVal;
}

