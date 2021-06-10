section .boot
bits 16

global boot
boot:
	mov ax, 0x2401
	int 0x15

	mov ax, 0x3
	int 0x10

	mov [DISK],dl

	mov ah, 0x2    ;read sectors
	mov al, 6      ;sectors to read
	mov ch, 0      ;cylinder idx
	mov dh, 0      ;head idx
	mov cl, 2      ;sector idx
	mov dl, [DISK] ;DISK idx
	mov bx, copy_target;target pointer
	int 0x13
	cli
	lgdt [gdt_pointer]
	mov eax, cr0
	or eax,0x1
	mov cr0, eax
    jmp CODESEG:kernel_load

GDT_START:
	dq 0x0
GDT_CODE:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0
GDT_DATA:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
GDT_END:
gdt_pointer:
	dw GDT_END - GDT_START
	dd GDT_START
DISK:
	db 0x0
CODESEG equ GDT_CODE - GDT_START
DATASEG equ GDT_DATA - GDT_START

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
	mov esp,kernel_stack_top
	extern _start
	call _start
	cli
	hlt

section .bss
align 4
kernel_stack_bottom: equ $
	resb 16384 ; 16 KB
kernel_stack_top:
