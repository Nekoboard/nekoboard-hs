#include <Arduino.h>

extern "C" {
#include "copilot.h"
}

#define ROWS 9
#define COLUMNS 5

extern "C" {

byte matrixState[COLUMNS][ROWS];
void scan_matrix();

bool check_pin_pair();
void example_trigger();

} // extern "C"

static const byte RowPins[ROWS]       = { 9, 8, 7, 6, 5, 4, 3, A1, A2 };
static const byte ColumnPins[COLUMNS] = { 10, 16, 14, 15, A0 };


void setup()
{
	pinMode(3, INPUT);
	pinMode(4, OUTPUT);
	digitalWrite(4, HIGH);

	Keyboard.begin();
	Serial.begin(9600);
}

void loop()
{
	step(); // copilot
	delay(100);
}

bool check_pin_pair()
{
	return digitalRead(3);
}

void example_trigger()
{
	Serial.write(".");
}
