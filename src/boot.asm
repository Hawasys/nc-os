[org 0x7c00]
[bits 16]

mov si, BOOT_MSG
call printf

mov [BOOT_DISK], dl
call READ_DISK
jmp $

%include "print.asm"
%include "disk.asm"

BOOT_MSG:db 'booting...', 0

times 510 - ( $ - $$ ) db 0 
dw 0xaa55
