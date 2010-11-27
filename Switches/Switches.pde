/*
  DigitalReadSerial
 Reads a digital input on pin 2, prints the result to the serial monitor 
 
 This example code is in the public domain.
 */

void setup() {
  Serial.begin(9600);
}

void loop() {
  int v = analogRead(0);
  if(v>730){
    Serial.println("Soy el boton 1 (SW1_AN0)!");
    Serial.println(v, DEC);
    delay(200);
  }else if(v>485){
    Serial.println("Soy el boton 2 (SW1_AN1)!");
    Serial.println(v, DEC);
    delay(200);
  }else if(v>240){
    Serial.println("Soy el boton 3 (SW1_AN2)!");
    Serial.println(v, DEC);
    delay(200);
  }

}



