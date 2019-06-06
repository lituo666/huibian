; multi-segment executable file template.

data segment
    STRING DB 'SPACE EXPLORERS INC'
    PRLINE DB 'SPACE EXPLORERS INCE'
    LAST   DB ' '  
    same   DB 'MATCH$'
    nsame  DB 'NO MATCH$'
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here 
    mov cx,PRLINE-STRING        ;先判断长度，长度不相等直接不匹配
    cmp cx,LAST-PRLINE
    jnz NEQUAL
     
    lea si,STRING               ;长度相等则逐个匹配
    mov di,offset PRLINE
    cld
    rep cmpsb
    jz  EQUAL
    jnz NEQUAL
    
    EQUAL:                      ;输出结果
    lea dx,same 
    jmp NEXT 
    NEQUAL:
    lea dx,nsame
    NEXT:
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.