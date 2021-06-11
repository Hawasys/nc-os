READ_DISK:
    mov [DISK],dl
	mov ah, 0x2    ;read sectors
	mov al, 6      ;sectors to read
	mov ch, 0      ;cylinder idx
	mov dh, 0      ;head idx
	mov cl, 2      ;sector idx
	mov dl, [DISK] ;DISK idx
	mov bx, copy_target;target pointer
	int 0x13
    ret
