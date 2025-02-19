Go to keil -> view -> memory -> memory 1

type in the address of the register, then you would see the content stored at that register.
ARM uses little endian format i.e. LSB(Lowest significant bit goes to least/lowest address).

You can see that initially regsiter R1 having address 0x10000000 is initially empty i.e. no contents at its memory.
After program execution, R1 contains the transferred value from R0 SRC.
(Refer to output images)