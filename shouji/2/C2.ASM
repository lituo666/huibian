DATA SEGMENT

DATA ENDS

STACK SEGMENT STACK
    DB 100 DUP(?)
STACK ENDS

CODE SEGMENT
    MAIN PROC FAR
    ASSUME CS:CODE;DS:DATA;SS:STACK
    START:  PUSH DS
            MOV AX,0
            PUSH AX
            MOV AX,DATA
            MOV DS,AX
		
            MOV AX,0ABCDH
		
            RET
    MAIN ENDP
CODE ENDS
END START


