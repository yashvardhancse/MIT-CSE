		AREA RESET, DATA, READONLY ; area directive tells the assembler to define a new section of memory
		EXPORT __Vectors
__Vectors
	DCD 0X10001000 ; dcd allocates the word size memory and initialises the values
	DCD Reset_Handler
	ALIGN
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	MOV R0,#10
	MOV R1, #3
	ADD R0, R1 ; R0+= R1
STOP B STOP ; b stands for branch, it causes an unspecified jump to the specified label, this means jump to the label stop, b is unconditional, it creates infinite loop at label stop
	END