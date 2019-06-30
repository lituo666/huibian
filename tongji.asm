DATAS SEGMENT
STRING DB '“In 2016，the exchange rate was 6.1/&*#2∞￥[9”。'
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
    MOV CX,43  ;循环次数
LP:
    MOV AL,[BX]  ;将数据段中字符存入AL
    CMP AL,'0'  ;数字？
    JB  NEXT0  ;
    CMP AL,'9'
    JBE NEXT1
    CMP AL,'A';字符?
    JB  NEXT0
    CMP AL,'Z'
    JBE  NEXT2
    CMP AL,'a' ;字符 ?
    JB  NEXT0
    CMP AL,'z'
    JBE NEXT2
NEXT0:
    INC BYTE PTR OTHER   ;其他自加1
    JMP CONTIN
NEXT1:
    INC BYTE PTR NUM   ;数字自加1
    JMP CONTIN 
NEXT2:
    INC BYTE PTR CHAR   ;字符自加1
    JMP CONTIN
CONTIN:
    INC BX
    LOOP LP 
    LEA DX,STR1  ;提示输出数字个数
    MOV AH,9
    INT 21H
    MOV AL,NUM
    CALL DISPLAY ;调用显示子程序
    MOV DL,0DH  ;回车换行
    MOV AH,2
    INT 21H
    MOV DL,0AH
    MOV AH,2
    INT 21H 
    LEA DX,STR2 ;提示输出字母个数
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
    LEA DX,STR3  ;提示输出其他个数
    MOV AH,9
    INT 21H
    MOV AL,OTHER
    CALL DISPLAY
    MOV AH,4CH           
    INT 21H  
DISPLAY PROC NEAR 
    MOV AH,0
    MOV BL,10   ;个数存AX除以10，分别显示十位和个位
    DIV BL  
    MOV CH,AH
    MOV DL,AL
    ADD DL,30H ;显示十位
    MOV AH,2
    INT 21H
    MOV DL,CH 
    ADD DL,30H;显示个位
    MOV AH,2
    INT 21H
    RET
DISPLAY ENDP
CODES ENDS
    END START                