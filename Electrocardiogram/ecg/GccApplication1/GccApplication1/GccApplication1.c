/*
 * _1.c
 *
 * Created: 25/09/2014 01:49:04 p.m.
 *  Author: luis
 */ 


#include <avr/io.h>

#define F_CPU 8000000
#include <avr/interrupt.h>
#include <util/delay.h>
//==================================
#define USART_BAUDRATE 9600
#define BAUD_PRESCALE (((F_CPU / (USART_BAUDRATE * 16UL))) - 1)

int data; //variable where the trasnmited data will be
int i = 10;
			
ISR(USART_UDRE_vect){

		UDR = data;

}


 
	int main(void)
{	
	
	UBRRH = (BAUD_PRESCALE >> 8); // Load upper 8-bits of the baud rate value into the high byte of the UBRR register
	UBRRL = BAUD_PRESCALE; // Load lower 8-bits of the baud rate value into the low byte of the UBRR register
	UCSRB = (1 << RXEN) | (1 << TXEN) | (1<<UDRIE);  // Turn on the transmission and reception circuitry,   Enable the USART Recieve Complete interrupt (USART_RXC)
	UCSRC = (1 << URSEL) | (1 << UCSZ0) | (1 << UCSZ1); // Use 8-bit character sizes
		
	
	
		ADMUX|=  (1<<REFS0) | (1<<MUX1) | (1<<MUX0) | (1<<ADLAR);
		
		ADCSRA|= (1<<ADEN) |(1<<ADPS1) | (1<<ADPS0);
		_delay_ms(10);
		sei();
		

    while(1)
    { 
	
	data = i;
	i++;
	if (i > 250)
	{
		i = 10;
	}
	}
	
	}