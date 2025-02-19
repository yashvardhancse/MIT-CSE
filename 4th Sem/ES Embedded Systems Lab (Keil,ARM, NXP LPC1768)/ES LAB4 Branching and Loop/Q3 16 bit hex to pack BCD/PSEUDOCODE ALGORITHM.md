1. Load N into R2
2. Initialize R5 = 0, R7 = 10, R3 = 0, R4 = 0

3. Extract least significant digit:
   - While (R2 >= 10):
       - Subtract 10 from R2
       - Increment R3

4. Shift the extracted digit:
   - Shift R2 left by 4
   - Add shifted R2 to R5

5. Process next digit:
   - If R3 == 0, go to step 6
   - Else, set R2 = R3 and repeat from step 3

6. Store final packed BCD in memory (DST)
7. Stop execution
