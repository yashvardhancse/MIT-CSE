        ; Convert 32-bit BCD to Eight 32-bit ASCII Values
        AREA RESET, DATA, READONLY
        EXPORT __Vectors

__Vectors
        DCD 0X10001000    ; Stack Pointer (not used in this example)
        DCD Reset_Handler ; Reset Handler Address
        ALIGN

        AREA mycode, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler

Reset_Handler
        MOV R5, #4        ; Loop counter (processes 4 bytes)
        LDR R0, =NUM      ; Load address of 32-bit BCD number
        LDR R3, =RESULT   ; Load address to store ASCII values

UP
        LDRB R1, [R0], #1  ; Load one BCD byte (two digits)

        ; Extract lower nibble (rightmost digit)
        AND R2, R1, #0x0F  ; Mask lower 4 bits
        ADD R2, #0x30      ; Convert to ASCII ('0' = 0x30)
        STR R2, [R3], #4   ; Store ASCII value (as 32-bit word)

        ; Extract upper nibble (leftmost digit)
        AND R4, R1, #0xF0  ; Mask upper 4 bits
        MOV R4, R4, LSR #4 ; Shift right to get the digit
        ADD R4, #0x30      ; Convert to ASCII
        STR R4, [R3], #4   ; Store ASCII value (as 32-bit word)

        ; Decrement loop counter
        SUBS R5, #1
        BNE UP             ; Repeat until all bytes are processed

STOP
        B STOP             ; Infinite loop (halt execution)

; -----------------
; Data Section
; -----------------
NUM     DCD 0X12345678    ; Input BCD (Example: 12 34 56 78)

        AREA mydata, DATA, READWRITE
RESULT  DCD 0             ; Storage for ASCII results (8 values)

        END
