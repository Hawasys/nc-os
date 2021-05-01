[org 0x7c00]

mov si, BOOT_MSG
call printf

mov [BOOT_DISK], dl
call READ_DISK

jmp PROTECTED_32BIT_MODE

%include "src/print.asm"
%include "src/disk.asm"
%include "src/gdt.asm"

PROTECTED_32BIT_MODE:
    call ENABLE_A20
    cli
    lgdt [GDT_DESCRIPTOR]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CODESEG:START_PROTECTED_MODE

ENABLE_A20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]
START_PROTECTED_MODE:
    mov ax, DATASEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
    mov [0xb8000], byte 'H'
    jmp SPACE

TEST_SUCCESS: db 'loaded success', 0
BOOT_MSG:db 'booting...', 0

times 510 - ( $ - $$ ) db 0 
dw 0xaa55
