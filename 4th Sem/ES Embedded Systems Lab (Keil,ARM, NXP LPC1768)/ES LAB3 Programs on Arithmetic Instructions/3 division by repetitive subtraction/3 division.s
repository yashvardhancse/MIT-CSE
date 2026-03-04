;Write an assembly language program to implement division by repetitive subtraction

;Write an assembly language program to implement division using repetitive subtraction
	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors
	DCD 0X10001000
	DCD Reset_Handler
	ALIGN 
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0, =N1 ; r0 has address of n1
	LDR R1, =N2 ; r1 has address of n2
	LDR R6, =RESULT ; r6 has address of result
	LDR R2, [R0] 
	LDR R3, [R1]
	MOV R5, #0
UP	CMP R2, R3
	BCC STORE ; bcc is branch if carry clear, branches if r2<r3
	SUBS R2, R3
	ADD R5, #1
	B UP
STORE STR R5, [R6], #4
	STR R2, [R6]
STOP B STOP
N1 DCD 0X15 ; 0x15 is 21 in decimal
N2 DCD 0X5
	AREA mydata, DATA , READWRITE
RESULT DCD 0
	END