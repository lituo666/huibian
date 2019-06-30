DATA   SEGMENT
    ORG   100H
    BUF1  DB  256  DUP(?)
    SUM   DW  0
DATA   ENDS
CODE   SEGMENT
ASSUME   CS:CODE, DS:DATA
START:
    MOV   AX, DATA
    MOV   DS, AX
	
    MOV   BX, 0                 
LP1:    MOV   [BX + 100H],BL
    INC   BL
    JNZ   LP1

    MOV   AX, 0
    MOV   SI, 0
LP2:    MOV   AL, [SI + 100H]
    INC   SI
    ADD   SUM, AX
    CALL  DISP_AL
    CMP   SI, 256
    JNZ   LP2

    MOV   AX, SUM
    MOV   BX, 10
    MOV   CX, 0 
LP3:    MOV   DX, 0
    DIV   BX
    INC   CX
    PUSH  DX
    CMP   AX, 0
    JNZ   LP3
    MOV   AH, 2
LP4:    POP   DX
    OR    DL, 30H
    INT   21H
    LOOP  LP4
EXIT:
    MOV   AH, 4CH
    INT   21H
DISP_AL:
    MOV   DL, AL
    SHR   DL, 1
    SHR   DL, 1
    SHR   DL, 1
    SHR   DL, 1
    CALL  DISP_HEX
    MOV   DL, AL
    AND   DL, 15
    CALL  DISP_HEX
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
