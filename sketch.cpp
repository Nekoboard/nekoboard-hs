#include <Arduino.h>

void setup()
{
	Serial.begin(9600);
}

void loop()
{
	Serial.write("Hello world!\n");
	delay(2000);
}