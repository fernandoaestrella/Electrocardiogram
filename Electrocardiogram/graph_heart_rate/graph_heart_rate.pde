import processing.serial.*;

Serial myPort;
int xPos = 1; 
float top = 0;
float time = 0;
int tolerate = 0;
int bpm = 0;
int valid = 0;
float inBytelow;
float inBytehigh;

void setup () 
{
    size(1250, 200);
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
         
        inByte = map(inByte, 0, 1024, 0, height);
        stroke(200);
        point(xPos, height - inByte);

        xPos++;
        if (xPos==width)
        {
            background(0);
            xPos = 1;
        }

        if ((inByte > ((95*top)/100)) & (valid == 2))
        {
            time = (1/time)*4000;
            println(time);
            time = 0;
            tolerate = 0;
            top = 0;
            valid = 0;
        }
        
        if (inByte > top)
        {
            top = inByte;
            valid = 1;
        }
        
        if ((valid == 1) & (inByte < ((95*top)/100)))
        {
            valid = 2;
        }
        
        time = time + 1;
        
    }

}

