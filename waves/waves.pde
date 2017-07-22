import processing.serial.*;

Serial arduino;  // serial port to arduino
int serialVal = 1;  // this variable saves serial reading
float inByte = 0;
int num = 20;
float step, sz, offSet, theta, angle;

void setup() {
  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  //println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  arduino = new Serial(this, Serial.list()[0], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  arduino.bufferUntil('\n');

  size(600, 400);
  strokeWeight(5);
  step = 22;
}

void draw() {
  background(20);
  translate(width/2, height*.75);
  angle=0;
  for (int i=0; i<num; i++) {
    stroke(255);
    noFill();
    sz = i*step;
    float offSet = TWO_PI/num*i;
    float arcEnd = map(sin(theta+offSet), -1, 1, 0, TWO_PI*inByte);
    arc(0, 0, sz, sz, PI, arcEnd);
  }
  colorMode(RGB);
  resetMatrix();
  theta += .0523;
}

void serialEvent (Serial arduino) {
  // get the ASCII string:
  String inString = arduino.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    inByte = float(inString);
    println(inByte);
    inByte = map(inByte, 0, 1023, 0.01, 1);
  }
}