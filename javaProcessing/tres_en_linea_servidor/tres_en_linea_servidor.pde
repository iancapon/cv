import processing.net.*;
lugar[]lugar=new lugar[9];
int myTeam=1;
int turn=1;
Server jugador1;
int scrx=600;int scry=800;

void setup() {
  size(600, 800);
  strokeWeight(8);
  stroke(255);
  noFill();
  rectMode(CENTER);
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {
      lugar[i+j*3]=new lugar(i, j);
    }
  }
  jugador1 = new Server(this, 9999, "192.168.0.185");
}
void draw() {
  background(200);
  line(scrx/3, scrx/15, scrx/3, scrx+scrx/15);
  line(2*scrx/3, scrx/15, 2*scrx/3, scrx+scrx/15);
  line(scrx/15, scrx/3+scrx/15, scrx-scrx/15, scrx/3+scrx/15);
  line(scrx/15, 2*scrx/3+scrx/15, scrx-scrx/15, 2*scrx/3+scrx/15);
  textSize((scrx/15));
  if(turn==myTeam){text("Your turn...",(scrx/30),scrx+(scrx/6));}
  else {text("Not your turn...",(scrx/30),scrx+(scrx/6));}
  for (int i=0; i<9; i++)lugar[i].show();
  if (turn!=myTeam) {
    Client jugador2= jugador1.available();
    if (jugador2!=null) {
      byte[] buffer=new byte[2];
      jugador2.readBytesUntil(-1, buffer);
      byte dataIn=buffer[0];
      println("dataIn:"+dataIn);
      lugar[(int)dataIn].v=2;//notMyTeam
      turn=myTeam;
    }
  }
  lugar sign=new lugar(2,3);
  sign.v=myTeam;
  sign.show();
}
void mouseReleased() {
  if (turn==myTeam) {
    for (int i=0; i<9; i++) {
      if (lugar[i].insert(myTeam)) {
        byte []dataOut={(byte)i, -1};
        jugador1.write(dataOut);
        println("dataOut:"+(byte)i);
        turn=2;//notMyTeam
        break;
      }
    }
  }
}
class lugar {
  int x, y, v;
  public lugar(int x, int y) {
    this.x=x;
    this.y=y;
    this.v=0;
  }
  void show() {
    int x=this.x*(scrx/3)+(scrx/6);
    int y=this.y*(scrx/3)+(scrx/15)+(scrx/6);
    if (v==1) {
      ellipse(x, y, 2*(scrx/15), (scrx/6));
    }
    if (v==2) {
      line(x-(scrx/15), y-(scrx/15), x+(scrx/15), y+(scrx/15));
      line(x-(scrx/15), y+(scrx/15), x+(scrx/15), y-(scrx/15));
    }
  }

  boolean insert(int v) {
    boolean condition=false;
    int x=(int)(mouseX)/(scrx/3);
    int y=(int)(mouseY-(scrx/15))/(scrx/3);
    if (this.v==0 && this.x==x && this.y==y) {
      this.v=v;
      condition=true;
    }
    return condition;
  }
}
