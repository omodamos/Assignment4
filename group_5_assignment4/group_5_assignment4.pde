import peasy.*;
import ddf.minim.*;

PeasyCam cam;
float camZoom;

Minim minim; // audio context
AudioPlayer player;

PImage[] skybox;
int skyboxSize;

Asteroid[] asteroids1;
Asteroid[] asteroids2;

PImage flare;
int flareSize;
/*
void intro(int time) {
  float alpha = (1-time/10000)*255;
  fill(#000000, alpha);
  rect(0,0, width, height);
}
*/
void skybox() {
  beginShape();  //back
  texture(skybox[0]);
  vertex(camZoom, -camZoom, camZoom, 0, 0);
  vertex(camZoom, camZoom, camZoom, skyboxSize, 0);
  vertex(camZoom, camZoom, -camZoom, skyboxSize, skyboxSize);
  vertex(camZoom, -camZoom, -camZoom, 0, skyboxSize);
  endShape();
  
  beginShape();  //front
  texture(skybox[1]);
  vertex(-camZoom, camZoom, camZoom, 0, 0);
  vertex(-camZoom, -camZoom, camZoom, skyboxSize, 0);
  vertex(-camZoom, -camZoom, -camZoom, skyboxSize, skyboxSize);
  vertex(-camZoom, camZoom, -camZoom, 0, skyboxSize);
  endShape();
  
  beginShape();  //right
  texture(skybox[2]);
  vertex(camZoom, camZoom, camZoom, 0, 0);
  vertex(-camZoom, camZoom, camZoom, skyboxSize, 0);
  vertex(-camZoom, camZoom, -camZoom, skyboxSize, skyboxSize);
  vertex(camZoom, camZoom, -camZoom, 0, skyboxSize);
  endShape();
  
  beginShape();  //left
  texture(skybox[3]);
  vertex(-camZoom, -camZoom, camZoom, 0, 0);
  vertex(camZoom, -camZoom, camZoom, skyboxSize, 0);
  vertex(camZoom, -camZoom, -camZoom, skyboxSize, skyboxSize);
  vertex(-camZoom, -camZoom, -camZoom, 0, skyboxSize);
  endShape();
  
  beginShape();  //top
  texture(skybox[4]);
  vertex(camZoom, camZoom, camZoom, 0, 0);
  vertex(camZoom, -camZoom, camZoom, skyboxSize, 0);
  vertex(-camZoom, -camZoom, camZoom, skyboxSize, skyboxSize);
  vertex(-camZoom, camZoom, camZoom, 0, skyboxSize);
  endShape();
  
  beginShape();  //bottom
  texture(skybox[5]);
  vertex(-camZoom, camZoom, -camZoom, 0, 0);
  vertex(-camZoom, -camZoom, -camZoom, skyboxSize, 0);
  vertex(camZoom, -camZoom, -camZoom, skyboxSize, skyboxSize);
  vertex(camZoom, camZoom, -camZoom, 0, skyboxSize);
  endShape();
}

void lights() {
  pointLight(255, 220, 220, 0, 0, 0);
  ambientLight(100, 100, 140);
}

void flares() {
  float[] camRotation = cam.getRotations();
  pushMatrix();
  rotateX(camRotation[0]);
  rotateY(camRotation[1]);
  rotateZ(camRotation[2]);
  translate(-flareSize/2, -flareSize/2, 0);
  image(flare, 0, 0);
  popMatrix();
}

void shapes() {
  emissive(#FF7300);
  sphere(20);  // sun
  emissive(0);
  for(int i=0; i<asteroids1.length; i++) {
    asteroids1[i].render();
  }
  for(int j=0; j<asteroids2.length; j++) {
    asteroids2[j].render();
  }
}

class OrbitingObject {
  float radius;  // orbital radius
  float angle;  // angle along orbit path
  float angularVelocity; // speed of asteroid in radians/frame
  float inclination; // maximum orbit offset on Z-axis
  
  OrbitingObject(float rad, float incline, float vel) {
    radius = rad;
    angle = random(0, 2*PI);
    inclination = incline;
    angularVelocity = vel;
  }
  
  OrbitingObject(float rad, float incline, float vel, float ang) {
    radius = rad;
    angle = ang;
    inclination = incline;
    angularVelocity = vel;
  }
  
  // moves object along orbit
  void prograde() {
    angle += angularVelocity;
    if (angle > 2*PI) {
      angle = 0;
    }
    translate(radius*cos(angle), radius*sin(angle), inclination*cos(angle));
  }
}

class Asteroid extends OrbitingObject {
  int size;
  float[] rotation;  // XYZ rotation
  int rotationAxis;  // 0=X-axis, 1=Y-axis, 2=Z-axis
  
  Asteroid(int s, float rad, float incline, float vel) {
    super(rad, incline, vel);
    size = s;  
    rotation = new float[] {random(0.0, PI), random(0.0, PI), random(0.0, PI)};
    rotationAxis = (int)random(0,3);
  }
  
  void spin() {
    if (rotationAxis==0) {
      rotation[0] += 0.01;
      if (rotation[0] > 2*PI) {
        rotation[0] = 0;
      }
    }
    if (rotationAxis==1) {
      rotation[1] += 0.01;
      if (rotation[1] > 2*PI) {
        rotation[1] = 0;
      }
    }
    if (rotationAxis==2) {
      rotation[2] += 0.01;
      if (rotation[2] > 2*PI) {
        rotation[2] = 0;
      }
    }
    rotateX(rotation[0]);
    rotateY(rotation[1]);
    rotateZ(rotation[2]);
  }
  
  void render() {
    fill(#AFA79A);
    pushMatrix();
    prograde();
    spin();
    box(size);
    popMatrix();
  }
}

void setup() {
  size(800, 600, P3D);
  
  // Camera setup
  cam = new PeasyCam(this, 0, 0, 0, 500);
  cam.setMinimumDistance(150);
  cam.setMaximumDistance(1000); 
  cam.setWheelScale(0.01);

  // Skybox setup
  skybox = new PImage[6];
  skybox[0] = loadImage("skybox7_back.png");
  skybox[1] = loadImage("skybox7_front.png");
  skybox[2] = loadImage("skybox7_right.png");
  skybox[3] = loadImage("skybox7_left.png");
  skybox[4] = loadImage("skybox7_top.png");
  skybox[5] = loadImage("skybox7_bottom.png");
  skyboxSize = skybox[0].width;
  
  // Asteroids setup
  asteroids1 = new Asteroid[32];
  for(int i=0; i<asteroids1.length; i++) {
    asteroids1[i] = new Asteroid((int)random(4,6), random(100,110), 0.0, 0.005);
  }
  asteroids2 = new Asteroid[64];
  for(int j=0; j<asteroids2.length; j++) {
    asteroids2[j] = new Asteroid((int)random(2,4), random(180,190), 100.0, 0.002);
  }

  // Flare setup
  flare = loadImage("sun_glow.png");
  flareSize = flare.width;
  
  // Audio setup
  minim = new Minim(this);
  player = minim.loadFile("music.mp3", 2048);
  player.loop();
}

void draw() {
  noStroke();
  background(255);
  camZoom = 2.0 * (float)cam.getDistance();
  skybox();
  lights();
  shapes();
  flares();
}