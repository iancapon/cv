int substep=1;
int num=6;
int timeskip=1;

float G=6*pow(10, -5);
float AU=75*10;
particle[]planetas=new particle[num];

void setup() {
  size(800, 800);

  planetas[0]=new particle(0, 0, 2*pow(10, 7), G, substep);//sol

  planetas[1]=new particle(AU, 0, 5*pow(10, 0), G, substep);//tierra
  planetas[1].tint=color(4, 247, 152 );
  planetas[1].vy=0.63*55.1;

  planetas[2]=new particle(AU*0.722, 0, 5*pow(10, 0), G, substep);//venus
  planetas[2].tint=color(249, 217, 108 );
  planetas[2].vy=0.63*55.1;

  planetas[3]=new particle(AU*1.52, 0, 6.5*pow(10, -1), G, substep);//marte
  planetas[3].tint=color(255, 151, 47 );
  planetas[3].vy=0.63*55.1;

  planetas[4]=new particle(AU*0.39, 0, 3.3*pow(10, -1), G, substep);//mercurio
  planetas[4].tint=color(191, 191, 187);
  planetas[4].vy=0.63*55.1;
  
  planetas[5]=new particle(AU*5.2, 0, 1.9*pow(10, 3), G, substep);//jupiter
  planetas[5].tint=color(255, 188, 90);
  planetas[5].vy=0.63*55.1;
  
  background(0);
}
void draw() {
  background(0);
  noFill();
  stroke(255);
  ellipse(400, 400, 0.2*AU, 0.2*AU);//tierra
  ellipse(400, 400, 0.2*0.722*AU, 0.2*0.722*AU);//venus
  ellipse(400, 400, 0.2*1.52*AU, 0.2*1.52*AU);//marte
  ellipse(400, 400, 0.2*0.39*AU, 0.2*0.39*AU);//mercurio
  ellipse(400, 400, 0.2*5.2*AU, 0.2*5.2*AU);//jupiter
  noStroke();

  bucle();
  for (int i=0; i<num; i++) {
    planetas[i].refresh();
  }
}

void bucle() {
  for (int n=0; n<substep; n++) {
    for (int j=0; j<num; j++) {
      planetas[j].superpose(planetas, num, 1);
    }
    for (int i=0; i<num; i++) {
      planetas[i].calculate(1);
    }
  }
}
