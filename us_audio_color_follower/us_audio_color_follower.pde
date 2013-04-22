

import processing.serial.*;
import ddf.minim.*;

Minim minim;
AudioInput in;

// button size
float bsize; 
Serial myPort;
String comPortString;
String[] comPortList;
int distance;

void setup() {
  size(750,750);
  bsize=.05*width;
  
  smooth();
  background(0);
  fill(255,255,255);
  rect(0,0,bsize,bsize);
  mouseX=width/2;
  mouseY=height/2;
  
 /*Open the serial port for communication with the Arduino
 Make sure the COM port is correct - I am using COM port 8 */
 myPort = new Serial(this, "/dev/tty.usbmodemfa131", 9600);
 myPort.bufferUntil('\n'); // Trigger a SerialEvent on new line
 
 minim = new Minim(this);
 in = minim.getLineIn(Minim.STEREO, 512);
}

void draw() {
  // RGB values
  float red = .4*100*255*in.mix.level();
  float green = .2*100*255*in.mix.level();
  float blue = .8*100*255*in.mix.level();
  fill(red, green, blue);
  
  if (distance > 125) {
    ellipse(random(.5*height, height), random(0, .5*width), 100, 100);
  }
  if (distance > 75 && distance <=125) {
    ellipse(random(.5*height, height), random(.5*width, width), 100, 100);
  }
  if (distance > 25 && distance <= 75) {
    ellipse(random(0, .5*height), random(.5*width, width), 100, 100);
  }
  if (distance <= 25) {
    ellipse(random(0, .5*height), random(0, .5*width), 100, 100);
  }

  if ((mouseX<bsize) && (mouseX>0) && (mouseY<bsize) && (mouseY>0)){
    clear();
  }
}

void serialEvent(Serial cPort) {
 comPortString = cPort.readStringUntil('\n');
 if(comPortString != null) {
 comPortString=trim(comPortString);
 /* Use the distance received by the Arduino to modify the y position
 of the first square (others will follow). Should match the
 code settings on the Arduino. In this case 200 is the maximum
 distance expected. The distance is then mapped to a value
 between 1 and the height of your screen */
 distance = int(map(Integer.parseInt(comPortString),1,200,0,200));
 if(distance<0){
 /*If computer receives a negative number (-1), then the
 sensor is reporting an "out of range" error. Convert all
 of these to a distance of 0. */
 distance = 0;
 }
 }
}

void clear() {
    fill(0,0,0);
    rect(0,0,width,height);
    fill(255,255,255);
    rect(0,0,bsize,bsize);
    mouseX=width/2;
    mouseY=height/2;
}

void stop()
{
  in.close();
  minim.stop();
  myPort.clear();
  myPort.stop();
  super.stop();
}
