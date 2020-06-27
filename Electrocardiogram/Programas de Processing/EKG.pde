 import processing.serial.*;
 
 Serial arduino;       // The serial port
 int xPos = 1;         // horizontal position of the graph
 int Pfp=1000;         // width of the graph
 float input;          //Intput data

 void setup ()         //Initial setup
 {
   size(Pfp,600);                              // set window size:      
   println(Serial.list());                     // List available serial ports
   arduino = new Serial(this, "COM10", 38400); // Open port COM10 @38,400 bps
   arduino.bufferUntil('\n');                  // don't generate a serialEvent() unless newline character
   
   background(255,255,255);     // black background(R,G,B) 
  
  //Draw GUI
   Write_labels();              // Write the labels
   Draw_Grid();                 // Draw the grid
   Draw_button();               // Draw buttons
   }
  
 void serialEvent (Serial arduino) 
 {
   String inString = arduino.readStringUntil('\n');  // get ASCII string
      
   if (inString != null)   //If there's a string
   {
     inString = trim(inString);               // trim off whitespace
     input = float(inString);                 // convert to float
     input = map(input,0, 1023, 0, height);   //adjust to screen height
    
     det_peak();      //Determine wave peak
     Heart_rate ();   // Write the Heart Rate
     Draw_line ();    //Draw graph
     printBPM();      //Print the BPM
     
    
     if (xPos >= width)   
     {
       xPos = 0;                  //Reset when end is reached
       
       background(255,255,255);   //black background
       
       Write_labels ();           // Write the labels
       Set_Grid ();               // Draw the grid
       Draw_button ();            // Draw buttons
       } 
     
     else 
     {
       if (B != 0) 
       {
         xPos--;
         }
    
       xPos++;      // increment the horizontal position
       }
     }
   }
