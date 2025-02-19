	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors 
	DCD 0x10001000
	DCD Reset_Handler
	ALIGN
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0, =N 
	LDR R1, =DST
	LDRH R2, [R0] 
	MOV R5, #0
	MOV R7, #10
	MOV R3, #0
	MOV R4, #0
loop	CMP R2,R7
		BLT exitDiv
		SUB R2,R7
		ADD R3,#1
		B loop
exitDiv	MOV R8, #0
shifter	CMP R4, R8
		BEQ exitshifter
		LSL R2, #4
		ADD R8, #1
		B shifter
exitshifter	ADD R4, #1
		ADD R5, R2
		CMP R3,	#0
		BEQ exit
		MOV R2, R3
		MOV R3,#0
		B loop
exit	STR R5, [R1]
STOP B STOP
N DCD 0x80 ; it is 128 in decimal
	AREA mydata, DATA, READWRITE
DST DCD 1 
	END