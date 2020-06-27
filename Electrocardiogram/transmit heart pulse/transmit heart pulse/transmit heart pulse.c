/*
 * transmit_heart_pulse.c
 *
 * Created: 10/11/14 3:52:43 p. m.
 *  Author: Fernando
 */ 

	//==================================
	#include <stdbool.h>
	#define F_CPU 8000000// Clock Speed
	//#define MYUBRR FOSC/16/BAUD-1
	#include <avr/io.h>

	#define RX_BUFFER_SIZE		64
	//#define BAUD 9600
	#define USART_BAUDRATE 9600
	#define BAUD_PRESCALE (((F_CPU / (USART_BAUDRATE * 16UL))) - 1)
	#include <avr/interrupt.h>
	int transmit_enable = 1;
	int packet_position = 1;
	int data = 0xAAFF; //variable where the trasnmited data will be

int main(void)
{
	sei();
	UBRRH = (BAUD_PRESCALE >> 8); // Load upper 8-bits of the baud rate value into the high byte of the UBRR register
	UBRRL = BAUD_PRESCALE; // Load lower 8-bits of the baud rate value into the low byte of the UBRR register
	//UBRRL = BAUD & 0xFF;
	//UBRRH = (BAUD >> 8) & 0xFF;
	UCSRB = (1 << RXEN) | (1 << TXEN) | (1 << UDRIE);  // Turn on the transmission and reception circuitry,   Enable the USART Recieve Complete interrupt (USART_RXC)
	UCSRC = (1 << URSEL) | (1 << UCSZ0) | (1 << UCSZ1); // Use 8-bit character sizes
	//DDRB |= (1<<PB0) ;
	//UCSRB
	//display on
	DDRD |= 0xFC;

/*
UDR = 0xAB;
UDR = 0xCD;
UDR = 0x02;
UDR = 0x00;
UDR = 0x01;
UDR = 0x01;
*/

    while(1)
    {
    }
}

ISR(USART_UDRE_vect)
{
if (packet_position == 1)
{
	
	UDR = 0xAB;
	packet_position = 2;
}
else if (packet_position == 2)
{
	UDR = 0xCD;
	packet_position = 3;
}else if (packet_position == 3)
{
	UDR = 0x02;
	packet_position = 4;
}
else if (packet_position == 4)
{
	UDR = 0x00;
	packet_position = 5;
}
else if (packet_position == 5)
{
	UDR = data;
	packet_position = 6;
}
else if(packet_position == 6)
{
	UDR = (data>>8);
	packet_position = 1;
}

}







/*
		   switch(packet_position)
		   {
			   case 1 :
			   			UDR = 0xAB;
			   			transmit_enable = 0;
						packet_position ++;
			   break;
			   
			   
			   case 2 :
			   			   			UDR = 0xCD;
			   			   			transmit_enable = 0;
			   			   			packet_position ++;
			   break;
			   
			   
			   case 3 :
			   			   			UDR = 0x02;
			   			   			transmit_enable = 0;
			   			   			packet_position ++;
			   break;
			   
			   
			   case 4 :
			   			   			UDR = 0x00;
			   			   			transmit_enable = 0;
			   			   			packet_position ++;
			   break;
			   
			   
			   case 5 :
			   			   			UDR = 0x01;
			   			   			transmit_enable = 0;
			   			   			packet_position ++;
			   break;
			   
			   
			   case 6 :
			   			   			UDR = 0x01;
			   			   			transmit_enable = 0;
			   			   			packet_position = 1;
			   break;

		   }			
		*/