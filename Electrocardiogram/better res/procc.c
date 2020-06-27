/*
 * _1.c
 *
 * Created: 25/09/2014 01:49:04 p.m.
 *  Author: Fernando
 */ 

#include <avr/io.h>
#define F_CPU 8000000
#include <avr/interrupt.h>
#include <util/delay.h>
#define USART_BAUDRATE 38400
#define BAUD_PRESCALE (((F_CPU / (USART_BAUDRATE * 16UL))) - 1)
float data1, data2;	
int yy;		

ISR(USART_UDRE_vect)
{
	yy++;
    if (yy == 1)
    {
		UDR = data1;
    }
	if (yy == 2)
    {
		UDR = data2;
	    yy = 0;
    }        
}

int main(void)
{		
	UBRRH = (BAUD_PRESCALE >> 8); // Load upper 8-bits of the baud rate value into the high byte of the UBRR register
	UBRRL = BAUD_PRESCALE; // Load lower 8-bits of the baud rate value into the low byte of the UBRR register
	UCSRB = (1 << RXEN) | (1 << TXEN) | (1<<UDRIE);  // Turn on the transmission and reception circuitry,   Enable the USART Recieve Complete interrupt (USART_RXC)
	UCSRC = (1 << URSEL) | (1 << UCSZ0) | (1 << UCSZ1); // Use 8-bit character sizes
	ADMUX|=  (1<<REFS0) | (1<<MUX1) | (1<<MUX0);
	ADCSRA|= (1<<ADEN) |(1<<ADPS1) | (1<<ADPS0) | (1<<ADPS2);
	_delay_ms(10);
	sei();
		
    while(1)
    { 
		ADCSRA|=(1<<ADSC);
		while(!(ADCSRA & (1<<ADIF)));
		ADCSRA|= (1<<ADIF);
		
		data1 = ADCL;
		data2 = ADCH;		
	}
}