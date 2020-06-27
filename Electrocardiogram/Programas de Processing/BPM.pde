int BPM = 0;
int BPM_new = BPM;
int BPM_avg = 0;
int count = 0;
float peak = 0;
int status = 0;
double time = 0;


//Peak detection
void det_peak ()
{
  if (input > peak)  
      {
        peak = input;  //make peak the largest input
        } 
  }

 // Heart Rate   
 void Heart_rate () 
 {   
   
   if(time==0)
   {
      time = millis();
       }
       
   if((millis()-time)<=5000)      //Count 5 secs
     {
        
         if(input >= (peak*0.9))  //Detect wave as peak @ 90% of peak
        {
          status= 1;              //Set bit to one
          }
        
        if(input < peak*0.8 && status == 1)   //Detect falling edge
        {
           count++;                           //Increase beat count
           status = 0;                        //Set bit to zero
           }
     }
   else
   {
     time= millis();                   //reset time count
     BPM_new = count *12;              //1 min = 60 secs
     BPM_avg = (BPM_new + BPM_avg)/2;  //Average new and current BPMs

     count = 0;                          //Restart beat count
     }
 }
 
 void printBPM()
 {
     fill(255,255,0);        //Yellow text
     textSize(24);           //24pt
     text(BPM_avg,430,570);  //print BPM value
   }
