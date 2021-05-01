SPACE equ 0x7e00

READ_DISK:
    mov ah, 0x02
    mov bx, SPACE
    mov al, 4
    mov dl, [BOOT_DISK]
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02
    int 0x13
    jc DISK_READ_ERROR
    ret

BOOT_DISK: db 0

DISK_READ_ERROR_STR: db 'DISK READ ERROR', 0

DISK_READ_ERROR:
    mov si, DISK_READ_ERROR_STR
    call printf
    jmp $
