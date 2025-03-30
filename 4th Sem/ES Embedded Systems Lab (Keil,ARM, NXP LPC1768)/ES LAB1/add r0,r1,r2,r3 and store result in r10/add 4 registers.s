; Write a program that adds contents of regsiters r0,r1,r2,r3 and stores then in r10
		AREA RESET, DATA, READONLY
		EXPORT __Vectors
__Vectors
		DCD 0X10001000
		DCD Reset_Handler
		AREA mycode, CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
Reset_Handler
	MOV R0,#1
	MOV R1,#2
	MOV R2,#3
	MOV R3,#4
	ADD R4,R0,R1
	ADD R5, R2, R3
	ADD R10,R4,R5
STOP
	B STOP
	END