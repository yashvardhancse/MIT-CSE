;Write arm assembly program to subtract R7 from R8 I.E. R8-R7
		AREA RESET, DATA, READONLY
		EXPORT __Vectors
__Vectors
		DCD 0X10001000
		DCD Reset_Handler
		AREA mycode, CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
Reset_Handler
		;R8-R7=R10
		MOV R7,#5
		MOV R8,#10
		SUB R10, R8,R7 ; R8-R7=R10
STOP
	B STOP
	END