
; transfer 32 bit number from one location in memory to another location in data memory

	AREA RESET,DATA,READONLY
	EXPORT __Vectors
__Vectors
	DCD 0x10001000
	DCD Reset_Handler
	ALIGN
	AREA mycode,CODE,READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0,=SRC ; the register R0 is loaded with the address of memory location label SRC
	LDR R1,=DST ; the register R1 is loaded with address of memory label DST
	LDR R2,[R0] ; the value stored at r0 is copied to r2
	STR R2,[R1] ; the value stored at r2 is transferred to r1(destination)
STOP
	B STOP
SRC DCD 0xDEADBEEF ; Source value to be transferred

	AREA myData,DATA,READWRITE
DST DCD 0 ; desitantion initialised to zero
	END

