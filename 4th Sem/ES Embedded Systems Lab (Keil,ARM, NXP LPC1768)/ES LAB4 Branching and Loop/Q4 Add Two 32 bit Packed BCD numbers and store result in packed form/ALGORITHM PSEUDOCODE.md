Initialization:
    Load address of NUM1 into R0
    Load address of NUM2 into R1
    Load address of RES into R2
    Set carry register R4 = 0
    Load packed BCD values:
        R5 = [R0]  (NUM1)
        R6 = [R1]  (NUM2)

Digit-Wise Addition:
    Repeat until all digits are processed:
        Extract least significant 4-bit digit from R5 → R7 (AND R7, 0xF)
        Add carry (R4) to R7
        Reset carry (R4 = 0)
        Extract least significant 4-bit digit from R6 → R8 (AND R8, 0xF)

        Call ADDN subroutine:
            Perform BCD addition (R7 + R8)
            If sum >= 10:
                Subtract 10 from sum (R7 -= 10)
                Increment next digit of R6 (R6 += 1)
            Store sum in memory as unpacked BCD

        Right shift R5 by 4 bits
        Right shift R6 by 4 bits
        If R5 is not zero, repeat
        If R6 is not zero, repeat

Pack BCD Result:
    Load result addresses:
        R0 = RES (End address)
        R2 = RES (Start address)
        R3 = PACK (Destination for packed BCD)
    Compute result length (R4 = R0 - R2)

    Loop through unpacked BCD result:
        Load two consecutive bytes from RES
        Combine them into a single byte (upper nibble + lower nibble)
        Store in PACK
        Reduce count by 2
        If more than one byte remains, repeat

Stop Execution:
    Enter infinite loop (STOP)
