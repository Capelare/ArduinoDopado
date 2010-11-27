#include <Servo.h>

Servo miServo;
int pos = 90;

void setup(){
  miServo.attach(3);
}

void loop(){
  int boton = analogRead(0);
  if(boton>730){
    if(pos>0){
      pos-=1;
      miServo.write(pos);
      delay(15);
    }
  }else if(boton>475 && boton<495){
    pos=90;
    miServo.write(pos);
    delay(15);
  }else if(boton>235 && boton<255){
    if(pos<180){
      pos+=1;
      miServo.write(pos);
      delay(15);
    }
  }
}
