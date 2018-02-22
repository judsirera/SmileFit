
#define analogInPin A0  

int value = 0;       

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600);
}

void loop() {
  value = (int) analogRead(analogInPin);

  Serial.println(value);

  delay(2);
}
