[org 0x7c00]

mov si, BOOT_MSG
call printf

mov [BOOT_DISK], dl
call READ_DISK
jmp SPACE

%include "src/print.asm"
%include "src/disk.asm"

BOOT_MSG:db 'booting...', 0

times 510 - ( $ - $$ ) db 0 
dw 0xaa55
