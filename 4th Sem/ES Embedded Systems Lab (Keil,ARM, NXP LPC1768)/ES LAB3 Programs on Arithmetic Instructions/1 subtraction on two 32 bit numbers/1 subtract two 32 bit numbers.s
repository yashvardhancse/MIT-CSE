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
    LDR R0, =N1         ; Load address of N1 into R0
    LDR R1, =N2         ; Load address of N2 into R1
    LDR R2, [R0]        ; Load value of N1 into R2
    LDR R3, [R1]        ; Load value of N2 into R3
    SUBS R2, R2, R3     ; Subtract R3 from R2 and update condition flags
    LDR R4, =RESULT     ; Load address of RESULT into R4
    STR R2, [R4]        ; Store the result in RESULT
STOP 
    B STOP              ; Infinite loop to stop execution
N1 DCD 0X20004500       ; First 32-bit number
N2 DCD 0X1000A002       ; Second 32-bit number
    AREA mydata, DATA , READWRITE
RESULT DCD 0            ; Result storage initialized to 0
    END
