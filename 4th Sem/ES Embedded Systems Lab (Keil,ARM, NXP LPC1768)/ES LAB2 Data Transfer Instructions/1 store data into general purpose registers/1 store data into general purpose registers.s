;Write an ARM assembly language program to store data into general purpose registers
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
	LDR R0, =SRC ; the address of src is put into register R0
	LDR R1, [R0] ; the content stored at r0 is copied to register r1
STOP B STOP
SRC DCD 0X12345678
	END