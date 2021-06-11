section .boot
bits 16

global boot
boot:
	mov ax, 0x2401
	int 0x15

	mov ax, 0x3
	int 0x10
    
    call READ_DISK

	cli
	lgdt [gdt_pointer]
	mov eax, cr0
	or eax,0x1
	mov cr0, eax
    jmp CODESEG:kernel_load

%include "src/gdt.asm"
%include "src/disk.asm"

times 510 - ($-$$) db 0
dw 0xaa55

copy_target:
bits 32

kernel_load:
    mov ax, DATASEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
    
    extern _start
	call _start
	cli
	hlt
    
section .bss
align 4
kernel_stack_bottom: equ $
	resb 16384 ; 16 KB
kernel_stack_top:
