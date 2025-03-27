    AREA RESET, DATA, READONLY
    EXPORT __Vectors
__Vectors
    DCD 0x10001000
    DCD Reset_Handler
    ALIGN 

    AREA mycode, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

Reset_Handler
    ; Load three 32-bit numbers into registers:
    MOV32 R0, #0x12345678   ; First number
    MOV32 R1, #0x00001000   ; Second number
    MOV32 R2, #0x00000010   ; Third number
	
	;0x12345678*0x00001000=0x12345678000
	;0x12345678000*0x00000010=0x123456780000
	; lower part i.e. 45678 in r3. as arm follows little endian

    ; Multiply the first two numbers (R0 and R1).
    ; UMULL produces a 64-bit result: low part in R3, high part in R4.
    UMULL R3, R4, R0, R1

    ; Now multiply the 64-bit product (R4:R3) by the third number (R2).
    ; 1) Multiply the lower 32 bits (R3) by R2:
    UMULL R5, R6, R3, R2    ; 64-bit result in R6:R5 (R5=low, R6=high)

    ; 2) Multiply the upper 32 bits (R4) by R2:
    UMULL R7, R8, R4, R2    ; 64-bit result in R8:R7 (R7=low, R8=high)

    ; Combine partial results:
    ; Add the high part from the lower multiplication (R6) to the low part of the upper multiplication (R7).
    ADDS R7, R7, R6         ; R7 = R7 + R6, sets carry if any
    ADC  R8, R8, #0         ; Add carry to the highest part if needed

    ; Final 96-bit product is in R8:R7:R5:
    ;   R5 = lowest  32 bits
    ;   R7 = middle  32 bits
    ;   R8 = highest 32 bits

    ; The expected result for these inputs is 0x123456780000 (hex),
    ; which is 20,016,817,504,256 in decimal.

STOP
    B STOP

    END
