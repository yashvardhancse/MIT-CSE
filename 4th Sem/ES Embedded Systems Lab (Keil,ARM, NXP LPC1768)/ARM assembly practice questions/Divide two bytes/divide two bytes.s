	AREA RESET, CODE, READONLY
	EXPORT __Vectors
	EXPORT Reset_Handler

__Vectors
	DCD 0X10001000
	DCD Reset_Handler
	ALIGN 

	ENTRY
Reset_Handler
	MOV R2, #0x15    ; Load Dividend (21)
	MOV R3, #0x05    ; Load Divisor (5)

	CMP R3, #0        ; Check for division by zero
	BEQ STOP          ; If divisor is zero, stop

	MOV R5, #0        ; Initialize quotient to 0

UP	CMP R2, R3        ; Compare dividend and divisor
	BCC STORE         ; If R2 < R3, store quotient & remainder
	SUBS R2, R3       ; R2 = R2 - R3 (subtract divisor)
	ADD R5, #1        ; Increment quotient
	B UP              ; Repeat loop

STORE
	; Quotient stored in R5
	; Remainder stored in R2

STOP B STOP

	END
