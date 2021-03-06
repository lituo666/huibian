DATA SEGMENT
	BUF DB 6
		DB ?
		DB 6 DUP(?)
	CUOWU DB 'Input Error!$'
	
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE,DS:DATA
	START:
		MOV AX,DATA
		MOV DS,AX
		
		MOV DX,OFFSET BUF
		MOV AH,10
		INT 21H
		
		MOV BX,OFFSET BUF
		ADD BX,2
		MOV CL,4
	J1:
		MOV AL,BYTE PTR[BX]
		CMP AL,'0'
		JAE J3		;大于等于
		JMP CUO
	J3:	
		CMP AL,'9'
		JA ZIMU
		SUB AL,'0'
		MOV AH,0
		PUSH AX
		INC BX
		DEC CL
		JNZ J1
		JMP XIAN
	ZIMU:
		CMP AL,'a'
		JAE J4		;大于等于
		JMP CUO
	J4:
		CMP AL,'f'
		JBE J5		;小于等于
		JMP CUO
	J5:
		SUB AL,'a'
		ADD AL,10
		MOV AH,0
		PUSH AX
		INC BX
		DEC CL
		JNZ J1
		JMP XIAN
	XIAN:
		MOV AX,0
		POP BX
		MOV AX,BX
		
		POP BX
		MOV CL,4
		SHL BX,CL
		OR AX,BX
		
		POP BX
		MOV CL,8
		SHL BX,CL
		OR AX,BX
		
		POP BX
		MOV CL,12
		SHL BL,CL
		OR AX,BX
		
		
		
		MOV CL,4
		PUSH AX
	J2:	
		POP AX
		PUSH AX
		
	CUO:
		MOV DX,OFFSET CUOWU
		MOV AH,9
		INT 21H
	NEXT:
		MOV AH,4CH
		INT 21H
CODE ENDS
	END START

