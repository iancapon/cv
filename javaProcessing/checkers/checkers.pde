int w=8;
int h=8;
pieza[]pieza=new pieza[w*h];
char turno=0;//0:rojo ; 1:blanco
char miTeam=0;

import processing.net.*;
Server servidor;

void setup() {
  size(840, 640);
  placeCheckers();
  servidor=new Server(this, 9999, "192.168.0.185");
  hand=new pieza(0, 0, 0, 0, 0);
}

pieza hand;
int handState=0;
char turn=0;
void draw() {
  background(200, 0, 0);
  fill(0);
  textSize(20);
  text("ROJO", 650, 20);
  if (turno!=miTeam) {
    text("NO ES TU TURNO", 650, 40);
  }
  drawBoard();
  for (int i=0; i<w*h; i++) {
    pieza[i].show();
  }

  if (handState==1) {
    noFill();
    stroke(0, 0, 255);
    strokeWeight(2);
    ellipse(int(mouseX/80)*80+40, int(mouseY/80)*80+40, 70, 70);
  }
  stroke(0);
  strokeWeight(1);

  Client cliente=servidor.available();
  fill(0, 0, 255);
  if (cliente!=null) {
    fill(0, 255, 0);
    byte[] buffer=new byte[6];
    if (turno!=miTeam) {//Si no es mi turno
      int bytecount = cliente.readBytesUntil(-1, buffer);
      println("byteCount:"+bytecount);
      if (bytecount==6) {
        println("move");
        println(buffer[0]+":"+buffer[1]+":"+buffer[2]+":"+buffer[3]+":");
        int index=(int)buffer[0]+h*(int)buffer[1];
        hand=pieza[index];
        pieza[index].pick=1;
        index=(int)buffer[2]+h*(int)buffer[3];
        if (valid(hand, (int)buffer[2], (int)buffer[3], true)) {
          pieza[index].value=hand.value;
          pieza[index].team=hand.team;
          pieza[hand.index].reset();
        }
      }
    }
  }
  ellipse(800, 550, 40, 40);
}

Boolean valid(pieza hand, int ix, int iy, boolean overpass) {
  boolean condition=false;
  if (turno==miTeam || overpass) {
    if (hand.team==0 && turno==0) {
      if (hand.y-iy==1 && abs(hand.x-ix)==1) {
        condition=true;
      }
      if (hand.y-iy==2 && abs(hand.x-ix)==2) {
        int indexEaten=(iy+1)*h + ((int)(hand.x-ix)/abs(hand.x-ix)) + ix;
        if (pieza[indexEaten].value>0 && pieza[indexEaten].team==1 ) {
          condition=true;
          pieza[indexEaten].reset();
        }
      }
    }
    if (hand.team==1 && turno==1) {
      if (-hand.y+iy==1 && abs(hand.x-ix)==1) {
        condition=true;
      }
      if (-hand.y+iy==2 && abs(hand.x-ix)==2) {
        int indexEaten=(iy-1)*h + ((int)(hand.x-ix)/abs(hand.x-ix)) + ix;
        if (pieza[indexEaten].value>0 && pieza[indexEaten].team==0 ) {
          condition=true;
          pieza[indexEaten].reset();
        }
      }
    }
  }
  if (condition) {
    if (turno==0)turno=2;
    if (turno==1)turno=0;
    if (turno==2)turno=1;
  }
  return condition;
}


void mouseReleased() {
  int ix=(int)mouseX/80;
  int iy=(int)mouseY/80;
  int index=ix+iy*h;
  if (ix<8 && (ix+iy)%2!=0) {

    if (handState==0) {

      if (pieza[index].value>0) {
        hand=pieza[index];
        pieza[index].pick=1;
        handState=2;
      }
    }
    if (handState==1) {
      if (pieza[index].value<1 && valid(hand, ix, iy, false)) {
        pieza[index].value=hand.value;
        pieza[index].team=hand.team;
        pieza[hand.index].reset();
        handState=0;
        byte[]byteArray={(byte)hand.x, (byte)hand.y, (byte)ix, (byte)iy, (byte)turn, -1};
        //Client cliente=servidor.available();
        if (servidor.active() ) {
          servidor.write(byteArray);
        }
      } else {
        pieza[hand.index].pick=0;
        handState=0;
      }
    }
    if (handState==2) {
      handState=1;
    }
  }
}

void placeCheckers() {
  for (int i=0; i<w; i++) {
    for (int j=0; j<h; j++) {
      int team=1;
      int k=0;
      if ((i+j)%2!=0 && j!=3 && j!=4) {
        if (j>4) {
          team=0;
        }
        k=1;
      }
      pieza[i+j*h]=new pieza(i, j, team, i+j*h, k);
    }
  }
}

void drawBoard() {
  fill(0);//black
  rect(0, 0, 640, 640);
  fill(240);//white
  for (int i=0; i<w; i++) {
    for (int j=0; j<h; j++) {
      if ((i+j)%2==0) {
        rect(i*80, j*80, 80, 80);
      }
    }
  }
}
