#include <Servo.h>

Servo servo1, servo2;
int pos1=90, pos2 = 90;
int id=0;

void setup(){
  servo1.attach(3);
  servo1.write(pos1);
  servo2.attach(11);
  servo2.write(pos2);
  Serial.begin(9600);
  pinMode(13,OUTPUT);
}

void loop(){
  if(Serial.available()){
    id=Serial.read();
    if(id==1){
      while(!Serial.available());
      pos1=Serial.read();
      if(0<pos1 && pos1<180)
        servo1.write(pos1);
    }else if(id==2){
      while(!Serial.available());
      pos2=Serial.read();
      if(0<pos2 && pos2<180)
        servo2.write(pos2);
    }else{
      for(int i=0;i<10;i++){
        digitalWrite(13,HIGH);
        delay(20);
        digitalWrite(13,LOW);
        delay(20);
      }
    }
  }
}
