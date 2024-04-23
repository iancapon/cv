int p=20;
int q=20;
int r=20;
block[][][] block=new block[p][q][r];
player jugador1;
cursor cursor;

int substeps=5;
float tick=(float)1.0/substeps;
void setup() {
  size(800, 800);
  jugador1=new player(20, 20, 200);
  cursor=new cursor(0, 0, 0);
  for (int i=0; i<p; i++) {
    for (int j=0; j<q; j++) {
      for (int k=0; k<r; k++) {
        int t=1;
        if (k>0 )t=0;
        block[i][j][k]=new block(i*20, j*20, k*20, 20, 255, t);
      }
    }
  }
  for (int i=0; i<15; i++) {
    for (int j=0; j<15; j++) {
      block[i][j][1].type=1;
    }
  }
  for (int i=0; i<5; i++) {
    for (int j=0; j<5; j++) {
      block[i][j][2].type=1;
      block[i][j][3].type=1;
    }
  }
}

void draw() {
  noStroke();
  background(0);
  for (int n=0; n< substeps; n++) {
    //gameloop();
  }
  for (int i=0; i<p; i++) {
    for (int j=0; j<q; j++) {
      for (int k=0; k<r; k++) {
        block[i][j][k].renderBlock();
      }
    }
  }
  //jugador1.renderPlayer(block);
  cursor.renderCursor();
  cursor.move(block);
}



void gameloop() {
  jugador1.integrate(tick);

  int zdist= jugador1.collide(tick, block);
  println(zdist);
  float vel=0.5;
  if (keyPressed) {
    float X=0;
    float Y=0;
    float Z=0;
    if (key==CODED) {
      if (keyCode==UP) {
        X=-vel/tick;
      }
      if (keyCode==DOWN) {
        X=vel/tick;
      }
      if (keyCode==LEFT) {
        Y=vel/tick;
      }
      if (keyCode==RIGHT) {
        Y=-vel/tick;
      }
      //jugador1.integrate(tick);
    }
    //if (key==' ' ) {
    //  if ( zdist==0) {
    //    Z=5;
    //  }
    //}
    jugador1.u=X;
    jugador1.v=Y;
    //jugador1.w=Z;
  }
}

void keyReleased() {
  jugador1.u=0;
  jugador1.v=0;
  jugador1.w=0;
}
/*void keyPressed() {
 int X=0;
 int Y=0;
 int Z=0;
 if (key==CODED) {
 if (keyCode==UP) {
 X=-10;
 }
 if (keyCode==DOWN) {
 X=10;
 }
 if (keyCode==LEFT) {
 Y=10;
 }
 if (keyCode==RIGHT) {
 Y=-10;
 }
 }
 if (key==' ' && jugador1.z==41) {
 Z=20;
 }
 jugador1.u=X;
 jugador1.v=Y;
 jugador1.w=Z;
 }*/
