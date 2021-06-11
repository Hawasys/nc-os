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

bits 32

edit_GDT:
	mov [GDT_CODE + 6], byte 10101111b

	mov [GDT_DATA + 6], byte 10101111b
	ret

bits 16
