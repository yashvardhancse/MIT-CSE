; Divide a 64 bit number by a byte
; If you divide a 64-bit number (maximum value = (2^64) - 1) by a byte (max 255) 
; highest possible quotient is 7 bytes i.e. two 32 bit registers required


		AREA RESET, CODE, READONLY
        EXPORT __Vectors
        EXPORT Reset_Handler

__Vectors
        DCD 0x10001000
        DCD Reset_Handler
        ALIGN

        ENTRY
Reset_Handler
        ; Load 64-bit dividend (N1 = 0x0000000000000020)
        MOV   R2, #0x20          ; Lower 32 bits of dividend
        MOV   R3, #0x00          ; Upper 32 bits of dividend

        ; Load 8-bit divisor (N2 = 0x04)
        MOV   R4, #0x04          ; 8-bit divisor

        ; Check for division by zero
        CMP   R4, #0
        BEQ   STOP               ; Stop if divisor is zero

        ; Initialize 64-bit quotient (R5:R6 = 0)
        MOV   R5, #0
        MOV   R6, #0

UP
        ; Compare 64-bit (R3:R2) with 8-bit (R4)
        CMP   R3, #0
        BHI   SUBTRACT           ; If high part is nonzero, definitely >= R4
        CMP   R2, R4
        BCC   DONE               ; If low part < divisor, we stop

SUBTRACT
        ; Subtract divisor from 64-bit dividend
        SUBS  R2, R2, R4
        SBC   R3, R3, #0         ; Subtract with carry

        ; Increment 64-bit quotient (R5:R6)
        ADDS  R5, R5, #1         ; Increment lower part
        ADC   R6, R6, #0         ; Carry goes to upper part

        B     UP                 ; Repeat until dividend < divisor

DONE
        ; Quotient is in R6:R5 (64-bit), r5 has lower 32 bits
        ; Remainder is in R2
		;If the quotient is = 32 bits, R6 = 0, and the result is entirely in R5.
		;If the quotient exceeds 32 bits, R6 stores the higher bits.

STOP
        B     STOP

        END
			; 0x20 is 32, 32/4=8 as we can see 8 in output register R5
