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
unsigned int longitud;
int previousMillis=0;
long interval=5000;
int pingpong=0;
Servo barrera;

void esperando();
void trenllegando();
void trenpasando();
void semControl();
void semApagar();

void setup(){
	pinMode(sem1, OUTPUT);
	pinMode(sem2, OUTPUT);
	barrera.attach(pinBarrera);
	barrera.write(SUBIDA);
	Serial.begin(9600);
	Serial.println("ESPERANDO");
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
	if(Serial.available()){
		longitud = Serial.read();
		Serial.println(longitud,DEC);
		if(longitud>0){
			estado = TRENLLEGANDO;
			Serial.println("TRENLLEGANDO");
                        Serial.println(millis(),DEC);
			previousMillis=millis();
		}else estado = ERROR;
	}
}

void trenllegando(){
	if(millis()-previousMillis <= interval){
		semControl();
	}else{
		semControl();
		barrera.write(BAJADA);
		estado=TRENPASANDO;
		Serial.println("TRENPASANDO");
                Serial.println(millis(),DEC);
		previousMillis=millis();
	}
}

void trenpasando(){
	if(millis()-previousMillis <= longitud*100){
		semControl();
	}else if(millis()-previousMillis <= (longitud*100+2000)){
		barrera.write(SUBIDA);
		semControl();
	}else{
		semApagar();
		estado=ESPERANDO;
		Serial.println("ESPERANDO");
                Serial.println(millis(),DEC);
	}
}

void semControl(){
	if(millis()%200<100){
		digitalWrite(sem1,LOW);
		digitalWrite(sem2,HIGH);
	}else{
		digitalWrite(sem1,HIGH);
		digitalWrite(sem2,LOW);
	}
}

void semApagar(){
	digitalWrite(sem1,LOW);
	digitalWrite(sem2,LOW);
}
