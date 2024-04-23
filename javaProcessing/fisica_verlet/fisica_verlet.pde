int wid=21;
int hei=10;
int max=wid*hei;
int timestep=10;
int cyinf=750;
int cder=900;
int cizq=50;
particle[]ball=new particle[max];
void setup() {
  size(1000, 700);
  for (int i=0; i<wid; i++) {
    for (int j=0; j<hei; j++) {
      ball[i+j*wid]=new particle(400+i*35, 50+j*35, 10);//(int)random(5,20));
      ball[i+j*wid].gravity(0.5);
    }
  }
  rectMode(CENTER);
}

void draw() {
  backframe();
  colorMode(HSB, 255);
  for (int j=0; j< timestep; j++) {
    substep();
  }
  for (int i=0; i<max; i++) {
    ball[i].refresh();
  }
}

void substep() {
  int k=1;

  fix(ball[0], 400-300, 60);
  fix(ball[10], 750-300, 60);
  fix(ball[20], 1100-300, 60);
  if (mousePressed)fix(ball[wid*(hei-1)+4], mouseX, mouseY);

  for (int j=0; j<hei-1; j++) {
    for (int i=0; i<wid-1; i++) {
      interlink(ball[i+j*wid], ball[i+1+j*wid], 35, timestep, k);
      interlink(ball[i+j*wid], ball[i+j*wid+wid], 35, timestep, k);
    }
    interlink(ball[wid-1+j*wid], ball[wid-1+j*wid+wid], 35, timestep, k);
  }
  for (int i=0; i<wid-1; i++) {
    int j=hei-1;
    interlink(ball[i+j*wid], ball[i+1+j*wid], 35, timestep, k);
  }
  
  for (int i=0; i<max; i++) {
    ball[i].update(timestep);
  }
}

void interlink(particle one, particle two, int space, int timestep, int k) {
  if (k!=0) {
    two.specialLink(one, space, 1.0/k, timestep);
    one.specialLink(two, space, 1.0/k, timestep);
  } else {
    two.rigidLink(one, space, timestep);
    one.rigidLink(two, space, timestep);
  }
  //strokeWeight(0.5);
  //stroke(255);
  //line(one.x, one.y, two.x, two.y);
}

void fix(particle p, int x, int y) {
  p.x=x;
  p.y=y;
  p.vx=0;
  p.vy=0;
}
void backframe() {
  colorMode(RGB);
  background(69, 179, 157 );
  strokeWeight(2);
  stroke(255);

  line(cizq, 50, cizq, cyinf);
  line(cizq, 50, cder, 50);
  line(cizq, cyinf, cder, cyinf);
  line(cder, 50, cder, cyinf);
  noStroke();
}
