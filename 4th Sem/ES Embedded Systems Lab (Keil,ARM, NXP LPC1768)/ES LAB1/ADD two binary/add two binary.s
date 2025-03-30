; Write a program to add two binary numbers
		AREA RESET, DATA, READONLY
		EXPORT __Vectors
__Vectors
		DCD 0X10001000
		DCD Reset_Handler
		AREA mycode, CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
Reset_Handler
	MOV R0,#2_101 ; 101 is 5
	MOV R1,#2_110 ; 110 Is 6
	ADD R2,R0,R1
STOP
	B STOP
	END
		