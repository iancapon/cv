int deg=36;
int lay=10;
int max=deg*lay;
pointMass[]array=new pointMass[max];
int substep=10;
void setup() {
  size(1920, 1080);
  float G=0.1;

  array[max-1]=new pointMass(0, 0, 10000, 20, G);
  for (int k=0; k<deg; k++) {
    for (int j=0; j<lay; j++) {
      int i=k+j*deg;
      float v=sqrt(G*10000/(10*(j+10)));
      v*=0.01;
      float px=( 10*(j+10)*cos(radians(k*10)));
      float py=( 10*(j+10)*sin(radians(k*10)));
      //array[i]=new pointMass(random(1920*2)-1920, random(1080*2)-1080, random(0.1, 2));

      array[i]=new pointMass(px, py, 1, 5, G);
      array[i].u=v*(array[i].y/sqrt(array[i].x*array[i].x+array[i].y*array[i].y));
      array[i].v=-v*(array[i].x/sqrt(array[i].x*array[i].x+array[i].y*array[i].y));
    }
  }
}

void gameloop() {
  float delta=1.0/(float)substep;

  for (int i=0; i<max; i++) {
    array[i].field(array, max,1);
  }
  for (int i=0; i<max; i++) {
    array[i].euclid(delta);
  }
  for (int i=0; i<max; i++) {
    array[i].interact(array, max, 1, delta);
  }
}
void draw() {
  background(0);
  //fill(255, 200);
  noStroke();
  colorMode(HSB, 400);

  for (int t=0; t<substep; t++) {
    gameloop();
  }
  for (int i=0; i<max-1; i++) {
    array[i].show();
  }
  colorMode(RGB);
  array[max-1].show(color(255, 255, 0));
}
