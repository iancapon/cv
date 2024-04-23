int Max=5;
int max=3+Max;
float G=0.01;
pointMass[]array=new pointMass[max];
int substep=10;
//NAVE
float x=0;
float y=-300;
int fx=1920;
int fy=1080;

void setup() {
  size(1920, 1080);
  
  array[0]=new pointMass(x, y, 1, 3, G);
  array[1]=new pointMass(x-5, y+20, 1, 3, G);
  array[2]=new pointMass(x+5, y+20, 1, 3, G);
  for(int i=3; i<max; i++){
    array[i]=new pointMass(random(-2000,2000), random(-2000,2000), 100000, 200, G);
  }
  //array[3]=new pointMass(-400, 100, 100000, 100, G);
  //array[4]=new pointMass(+400, -100, 100000, 100, G);

  float v=sqrt(G*100000/(abs(y)))*1;
  //for (int i=1; i<max; i++) {
  //  array[i].u=v*(array[i].y/sqrt(array[i].x*array[i].x+array[i].y*array[i].y));
  //  array[i].v=-v*(array[i].x/sqrt(array[i].x*array[i].x+array[i].y*array[i].y));
  //}
  noStroke();
}



void gameloop() {
  float delta=1/(float)substep;
  interlinkRigid(array[0], array[1], 1.03*20, 1, substep);
  interlinkRigid(array[0], array[2], 1.03*20, 1, substep);
  interlinkRigid(array[2], array[1], 10, 1, substep);
  for (int i=0; i<max; i++) {
    //if(i!=1 || i!=2)
    array[i].field(array, max);
  }
  for (int i=3; i<max; i++) {
    array[0].bounce(array[i], 200, 0.8, substep);
    array[1].bounce(array[i], 200, 0.8, substep);
    array[2].bounce(array[i], 200, 0.8, substep);
  }
  for (int i=0; i<3; i++) {
    array[i].euclid(delta);
  }
  if( keyPressed){
      if (key==CODED){
      if (keyCode==UP){aim(0.1);}
      if (keyCode==LEFT){rotation(-0.1/2);}
      if (keyCode==RIGHT){rotation(0.1/2);}
      }
    }
}

float mass=100;

void draw() {
  background(0);
  for (int t=0; t<substep; t++) {
    gameloop();
  }
  PVector A=new PVector(array[0].x,array[0].y);
  PVector B=new PVector(array[1].x,array[1].y);
  PVector C=new PVector(array[2].x,array[2].y);
  PVector aim=new PVector(-2*A.x+B.x+C.x,-2*A.y+B.y+C.y);
  for (int i=0; i<max; i++) {
    array[i].show(color(255), fx-(int)(array[0].x+aim.x/4)*2,fy-(int)(array[0].y+aim.y/4)*2);
  }
  rect(0,0,30,mass*540/100);
}


void interlinkRigid(pointMass one, pointMass two, float space, float tolerance, int timestep) {
  two.rigidLink(one, space, tolerance, timestep);
  one.rigidLink(two, space, tolerance, timestep);
}

void rotation(float rate){
  float u=0;
  float v=0;
  //PVector A=new PVector(array[0].x,array[0].y);
  PVector B=new PVector(array[1].x,array[1].y);
  PVector C=new PVector(array[2].x,array[2].y);
  PVector aim=new PVector(B.x-C.x,B.y-C.y);
  aim.normalize();
  u+=aim.x*rate/(float)substep;
  v+=aim.y*rate/(float)substep;
  //for (int i=2; i<max; i++) {
    array[0].u+=-u;
    array[0].v+=-v;
    array[1].u+=u/2;
    array[1].v+=v/2;
    array[2].u+=u/2;
    array[2].v+=v/2;
    
    //ellipse((rate/abs(rate))*aim.x*15+fx/2,fy/2,5,5);
  //}
}

void aim(float acc) {
  if(mass>10){
    float u=0;
    float v=0;
    PVector A=new PVector(array[0].x,array[0].y);
    PVector B=new PVector(array[1].x,array[1].y);
    PVector C=new PVector(array[2].x,array[2].y);
    PVector aim=new PVector(-2*A.x+B.x+C.x,-2*A.y+B.y+C.y);
    aim.normalize();
    u+=(90/mass)*aim.x*acc/(float)substep;
    v+=(90/mass)*aim.y*acc/(float)substep;
    for (int i=1; i<max; i++) {
      array[i].u+=-u;
      array[i].v+=-v;
    }
    colorMode(RGB);
    fill(255,0,0);
    //ellipse(aim.x*25+array[0].x+fx/2,aim.y*25+array[0].y+fy/2,10,10);
    ellipse((60/mass)*aim.x*20+fx/2,(60/mass)*aim.y*20+fy/2,10,10);
    ellipse((60/mass)*aim.x*27+fx/2,(60/mass)*aim.y*27+fy/2,7,7);
    ellipse((60/mass)*aim.x*35+fx/2,(60/mass)*aim.y*35+fy/2,5,5);
    mass-=0.1/substep;
  }
}
