int top=1000;
int cap=15;
int []level=new int[top];
int place=0;
int fase=0;
player player;
int substeps=4;
float delta=1.0/substeps;
int jump=0;
void setup() {
  size(800, 700);
  generate();
  player=new player();
}
void draw() {
  background(0);
  display();
  fase+=2;
  ellipse(player.x-10, player.y, 20, 40);
  for (int i=0; i<substeps; i++) {
    player.euler(delta);
    player.colision(delta);
  }
  if (player.x<0) {
    player.x=500;
    player.y=100;
  }
}

void display() {
  for (int i=0; i<9; i++) {
    int point=(i+place)%top;
    int x=i*100-fase;
    int y=level[point]*10;
    rect(x, 700-y, 100, y);
  }
  if (fase>100) {
    fase=0;
    place+=1;
  }
}

void generate() {
  for (int i=0; i<top; i++) {
    level[i]=(int)random(0, 30);
    if (level[i]<cap) level[i]=cap;
  }
}

void keyPressed() {
  float intensity=8;
  if (jump==1) {
    player.v-=intensity;
  }
}

class player {
  float x, y, u, v, p, q;
  public player() {
    this.x=350;
    this.y=100;
    this.u=0;
    this.v=0;
    this.p=0;//horizontal  acc
    this.q=1.0/4;//vertical acc;
  }
  void euler(float delta) {
    u+=p*delta;
    v+=q*delta;

    x+=u*delta;
    y+=v*delta;
    if(v>15)v=15;
  }

  void colision(float delta) {
    int arrPos=(int)((fase+x)/100)+place;

    float deltaY=this.y+20 - 700 +level[arrPos]*10;

    if (deltaY>0 && deltaY<=2) {
      float oldY=this.y;
      this.y-=deltaY;
      this.v=0.1*(this.y-oldY)/delta;
      jump=1;
    } else {
      jump=0;
    }
    if (deltaY>2 ) {
      this.x-=2;
    }
  }
}
