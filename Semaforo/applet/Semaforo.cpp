#include "WProgram.h"
void setup();
void loop();
extern “C” void __cxa_pure_virtual() {}
#include <Servo.h>

const int ESPERANDO=1;
const int TRENLLEGANDO=2;
const int TRENPASANDO=3;
const int ERROR=99;
const int BAJADA=0;
const int SUBIDA=90;

//pines en los que iran conectados los leds del semaforo y la barrera
const int sem1 = 9;
const int sem2 = 10;
const int pinBarrera = 3;

int estado = ESPERANDO;
int longitud;
int previousMillis=0;
long interval=3000;
int pingpong=0;
Servo barrera;

void esperando();
void trenllegando();
void trenpasando();

void setup(){
	pinMode(sem1, OUTPUT);
	pinMode(sem2, OUTPUT);
	barrera.attach(pinBarrera);
	barrera.write(SUBIDA);
	Serial.begin(9600);
}

void loop(){
	switch(estado){
		case ESPERANDO:
		esperando();
		break;
		case TRENLLEGANDO:
		trenllegando();
		break;
		case TRENPASANDO:
		trenpasando();
		break;
		case ERROR:
		
		break;
		default:
		break;
	}

}

void esperando(){
	/*if(Serial.available()){
		longitud = Serial.read();
		if(longitud>0){
			estado = TRENLLEGANDO;
			previousMillis=millis();
		}else estado = ERROR;
	}*/
	if(millis()-previousMillis>interval){
		estado=TRENLLEGANDO;
		previousMillis=millis();
	}
}

void trenllegando(){
	if(!millis()-previousMillis > interval){
		if((millis()-previousMillis)%100<50){
			digitalWrite(sem1,LOW);
			digitalWrite(sem2,HIGH);
		}else{
			digitalWrite(sem1,HIGH);
			digitalWrite(sem2,LOW);
		}
	}
}

void trenpasando(){
	return;
}