#include <lpc17xx.h>
#include <stdio.h>
void lcd_init(void); 
void write(int, int); 
void delay_lcd(unsigned int); 
void lcd_comdata(int, int);          
void clear_ports(void); 
void lcd_puts(unsigned char *); 

void lcd_init() 
{ 
/*Ports initialized as GPIO */ 
LPC_PINCON->PINSEL1 &= 0xFC003FFF;  //P0.23 to P0.28 
/*Setting the directions as output */ 
LPC_GPIO0->FIODIR |= 0x0F<<23 | 1<<27 | 1<<28;  /*P0.23 to P0.26 as output data lines, P0.27 as RS
	(register select to tell whether sending command or data)*/
	//P0.28 as output pin for EN
clear_ports(); //clear data lines
delay_lcd(38000);
	lcd_comdata(0x33, 0);    
 delay_lcd(42000);  
    
 lcd_comdata(0x32, 0); 
 delay_lcd(42000);   
    
 lcd_comdata(0x28, 0); //function set 
 delay_lcd(42000); 
    
 lcd_comdata(0x0c, 0);//display on cursor off  
 delay_lcd(15000); 
   
 lcd_comdata(0x06, 0); //entry mode set increment cursor right 
 delay_lcd(15000); 
   
 lcd_comdata(0x01, 0); //display clear 
 delay_lcd(19000); 
   
 return; 
 } 
 
void lcd_comdata(int temp1, int type) 
{ 
 int temp2 = temp1 & 0xf0; //move data (26-8+1) times : 26 - HN  place, 4 - Bits 
 temp2 = temp2 << 19;  //data lines from 23 to 26 
 write(temp2, type); 
 temp2 = temp1 & 0x0f;  //26-4+1 
 temp2 = temp2 << 23;  
 write(temp2, type); 
 delay_lcd(19000); 
 return; 
} 
 
void write(int temp2, int type)                        //write to command/data reg 
 {    
 clear_ports(); 
 LPC_GPIO0->FIOPIN = temp2; // Assign the value to the data lines 
/*This register is used to write data to the GPIO pins. The 4-bit data (or command) is sent to the data pins (P0.23 to P0.26).*/   
 if(type==0) 
  LPC_GPIO0->FIOCLR = 1<<27; // clear bit RS for Command 
else 
  LPC_GPIO0->FIOSET = 1<<27; // set bit RS for Data 
 
 LPC_GPIO0->FIOSET = 1<<28;    // EN=1 
 delay_lcd(250); 
 LPC_GPIO0->FIOCLR  = 1<<28; // EN =0 
     return; 
} 
 
void delay_lcd(unsigned int r1) 
{ 
   unsigned int r; 
   for(r=0;r<r1;r++); 
    return; 
} 
 
void clear_ports(void) 
{ 
     /* Clearing the lines at power on */ 
 LPC_GPIO0->FIOCLR = 0x0F<<23; //Clearing data lines 
 LPC_GPIO0->FIOCLR = 1<<27;  //Clearing RS line 
 LPC_GPIO0->FIOCLR = 1<<28; //Clearing Enable line 
         
    return; 
} 
 
void lcd_puts(unsigned char *buf1) 
{ 
    unsigned int i=0; 
 unsigned int temp3; 
     while(buf1[i]!='\0') 
     { 
         temp3 = buf1[i]; 
        lcd_comdata(temp3, 1); 
         i++; 
         if(i==16) 
         { 
            lcd_comdata(0xc0, 0); 
         }}return;}


#define REF 3.300
#define FULL_SCALE 0xFFF

void lcd_printer(unsigned char* a, int screen_pos) {
	lcd_comdata(screen_pos, 0);
	delay_lcd(800);
	lcd_puts(a);
}

int main(void) {
	unsigned int adc4, adc5, i;
	int diff;
	float vdiff;
	unsigned char vtg[7],ad4[7],ad5[7];
	SystemInit();
	SystemCoreClockUpdate();
	LPC_SC->PCONP |= 1 << 15; //sets 15th bit in register
	lcd_init();
	LPC_PINCON->PINSEL3 |= 0xF0000000; //configures p0.28 and p0.29 as ADC input channels
	//pin connect block
	//PINSEL3 controls the functions of pins P0.28 to P0.31.
	/*This is a 32-bit value, and we are manipulating the upper four bits of PINSEL3 to select the alternate function for pins P0.28 to P0.31. The specific bits that are set will configure these pins for their alternate functions (like analog input for ADC channels).*/
	//P0.28 (Pin 28) Configured for ADC channel 4.
//P0.29 (Pin 29)  Configured for ADC channel 5.
	LPC_SC->PCONP |= 1 << 12; //sets 12th bit in PCONP register to power up the ADC module
	SystemCoreClockUpdate();
	while(1) {
		LPC_ADC->ADCR = 1 << 4 | 1 << 21 | 1 << 24;
		while(LPC_ADC->ADDR4 & 0x80000000);
		adc4 = LPC_ADC->ADDR4;
		adc4 >>= 4;
		/*This reads the 12-bit result from ADC channel 4, clears the extra bits, and stores the result in the variable adc4.*/
		adc4 &= 0xFFF;
		sprintf((char*) ad4, "%X", adc4); //store formatted result into string variable until you pass it, convert value into string format
		LPC_ADC->ADCR = 1 << 5 | 1 << 21 | 1 << 24;
		while (!(LPC_ADC->ADDR5 & 0x80000000));
		adc5 = LPC_ADC->ADDR5;
		adc5 >>= 4;
		adc5 &= 0xFFF;
		diff = adc4 - adc5;
		//diff = diff < 0 ? -diff : diff;
		vdiff = ((float) diff * (float) REF) / ((float) FULL_SCALE);
		sprintf((char*) vtg, "%3.2f", vdiff);
		sprintf((char*) ad5, "%X", adc5);
		for (i = 0; i < 2000; i++);
		lcd_printer(&vtg[0], 0x80);
		lcd_printer(&ad4[0], 0xC0);
		lcd_printer(&ad5[0], 0xC9);
		for (i = 0; i < 200000; i++);
		for (i = 0; i < 7; i++)
			vtg[i] = 0x0;
		adc4 = 0;
		adc5 = 0;
		diff = 0;
	}
}

//diff=adc4-adc5
