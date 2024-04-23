// PENDULO DE N NODOS 
int substeps=20;
float deltaTime=1.0/substeps;
int n=3;
int L=100;
node[]node=new node[n+1];
void setup() {
  int centerX=500;
  int centerY=400;
  size(1000, 800);
  node[0]=new node(centerX, centerY);
  for (int i=1; i<n+1; i++) {
    node[i]=new node(centerX+L, centerY-L*(i-1));
  }
}
void draw() {
  noFill();
  background(200);
  line(0, 400, 1000, 400);

  for (int i=1; i<n+1; i++) {
    show(i);
  }

  for (int i=0; i<substeps; i++) {
    game();
  }
}

void game() {
  for (int i=1; i<n+1; i++) {
    node[i].euclid(deltaTime);
    node[i].lockIn(deltaTime, node[i-1], L);
  }
}

void show(int i) {
  line(node[i].x, node[i].y, node[i-1].x, node[i-1].y);
  ellipse(node[i].x, node[i].y, 25, 25);
  //ellipse(node[i-1].x, node[i-1].y, L*2, L*2);
}

class node {
  float x, y, u, v;
  float G;
  public node(float x, float y) {
    this.x=x;
    this.y=y;
    this.u=0;
    this.v=0;
    G=1.0;
  }
  void euclid(float delta) {
    x+=delta*u;
    y+=delta*v;
    v+=delta*G;
  }
  float distance(node other) {
    float dx=this.x-other.x;
    float dy=this.y-other.y;
    return sqrt(dx*dx+dy*dy);
  }
  void lockIn(float delta, node other, float L) {
    float dx=this.x-other.x;
    float dy=this.y-other.y;
    float prevx=this.x;
    float prevy=this.y;
    float correction=L-distance(other);
    this.x+=correction*dx/distance(other);
    this.y+=correction*dy/distance(other);
    this.u+=(this.x-prevx)/delta;
    this.v+=(this.y-prevy)/delta;
  }
}
