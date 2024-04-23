int timestep=10;
particle[]point=new particle[4];

void setup() {
  size(800, 800);
  rectMode(CENTER);
  for (int i=0; i< 4; i++) {
    point[i]=new particle(0, 0, 10);
    point[i].gravity(1.0/1);
  }
  
  point[0].x=400;
  point[0].y=595+100;
  point[1].x=400-50;
  point[1].y=350+50;
  point[2].x=0;
  point[2].y=0;
}

float travel=0;
float press=1;
float volum=0;
float temp=300;


void draw() {
  backframe();
  fill(255);
  line(0, 400, 800, 400);
  line(400, 0, 400, 800);
  ellipse(400, 400, 100, 100);
  fill(press*2000000);
  rect(400,650,80,100);
  fill(255);
  rect(400,point[0].y,80,10);
  line(point[0].x, point[0].y, point[1].x, point[1].y);

  for (int i=0; i<2; i++) {
    point[i].refresh(255);
  }
  for (int i=0; i< timestep; i++) {
    gameloop();
  }
}

void gameloop(){
  temp=100-abs(mouseX-400);
  fill(255,0,0);
  rect(mouseX,800,50,50);
  tempCst(1/1);
  //eje
  point[2].x=400;
  point[2].y=400;
  point[2].vx=0;
  point[2].vy=0;
  interlinkRigid(point[1],point[2],50,1,timestep);
  //piston
  point[0].x=400;
  point[0].vx=0;
  interlinkRigid(point[0],point[1],595-350,1,timestep);
  travel=595-point[0].y;
  //fuerza/masas
  point[0].vy+=-press*(PI*50*50)/2;
  if(point[0].y<590)point[0].y=590;
  
  
  //
  for(int i=0; i<4;i++){
    point[i].update(timestep);
  }
  
}
void volumCst(float k){
  //volum=(100-travel)*PI*50*50;
  press=temp*k/volum;
  temp=press*volum*k;
}

void pressCst(float k){
  volum=(100-travel)*PI*50*50;
  //press=temp*k/volum;
  temp=press*volum*k;
}

void tempCst(float k){
  volum=(100-travel)*PI*50*50;
  press=temp*k/volum;
  //temp=press*volum*k;
}

//void stepDraw() {
//  point[1].y=400;
//  point[2].y=400;
//  //rotaSolo();
//  libre();
//  for (int i=0; i<3; i++) {
//    point[i].update(timestep);
//  }
//  interlinkRigid(point[0], point[1], 150, 1, timestep);
//  //interlinkSpring(point[1], point[2], 100, 1.0, timestep);
//}
//void libre() {
//  interlinkRigid(point[0], point[3], 70, 1, timestep);
//}
//void rotaSolo() {
//  point[0].x=80*cos(tita)+200;
//  point[0].y=80*sin(tita)+400;
//  tita+=4/(10*3.14*timestep);
//}

void interlinkRigid(particle one, particle two, int space, float tolerance, int timestep) {
  two.rigidLink(one, space, tolerance, timestep);
  one.rigidLink(two, space, tolerance, timestep);
}

void interlinkSpring(particle one, particle two, int space, float constant, int timestep) {
  two.springLink(one, space, constant, timestep);
  one.springLink(two, space, constant, timestep);
}




void backframe() {
  colorMode(RGB);
  background(69, 179, 157 );
}
