DATA SEGMENT
	YEAR DW 2019
	YES DB 'YES!$'
	NO DB 'NO!$'
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE,DS:DATA
	START:
		MOV AX,DATA
		MOV DS,AX
		
		MOV BX,OFFSET YEAR
		MOV AX,WORD PTR[BX]
		MOV DX,0
		MOV CX,4				;除数是16位时
		DIV CX					;商在AX，余数在DX
		CMP DX,0
		JNZ J1
		MOV AX,WORD PTR[BX]
		MOV DX,0
		MOV CX,100				;除数是16位时
		DIV CX					;商在AX，余数在DX
		CMP DX,0				
		JNZ Y1					;被4整除不能被100整除是闰年
	J1:
		MOV AX,WORD PTR[BX]
		MOV DX,0
		MOV CX,400				;除数是16位时
		DIV CX					;商在AX，余数在DX
		CMP DX,0
		JZ Y1					;如果能被400整除，则是闰年

		MOV DX,OFFSET NO		;显示NO！
		MOV AH,9
		INT 21H
		JMP NEXT				;转到结束
	Y1:
		MOV DX,OFFSET YES		;显示YES!
		MOV AH,9
		INT 21H
	NEXT:
		MOV AH,4CH
		INT 21H
CODE ENDS
	END START

