import processing.serial.*;

Serial myPort;
int xPos = 1; 
float top = 0;
float bottom = 1023;
float inBytelow;
float inBytehigh;
int BPM = 0;
int BPM_new = BPM;
int BPM_avg = 0;
int count = 0;
int status = 0;
int time = 0;
float midreal;

void setup () 
{
  println(bottom);
    size(1250, 300);
    println(Serial.list());
    myPort = new Serial(this, Serial.list()[2], 38400);
}

void draw()
{
    while (myPort.available() > 0)
    {
        float inByte = myPort.read();
        
        if ( inByte  < 4)
        {
            inBytehigh = inByte;
            inBytehigh = (inBytehigh * 256);
            inByte = inBytehigh + inBytelow;
        }
        else 
        {
            inBytelow = inByte;
            inByte = inBytehigh + inBytelow;
        }
         
        midreal = 370;                                                                     //OJO, VARIABLE
        inByte = ((inByte - midreal) * 3.5) + midreal;
        
        inByte = map(inByte, 0, 1023, 0, height);//330,600
        stroke(200);
        point(xPos, height - inByte);

        xPos++;
        if (xPos==width)
        {
            background(0);
            xPos = 1;
        }
        
        if (inByte > top)
        {
            top = inByte;
        }
        
        if(time==0)
        {
            time = millis();
        }
       
        if((millis()-time)<=5000)
        {
        
           if(inByte >= (top*0.95))
           {
              status= 1;
           }
        
           if((inByte < top*0.90) && (status == 1)) 
           {
               count++;
               status = 0;
           }
        }
        else
        {
           time= millis();                   //reset time count
           BPM_new = count *12;              //1 min = 60 secs
           top = 0;
           BPM_avg = (BPM_new + BPM_avg)/2;  //Average new and current BPMs
           println(count);
           println(BPM_avg);
           count = 0;                        //Restart beat count
        }
    }
}
