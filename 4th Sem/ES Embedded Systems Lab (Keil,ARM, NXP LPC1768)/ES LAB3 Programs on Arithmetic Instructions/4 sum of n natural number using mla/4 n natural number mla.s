	AREA RESET, DATA, READONLY ; sum of n natural numbers = n(n+1)/2
		; n*(n+1)=n*n +n which is mla
	EXPORT __Vectors
__Vectors
	DCD 0X10001000
	DCD Reset_Handler
	ALIGN 
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R1, =SRC        ; Load the address of SRC into R1
	LDR R2, =DST        ; Load the address of DST into R2
	LDR R3, [R1]        ; Load the value of n into R3
	MLA R3, R3, R3, R3  ; R3 = R3 * R3 + R3 ? R3 = n * n + n
	LSR R3, #1          ; R3 = R3 >> 1 ? Divide R3 by 2 logical shift right
	STR R3, [R2]        ; Store the result in DST
STOP B STOP
SRC DCD 5               ; n = 5
	AREA mydata, DATA, READWRITE
DST DCD 0               ; Destination for the result
	END
