DATAS SEGMENT
STRING DB '��In 2016��the exchange rate was 6.1/&*#2�ޣ�[9����'
NUM DB 0
CHAR DB 0
OTHER DB 0  
STR1 DB 'NUM=$'   
STR2 DB 'CHAR=$'
STR3 DB 'OTHER=$'
DATAS ENDS
STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    LEA BX,STRING
    MOV CX,43  ;ѭ������
LP:
    MOV AL,[BX]  ;�����ݶ����ַ�����AL
    CMP AL,'0'  ;���֣�
    JB  NEXT0  ;
    CMP AL,'9'
    JBE NEXT1
    CMP AL,'A';�ַ�?
    JB  NEXT0
    CMP AL,'Z'
    JBE  NEXT2
    CMP AL,'a' ;�ַ� ?
    JB  NEXT0
    CMP AL,'z'
    JBE NEXT2
NEXT0:
    INC BYTE PTR OTHER   ;�����Լ�1
    JMP CONTIN
NEXT1:
    INC BYTE PTR NUM   ;�����Լ�1
    JMP CONTIN 
NEXT2:
    INC BYTE PTR CHAR   ;�ַ��Լ�1
    JMP CONTIN
CONTIN:
    INC BX
    LOOP LP 
    LEA DX,STR1  ;��ʾ������ָ���
    MOV AH,9
    INT 21H
    MOV AL,NUM
    CALL DISPLAY ;������ʾ�ӳ���
    MOV DL,0DH  ;�س�����
    MOV AH,2
    INT 21H
    MOV DL,0AH
    MOV AH,2
    INT 21H 
    LEA DX,STR2 ;��ʾ�����ĸ����
    MOV AH,9
    INT 21H
    MOV AL,CHAR
    CALL DISPLAY
    MOV DL,0DH
    MOV AH,2
    INT 21H
    MOV DL,0AH
    MOV AH,2
    INT 21H  
    LEA DX,STR3  ;��ʾ�����������
    MOV AH,9
    INT 21H
    MOV AL,OTHER
    CALL DISPLAY
    MOV AH,4CH           
    INT 21H  
DISPLAY PROC NEAR 
    MOV AH,0
    MOV BL,10   ;������AX����10���ֱ���ʾʮλ�͸�λ
    DIV BL  
    MOV CH,AH
    MOV DL,AL
    ADD DL,30H ;��ʾʮλ
    MOV AH,2
    INT 21H
    MOV DL,CH 
    ADD DL,30H;��ʾ��λ
    MOV AH,2
    INT 21H
    RET
DISPLAY ENDP
CODES ENDS
    END START                