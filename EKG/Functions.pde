 // Functions to use in my ECG 
 
int B = 0;  
int up = 0;
float T = 0;
float Yold = 0;
int Reference_Value = 100;
int conteo = 0;

 void draw () {
     // everything happens in the serialEvent()
    }

 void Draw_Grid() 
 {
   for (int i = 0; i < 50; i = i+1) 
   {
      //Draw evenly spaced horizontal and vertical lines
      line(20*i,20 ,20*i, 600);
      line(0,20*i ,Pfp, 20*i);
       }
    }
    
 
 // Write the labels
 void Write_labels () 
   {
     textSize(32);                // Set the text size
     fill(255,255, 0);            // Sets the text color
     stroke(255,255, 0);          // Sets the color used to draw lines
     String s = "ECG Signal";     //Set string
     text(s,400,30);              //Print string
     textSize(24);
     String f = "BPM";
     text(f,570,570);
     }
 
 // Draw button
   void Draw_button () {
       textSize(14);
     
      //Save button
       rectMode(CORNERS);      //Rectangle starts @ corner
       fill(151, 234, 234);    //Color for fill
       rect(790,0,890,20);     //Draw rectangle
       fill(0);
       text("Save", 825, 18);  //print text
     
     //Start/Stop button
       rectMode(CORNERS);
       fill(0, 255, 0);
       rect(900,0,1000,20);
       fill(0);
       text("Start/Stop", 920, 18);
   }
 
 void mousePressed () 
 {
   //Mouse presses Start/stop button
   if (mouseX > 900 && mouseX < 1000 && mouseY > 0 && mouseY < 20 ) 
   {
     B = ~B;    //Toggle B
     }
     
   if (B == 0) 
   {
     fill(0, 255, 0);                //Green button
     rect(900,0,1000,20);            //Draw rectangle
     fill(0);
     text("Start/Stop", 920, 18);    //Print text
     }
   
   else 
   {
     fill(255, 0, 0);                //Red button
     rect(900,0,1000,20);
     fill(0);
     text("Start/Stop", 920, 18);
     }
   
   if (mouseX > 790 && mouseX < 890 && mouseY > 0 && mouseY < 20) 
   {       
       rectMode(CORNERS);
       fill(47, 36, 234);
       rect(790,0,890,20);
       fill(0);
       text("Save", 825, 18);
       saveFrame();              //Save a frame in folder
       }
 }
 
 void mouseReleased() 
 {
     //Redraw button
     rectMode(CORNERS);
     fill(151, 234, 234);
     rect(790,0,890,20);
     fill(0);
     text("Save", 825, 18);
     }

 // Draw the line
 void Draw_line () 
   {
     stroke(255,0,0);                                //Red stroke
     line(xPos-1, Yold , xPos, -1*(input-height));   //Draw line from old to new position
     Yold = -1*(input-height);                       //Make current position the old one
     println(input);                                 //Print input
     }
