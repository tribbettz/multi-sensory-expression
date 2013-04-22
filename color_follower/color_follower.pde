
// button size
float bsize; 

void setup() {
  size(750,750);
  bsize=.05*width;
  
  smooth();
  background(0);
  fill(255,255,255);
  rect(0,0,bsize,bsize);
  mouseX=width/2;
  mouseY=height/2;
}

void draw() {
  // RGB values
  float red = random(200,255);
  float green = random(100,150);
  float blue = random(0,200);
  // Circle values
  float radius = random(50);
  float scale = random(2);
  
  if (scale<1) {
    scale = random(1) * scale;
  }
  fill(red, green, blue);
  ellipse(mouseX, mouseY, scale*radius, scale*radius);
  
  if ((mouseX<bsize) && (mouseX>0) && (mouseY<bsize) && (mouseY>0)){
    clear();
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
