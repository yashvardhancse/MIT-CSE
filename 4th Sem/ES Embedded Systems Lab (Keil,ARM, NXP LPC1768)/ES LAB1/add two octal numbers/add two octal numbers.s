; Write an ARM assembly language program to add two octal numbers
		AREA RESET, DATA, READONLY
		EXPORT __Vectors
__Vectors
		DCD 0X10001000
		DCD Reset_Handler
		AREA mycode, CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
Reset_Handler
	MOV R0,#8_43
	MOV R1,#8_23 ; 8_ Denotes octal number
	ADD R2,R1,R0; R1+R0=R2
STOP
	B STOP
	END