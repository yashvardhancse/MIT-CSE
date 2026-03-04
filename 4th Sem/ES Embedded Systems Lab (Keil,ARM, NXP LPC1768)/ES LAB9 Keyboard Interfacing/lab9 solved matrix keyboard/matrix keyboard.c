#include<LPC17xx.h>
 
void lcd_init(void);

void write(int, int);

void delay_lcd(unsigned int);

void lcd_comdata(int, int); 

void clear_ports(void);

void lcd_puts(unsigned char *);
 
void lcd_init() {

	/* Ports initialized as GPIO */

	LPC_PINCON->PINSEL1 &= 0xFC003FFF; // P0.23 to P0.28

	/* Setting the directions as output */

	LPC_GPIO0->FIODIR |= 0x0F<<23 | 1<<27 | 1<<28;

	clear_ports();

	delay_lcd(3200);

	lcd_comdata(0x33, 0); 

	delay_lcd(30000);

	lcd_comdata(0x32, 0);

	delay_lcd(30000);

	lcd_comdata(0x28, 0); // Function set

	delay_lcd(30000);

	lcd_comdata(0x0c, 0); // Display on, cursor off

	delay_lcd(800);

	lcd_comdata(0x06, 0); // Entry mode set, increment cursor right

	delay_lcd(800);

	lcd_comdata(0x01, 0); // Display clear

	delay_lcd(10000);

	return;

}
 
void lcd_comdata(int temp1, int type) {

	int temp2 = temp1 & 0xf0; // Move data (26-8+1) times: 26 - HN place, 4 - Bits

	temp2 = temp2 << 19; // Data lines from 23 to 26

	write(temp2, type);

	temp2 = temp1 & 0x0f; // 26-4+1

	temp2 = temp2 << 23; 

	write(temp2, type);

	delay_lcd(1000);

	return;

}
 
void write(int temp2, int type) { /* Write to command/data register */

	clear_ports();

	LPC_GPIO0->FIOPIN = temp2; // Assign the value to the data lines 

	if(type == 0)

		LPC_GPIO0->FIOCLR = 1<<27; // Clear bit RS for Command

	else

		LPC_GPIO0->FIOSET = 1<<27; // Set bit RS for Data

	LPC_GPIO0->FIOSET = 1<<28; // EN = 1

	delay_lcd(25);

	LPC_GPIO0->FIOCLR = 1<<28; // EN = 0

	return;

}
 
void delay_lcd(unsigned int r1) {

	unsigned int r;

	for(r = 0; r < r1; r++);

	return;

}
 
void clear_ports(void) { /* Clearing the lines at power on */

	LPC_GPIO0->FIOCLR = 0x0F<<23; // Clearing data lines

	LPC_GPIO0->FIOCLR = 1<<27; // Clearing RS line

	LPC_GPIO0->FIOCLR = 1<<28; // Clearing Enable line

	return;

}
 
void lcd_puts(unsigned char *buf1) {

	unsigned int i = 0;

	unsigned int temp3;

	while(buf1[i] != '\0') {

		temp3 = buf1[i];

		lcd_comdata(temp3, 1);

		i++;

		if(i == 16)

			lcd_comdata(0xc0, 0);

	}

	return;

}
 
void scan(void);
 
unsigned char Msg1[13] = "KEY PRESSED=";

unsigned char row, var, flag, key;

unsigned long int i, var1, temp, temp1, temp2, temp3;

unsigned char SCAN_CODE[16] = {0x11, 0x21, 0x41, 0x81, 0x12, 0x22, 0x42, 0x82, 0x14, 0x24, 0x44, 0x84, 0x18, 0x28, 0x48, 0x88};

unsigned char ASCII_CODE[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
 
int main(void){

	LPC_GPIO2->FIODIR |= 0X00003C00;

	LPC_GPIO1->FIODIR &= 0XF87FFFFF;

	LPC_GPIO2->FIODIR |= 0X0F<<23 | 1<<27 | 1<<28;

	clear_ports();

	delay_lcd(3200);
 
	lcd_init();

	lcd_comdata(0x80, 0);

	delay_lcd(800);

	lcd_puts(&Msg1[0]);
 
	while(1) {

		for(row = 1; row < 5; row++) {

			if(row == 1)

				var1 = 0x00000400;

			else if(row == 2)

				var1 = 0x00000800;

			else if(row == 3)

				var1 = 0x00001000;

			else if(row == 4)

				var1 = 0x00002000;
 
			temp = var1;
 
			LPC_GPIO2->FIOCLR = 0X00003C00;

			LPC_GPIO2->FIOSET = var1;

			flag = 0;

			scan();

			if(flag == 1)

				break;

		}
 
		for(i = 0; i < 16; i++) {

			if(key == SCAN_CODE[i]) {

				key = ASCII_CODE[i];

				break;

			}			

		}
 
		lcd_comdata(0xc0, 0);

		delay_lcd(800);

		lcd_puts(&key);

	}

}
 
void scan(void) {

	temp3 = LPC_GPIO1->FIOPIN;

	temp3 &= 0x7800000;

	if(temp3 != 0x00000000) {

		flag = 1;

		temp3 >>= 19;

		temp >>= 10;

		key = temp3 | temp;

	}

}

 