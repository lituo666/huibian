DATA   SEGMENT
    ORG   100H
    BUF1  DB  256  DUP(?)
    SUM   DW  0
DATA   ENDS
CODE   SEGMENT
ASSUME   CS:CODE, DS:DATA
START:
    MOV   AX, DATA
    MOV   DS, AX				;设置数据段段地址
	
    MOV   BX, 0                 
LP1:    MOV   [BX + 100H],BL	;
    INC   BL					;BL+1
    JNZ   LP1					;BL不等于0跳转

    MOV   AX, 0
    MOV   SI, 0
LP2:    MOV   AL, [SI + 100H]
    INC   SI					;si+1
    ADD   SUM, AX				;加
    CALL  DISP_AL				;调用子程序
    CMP   SI, 256				;减法测试
    JNZ   LP2					;si不等于0跳转

    MOV   AX, SUM
    MOV   BX, 10
    MOV   CX, 0 
LP3:    MOV   DX, 0
    DIV   BX					;除
    INC   CX					;cx+1
    PUSH  DX					;压入堆栈
    CMP   AX, 0					;减法测试
    JNZ   LP3					;
    MOV   AH, 2
LP4:    POP   DX				;弹出堆栈给DX
    OR    DL, 30H				;或
    INT   21H					;
    LOOP  LP4					;cx-1,cx不等于0转移
EXIT:
    MOV   AH, 4CH				;程序结束
    INT   21H
DISP_AL:
    MOV   DL, AL				
    SHR   DL, 1					;右移
    SHR   DL, 1
    SHR   DL, 1
    SHR   DL, 1
    CALL  DISP_HEX				;调用子程序
    MOV   DL, AL
    AND   DL, 15				;与
    CALL  DISP_HEX				;调用子程序
    TEST  SI, 15				
    JNZ   DISP_SP
    MOV   DL, 13
    CALL  DISP_DL
    MOV   DL, 10
    CALL  DISP_DL
    RET
DISP_SP:    MOV   DL, ' '
    CALL  DISP_DL
    RET
DISP_HEX:    CMP   DL, 10
    JC    JIA30
    ADD   DL, 7
JIA30:    ADD   DL, 30H
DISP_DL:    PUSH  AX
    MOV   AH, 2
    INT   21H
    POP   AX
    RET
CODE   ENDS
    END   START
