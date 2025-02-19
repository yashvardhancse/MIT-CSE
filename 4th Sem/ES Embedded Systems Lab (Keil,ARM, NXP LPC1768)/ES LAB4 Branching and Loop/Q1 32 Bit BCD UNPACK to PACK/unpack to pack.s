        ; 32-BIT BCD UNPACK TO PACK CONVERSION
        AREA RESET, DATA, READONLY
        EXPORT __Vectors

__Vectors
        DCD 0X10001000    ; Stack Pointer (Not used in this example)
        DCD Reset_Handler ; Address of Reset Handler
        ALIGN

        AREA mycode, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler

Reset_Handler
        MOV R2, #4        ; Initialize loop counter (processes 4 bytes)
        LDR R0, =UNPACK   ; Load address of unpacked BCD data
        LDR R1, =RESULT   ; Load address to store packed BCD data

UP
        LDRB R3, [R0], #1 ; Load first BCD digit (low nibble)
        LDRB R4, [R0], #1 ; Load second BCD digit (high nibble)
        LSL R4, #4        ; Shift high nibble left by 4 bits
        ORR R3, R4        ; Combine high and low nibbles to form a single byte
        STRB R3, [R1], #1 ; Store packed BCD byte in result
        SUBS R2, #2       ; Decrement loop counter by 2 (since two nibbles are processed)
        BNE UP            ; Repeat until all nibbles are packed

STOP
        B STOP            ; Infinite loop (halt execution)

; -----------------
; Data Section
; -----------------
UNPACK  DCD 0X01020304    ; Input Unpacked BCD (Stored as separate nibbles)

        AREA mydata, DATA, READWRITE
RESULT  DCD 0             ; Storage for packed BCD result

        END
