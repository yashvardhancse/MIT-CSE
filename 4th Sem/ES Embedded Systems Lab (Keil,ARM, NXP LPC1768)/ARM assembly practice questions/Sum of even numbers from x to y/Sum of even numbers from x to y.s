; Write an ARM assembly code to find sum of even no.s from x to y.    
	
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
    MOV R0, #5      ; Starting value X = 5
    MOV R1, #10     ; Ending value Y = 10
    MOV R2, #0      ; Initialize accumulator (sum) in R2 to 0

LOOP
    CMP R0, R1      ; Compare current number (R0) with Y
    BGT STOP        ; If current number > Y, exit loop
    AND R3, R0, #1  ; R3 = R0 & 1 (if R0 is even, result is 0)
    CMP R3, #0      ; Check if current number is even
    BNE SKIP       ; If not even, skip addition
    ADD R2, R2, R0  ; Add current even number (R0) to sum in R2
SKIP
    ADD R0, R0, #1  ; Increment current number
    B LOOP          ; Repeat the loop

STOP
    B STOP          ; Infinite loop to stop execution

    END
