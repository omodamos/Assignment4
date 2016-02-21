import peasy.*;

PeasyCam cam;
PImage[] skybox;
int skyboxSize;

void skybox() {
  beginShape();  //front
  texture(skybox[0]);
  vertex(2000, -2000, 2000, 0, 0);
  vertex(2000, 2000, 2000, skyboxSize, 0);
  vertex(2000, 2000, -2000, skyboxSize, skyboxSize);
  vertex(2000, -2000, -2000, 0, skyboxSize);
  endShape();
  
  beginShape();  //back
  texture(skybox[1]);
  vertex(-2000, 2000, 2000, 0, 0);
  vertex(-2000, -2000, 2000, skyboxSize, 0);
  vertex(-2000, -2000, -2000, skyboxSize, skyboxSize);
  vertex(-2000, 2000, -2000, 0, skyboxSize);
  endShape();
  
  beginShape();  //left
  texture(skybox[2]);
  vertex(2000, 2000, 2000, 0, 0);
  vertex(-2000, 2000, 2000, skyboxSize, 0);
  vertex(-2000, 2000, -2000, skyboxSize, skyboxSize);
  vertex(2000, 2000, -2000, 0, skyboxSize);
  endShape();
  
  beginShape();  //right
  texture(skybox[3]);
  vertex(-2000, -2000, 2000, 0, 0);
  vertex(2000, -2000, 2000, skyboxSize, 0);
  vertex(2000, -2000, -2000, skyboxSize, skyboxSize);
  vertex(-2000, -2000, -2000, 0, skyboxSize);
  endShape();
  
  beginShape();  //top
  texture(skybox[4]);
  vertex(2000, 2000, 2000, 0, 0);
  vertex(2000, -2000, 2000, skyboxSize, 0);
  vertex(-2000, -2000, 2000, skyboxSize, skyboxSize);
  vertex(-2000, 2000, 2000, 0, skyboxSize);
  endShape();
  
  beginShape();  //bottom
  texture(skybox[5]);
  vertex(-2000, 2000, -2000, 0, 0);
  vertex(-2000, -2000, -2000, skyboxSize, 0);
  vertex(2000, -2000, -2000, skyboxSize, skyboxSize);
  vertex(2000, 2000, -2000, 0, skyboxSize);
  endShape();
}

void lights() {
  pointLight(255, 255, 220, 0, 0, 0);
}

void shapes() {
  emissive(#FFD700);
  sphere(10);  // sun
  
  pushMatrix();
  translate(100, 0, 0);
  emissive(0);
  fill(#B0C4DE);
  sphere(5);  // planet 1
  popMatrix();
  
  pushMatrix();
  translate(-150, 0, 70);
  emissive(30);
  fill(#CD6600);
  sphere(3);  // planet 2
  popMatrix();
  
  pushMatrix();
  translate(30, 0, 200);
  emissive(20);
  fill(#FFF5EE);
  sphere(4);  // planet 3
  popMatrix();
  
  pushMatrix();
  translate(-25, 0, -45);
  emissive(20);
  fill(#CDC0B0);
  sphere(2);  // planet 4
  popMatrix();
}

void setup() {
  size(800, 600, P3D);
  
  cam = new PeasyCam(this, 0, 0, 0, 100);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(500); 
  // ortho();
  skybox = new PImage[6];
  skybox[1] = loadImage("skybox8_front.png");
  skybox[0] = loadImage("skybox8_back.png");
  skybox[3] = loadImage("skybox8_left.png");
  skybox[2] = loadImage("skybox8_right.png");
  skybox[4] = loadImage("skybox8_top.png");
  skybox[5] = loadImage("skybox8_bottom.png");
  skyboxSize = 1024;
}

void draw() {
  background(255);
  noStroke();
  skybox();
  lights();
  shapes();
}