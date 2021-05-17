[org 0x7c00]

mov si, BOOT_MSG
call printf

mov [BOOT_DISK], dl
mov bp, 0x7c00
mov sp, bp
call READ_DISK

jmp 0x8000

%include "src/print.asm"
%include "src/disk.asm"

TEST_SUCCESS: db 'loaded success', 0
BOOT_MSG:db 'booting...', 0

times 510 - ( $ - $$ ) db 0 
dw 0xaa55
