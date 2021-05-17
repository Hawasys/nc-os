PAGE_TABLE_ENTRY equ 0x1000
[bits 16]
PROTECTED_32BIT_MODE:
    call ENABLE_A20
    cli
    lgdt [GDT_DESCRIPTOR]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CODESEG:START_PROTECTED_MODE

%include "src/gdt.asm"

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
    call GET_CPU_ID
    call LONG_MODE_SUPPORT
    call SETUP_PAGING
    call GDT_EDIT
    jmp CODESEG:START_64BIT

GET_CPU_ID:
    pushfd
    pop eax
    
    mov ecx, eax
    xor eax, 1 << 21
    push eax
    popfd
    pushfd
    pop eax

    push ecx
    popfd
    xor eax, ecx
    jz NO_CPU_ID
    ret

LONG_MODE_SUPPORT:
    mov eax, 0x80000001
    cpuid
    test edx, 1 << 29
    jz NO_LONG_MODE
    ret

NO_LONG_MODE:
    hlt
NO_CPU_ID:
    hlt

SETUP_PAGING:
    mov edi, PAGE_TABLE_ENTRY
    mov cr3, edi
    
    mov dword [edi], 0x2003
    add edi, 0x1000 
    mov dword [edi], 0x3003
    add edi, 0x1000
    mov dword [edi], 0x4003
    add edi, 0x1000
    
    mov ebx, 0x00000003
    mov ecx, 512

    .set_entry:
        mov dword [edi], ebx
        add ebx, 0x1000
        add edi, 8
        loop .set_entry
    
    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax

    mov ecx, 0xC0000080
	rdmsr
	or eax, 1 << 8
	wrmsr
    
    mov eax, cr0
    or eax, 1 << 31
    mov cr0, eax

    ret
[bits 64]
[extern _start]
START_64BIT:
    mov edi, 0xb8000
	mov rax, 0x1f201f201f201f20
	mov ecx, 500
	rep stosq
    call _start
    jmp $



times 2048 - ( $ - $$ ) db 0

