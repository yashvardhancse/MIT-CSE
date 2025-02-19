        AREA RESET, DATA, READONLY  ; Define a read-only data section
        EXPORT __Vectors            ; Make the vector table accessible
        
__Vectors
        DCD 0X10001000              ; Stack Pointer (not used in this example)
        DCD Reset_Handler           ; Address of the reset handler (entry point)
        ALIGN                        ; Align memory
        
        AREA mycode, CODE, READONLY  ; Define a read-only code section
        ENTRY                        ; Define the entry point of execution
        EXPORT Reset_Handler         ; Make Reset_Handler accessible

Reset_Handler
        LDR R0, =NUM1                ; Load address of NUM1 into R0
        LDR R1, =NUM2                ; Load address of NUM2 into R1
        LDR R2, =RES                 ; Load address of RES (to store result)
        MOV R4, #0                    ; Initialize carry (R4 = 0)
        
        LDR R5, [R0]                  ; Load the packed BCD value of NUM1 into R5
        LDR R6, [R1]                  ; Load the packed BCD value of NUM2 into R6

UP      MOV R7, R5                    ; Copy R5 (NUM1) to R7
        MOV R8, R6                    ; Copy R6 (NUM2) to R8
        
        AND R7, #0xF                   ; Extract the **least significant** BCD digit of NUM1
        ADDS R7, R4                    ; Add the previous carry to the extracted digit
        MOV R4, #0                     ; Reset carry
        
        AND R8, #0xF                   ; Extract the **least significant** BCD digit of NUM2
        BL ADDN                         ; Branch to ADDN (digit-wise addition)

        LSR R5, #4                     ; Right shift R5 (NUM1) to process the next digit
        LSR R6, #4                     ; Right shift R6 (NUM2) to process the next digit

        CMP R5, #0                      ; Check if NUM1 is fully processed
        BEQ DOWN                        ; If R5 == 0, check NUM2 (jump to DOWN)
        B UP                            ; Otherwise, continue processing NUM1

DOWN    CMP R6, #0                      ; Check if NUM2 is fully processed
        BEQ TUPAC                       ; If R6 == 0, jump to packing step
        B UP                            ; Otherwise, continue processing

; -----------------------------------------------------------------------------
; ADDN: Adds two 4-bit BCD digits (R7 and R8), handles carry, and stores result
; -----------------------------------------------------------------------------
ADDN    ADDS R7, R8                     ; R7 = R7 + R8 (BCD digit addition)
        CMP R7, #0xA                     ; If sum >= 10, a carry is needed
        BCC STORE                        ; If sum < 10, no carry (branch to STORE)
        
        SUB R7, #0xA                     ; Convert sum into valid BCD digit
        ADD R6, #1                        ; Propagate carry to the next higher digit
        
STORE   STRB R7, [R2], #1                ; Store the result (unpacked BCD) and increment R2
        BX LR                            ; Return to the main loop

; -----------------------------------------------------------------------------
; TUPAC: Packs the unpacked BCD result back into proper packed BCD format
; -----------------------------------------------------------------------------
TUPAC   MOV R0, R2                      ; Store current result pointer in R0
        LDR R2, =RES                    ; Load start address of RES
        LDR R3, =PACK                    ; Load address of PACK (for packed BCD storage)
        SUB R4, R0, R2                   ; Compute the number of bytes in RES

UP1     LDRB R0, [R2], #1                ; Load first unpacked BCD digit into R0
        LDRB R1, [R2], #1                ; Load second unpacked BCD digit into R1
        LSL R1, #4                        ; Shift R1 left to form upper nibble
        ORR R1, R0                        ; Combine upper and lower nibbles
        STRB R1, [R3], #1                 ; Store the packed BCD result into PACK

        SUB R4, #2                        ; Decrease byte counter by 2
        CMP R4, #1                        ; If at least 2 more digits exist, continue
        BGE UP1

STOP    B STOP                            ; Infinite loop to stop execution

; -----------------------------------------------------------------------------
; Data Section
; -----------------------------------------------------------------------------
NUM1    DCD 0x46                         ; Packed BCD for decimal 46
NUM2    DCD 0x11                         ; Packed BCD for decimal 11

        AREA mydata, DATA, READWRITE     ; Define a read-write data section
RES     DCD 0                            ; Memory to store **unpacked** BCD result
PACK    DCD 0                            ; Memory to store **packed** final result

        END                               ; End of the assembly program
