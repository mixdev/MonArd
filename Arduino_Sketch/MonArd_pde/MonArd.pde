
#define data1 2
#define clock1 3
#define data2 4
#define clock2 5

int cFlag = 0;
int mFlag = 0;

void setup()
{
  pinMode(clock1, OUTPUT); // make the clock pin an output
  pinMode(data1 , OUTPUT); // make the data pin an output
  pinMode(clock2, OUTPUT); // make the clock pin an output
  pinMode(data2 , OUTPUT); // make the data pin an output
    pinMode(9, OUTPUT); //  buzzer output..beep...beep...beep
    
    
  shiftOut(data1, clock1, MSBFIRST,  255 >> 8); 
  shiftOut(data2, clock2, MSBFIRST,  255 >> 8); 
  
   Serial.begin(9600);
  //shiftOut(data, clock, LSBFIRST, B11111111); // send this binary value to the shift register
  
  // shiftOut(data1, clock1, LSBFIRST,  255 << 3);  
  
  //delay(500);


    /*  shiftOut(data, clock, MSBFIRST,  B00000001);
      delay(1000);
          shiftOut(data, clock, MSBFIRST,B00000010);
   */
}

void loop(){




 if (Serial.available() > 0) {
    int inByte = Serial.read();
    if(cFlag == 1)
    {
      //Serial.print(inByte,BYTE);
      //                                                int val= inByte - '0';
      
      // Saurabh's awesome suggestion for conversion :-) 
      displaydigits(data1, clock1,  inByte - '0');
      cFlag = 0;
    }
    else if(mFlag == 1)
    {
      //Serial.print(inByte,BYTE);
      displaydigits(data2, clock2, inByte - '0');
      mFlag = 0;
    }
    else if(inByte == 'C')
    {
      cFlag = 1;      
    }
    else if(inByte == 'M')
    {
      mFlag = 1;
    }
    
  }


} 

void displaydigits(int data, int clock, int digit)
{
     
             
     shiftOut(data, clock, MSBFIRST,  255 >> (8-digit));  
      if(digit > 4){  
        buzz(9, 1500, 500); // buzz the buzzer on pin 4 at 2500Hz for 500 milliseconds
    //analogWrite(9, 127);
       
        delay(20); // wait a bit between buzzes
     }
  }
  
  
//Nice buzzer function written by Rob Faludi
// check this URL http://www.faludi.com/itp/arduino/buzzer_example.pde

// but 2.5kHZ is too shrilling and not very audiable. So, play with it - Arun
void buzz(int targetPin, long frequency, long length) {
  long delayValue = 1000000/frequency/2; // calculate the delay value between transitions
  //// 1 second's worth of microseconds, divided by the frequency, then split in half since
  //// there are two phases to each cycle
  long numCycles = frequency * length/ 1000; // calculate the number of cycles for proper timing
  //// multiply frequency, which is really cycles per second, by the number of seconds to 
  //// get the total number of cycles to produce
 for (long i=0; i < numCycles; i++){ // for the calculated length of time...
    digitalWrite(targetPin,HIGH); // write the buzzer pin high to push out the diaphram
    delayMicroseconds(delayValue); // wait for the calculated delay value
    digitalWrite(targetPin,LOW); // write the buzzer pin low to pull back the diaphram
    delayMicroseconds(delayValue); // wait againf or the calculated delay value
  }
}
