int max=300;
int timestep=10;
int cyinf=750;
int cder=750;
particle[]ball=new particle[max];

void setup() {
  size(800, 800);
  rectMode(CENTER);
  
  for (int i=0; i<max; i++) {
    ball[i]=new particle(random(200,400), random(200,400), (int)random(5,20));//(int)random(5,20));
    ball[i].gravity(0.1);
  }
  ball[0].x=400;
  ball[0].y=400;
  ball[0].r=300;
}

void draw() {
  backframe();
  ball[0].refresh(0);
  for (int j=0; j< timestep/1; j++) {
    stepDraw();
  }
  
  for (int i=1; i<max; i++) {
    ball[i].refresh();
  }
}

void stepDraw() {
  ball[0].x=400;
  ball[0].y=400;
  for (int i=1; i<max; i++) {
    ball[i].interact(ball, max, 0.9, timestep);
    ball[i].rigidLink(ball[0], 300-15, 1, timestep);
  }
  for (int i=1; i<max; i++) {
    ball[i].update(timestep);
  }
  
}

void interlink(particle one, particle two, int space, float mult, float tolerance, int timestep){
  two.rigidLink(one, space, tolerance, timestep);
  one.rigidLink(two, space, tolerance, timestep);
}




void backframe() {
  colorMode(RGB);
  background(69, 179, 157 );
  strokeWeight(2);
  stroke(255);

  line(50, 50, 50, cyinf);
  line(50, 50, cder, 50);
  line(50, cyinf, cder, cyinf);
  line(cder, 50, cder, cyinf);
  noStroke();
}
