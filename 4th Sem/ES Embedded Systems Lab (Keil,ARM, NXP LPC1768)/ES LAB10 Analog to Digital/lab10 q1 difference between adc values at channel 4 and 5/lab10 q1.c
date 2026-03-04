#include<LPC17xx.h> 
#include<stdio.h> 


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
LPC_GPIO0->FIODIR |= 0x0F<<23 | 1<<27 | 1<<28;  
clear_ports(); 
delay_lcd(32000);
	lcd_comdata(0x33, 0);    
 delay_lcd(40000);  
    
 lcd_comdata(0x32, 0); 
 delay_lcd(40000);   
    
 lcd_comdata(0x28, 0); //function set 
 delay_lcd(40000); 
    
 lcd_comdata(0x0c, 0);//display on cursor off  
 delay_lcd(12000); 
   
 lcd_comdata(0x06, 0); //entry mode set increment cursor right 
 delay_lcd(12000); 
   
 lcd_comdata(0x01, 0); //display clear 
 delay_lcd(15000); 
   
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
 delay_lcd(12000); 
 return; 
} 
 
void write(int temp2, int type)                        //write to command/data reg 
 {    
 clear_ports(); 
 LPC_GPIO0->FIOPIN = temp2; // Assign the value to the data lines    
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

#define Ref_Vtg 3.300 
#define Full_Scale 0xFFF 
				 unsigned char str[]={"0123456789"};
unsigned long x,temp,t1=0,t2=0;
unsigned int channel,result,i,j, flag1;
unsigned char Msg1[10]={"ADC value"};

void ADC_IRQHandler(void)
{
    uint32_t adc_value;

    if (LPC_ADC->ADSTAT & (1 << 4))  // Check if ADC channel 4 interrupt flag is set
    {
        adc_value = (LPC_ADC->ADDR4 >> 4) & 0xFFF;  // Get ADC value from channel 4 (clear lower 4 bits)
        t1 = (adc_value * 3300) / 4096;  // Convert to voltage (in mV)
    }

    if (LPC_ADC->ADSTAT & (1 << 5))  // Check if ADC channel 5 interrupt flag is set
    {
        adc_value = (LPC_ADC->ADDR5 >> 4) & 0xFFF;  // Get ADC value from channel 5
        t2 = (adc_value * 3300) / 4096;  // Convert to voltage (in mV)
    }

    result = abs(t1 - t2);  // Calculate the difference between t1 and t2
    Msg1[0] = '0' + (result / 1000);  // First digit of the result
    Msg1[1] = '0' + ((result / 100) % 10);  // Second digit of the result
    Msg1[2] = '0' + ((result / 10) % 10);  // Third digit of the result
    Msg1[3] = '0' + (result % 10);  // Fourth digit of the result
    Msg1[4] = '\0';  // Null-terminate the string

    lcd_comdata(0xc0, 0);  // Move cursor to the second line of the LCD
    lcd_puts(Msg1);  // Display the result on the LCD
}


int main(void)
{
    lcd_init();
    LPC_PINCON->PINSEL3 = (0xF << 28);  // Select AD0.5 (P1.31) as an ADC channel
    LPC_SC->PCONP |= (1 << 12);         // Power up the ADC
    LPC_ADC->ADCR = (1 << 4) | (1 << 5) | (1 << 16) | (1 << 21);  // Enable channels 4 and 5, enable ADC, and start conversions
    LPC_ADC->ADINTEN = (1 << 4) | (1 << 5);  // Enable interrupts for channels 4 and 5

    NVIC_EnableIRQ(ADC_IRQn);  // Enable ADC interrupt

    lcd_comdata(0x80, 0);  // Move cursor to the first line of the LCD
    delay_lcd(10000);  // Wait for a while
    lcd_puts(Msg1);  // Display the initial message

    while(1)
    {
        // Main loop does nothing, interrupt handler takes care of ADC readings
    }
}
