GDT_NULLDESC:
    dd 0
    dd 0

GDT_CODEDESC:
    dw 0xffff
    dw 0x0000 
    db 0x00
    db 10011010b
    db 11001111b
    db 0x00
GDT_DATADESC:
    dw 0xffff
    dw 0x0000 
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00
GDT_END:

GDT_DESCRIPTOR:
    GDT_SIZE: 
        dw GDT_END - GDT_NULLDESC - 1
        dq GDT_NULLDESC

CODESEG equ GDT_CODEDESC - GDT_NULLDESC
DATASEG equ GDT_DATADESC - GDT_NULLDESC
