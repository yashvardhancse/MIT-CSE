; multiply two 32 bit numbers
;Write an assembly progarm to multiply two 32 bit numbers
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
	MOV32 R0, #0xABCD2314 ;Loads the 32-bit value 0xABCD2314 into R0
	MOV32 R1, #0x45690000 ;Loads the 32-bit value 0x45690000 into R1.
	MOV R2, #0
	MOV R3, #0; Initialize R2 and R3 to 0, which will hold the result of the multiplication.
	UMULL R3,R2,R0,R1  ;Multiplies the 32-bit unsigned numbers in R0 and R1.
                       ;Stores the 64-bit result in R3 (lower 32 bits) and R2 (upper 32 bits).

STOP B STOP
	END