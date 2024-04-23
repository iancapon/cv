public class particle {
  float x, y, m, vx, vy, cx, cy, G;
  float campo;
  int substep;
  color tint;//=new color(255,255,255);
  public particle(float x_, float y_, float m, float G, int substep) {
    cx=0;
    cy=0;
    vx=0;
    vy=0;
    x=x_;
    y=y_;
    this.m=m;
    this.G=G;
    campo=0;
    this.substep=substep;
    tint=color(255, 252, 40);
  }

  void arrow() {
    float len=sqrt(cx*cx+cy*cy);
    if (len==0)len=1;
    //float px=400+x/10;
    //float py=400+y/10;
    line(x, y, x+ 10*cx/len, y+ 10*cy/len);
  }

  void refresh() {
    float px=400+x/10;
    float py=400+y/10;
    fill(tint);
    //stroke(0);
    //line(px,py,400,400);
    //noStroke();
    ellipse(px, py, 10, 10);
    
  }

  void calculate(int timeskip) {
    vx+=cx/(substep);
    vy+=cy/(substep);
    x+=vx/(substep);
    y+=vy/(substep);
  }
  void superpose(particle[]array, int len, int timeskip) {
    this.cx=0;
    this.cy=0;
    for (int i=0; i< len; i++) {
      float dist=sqrt(pow(this.x-array[i].x, 2)+pow(this.y-array[i].y, 2));
      println(dist);
      if (dist>1) {
        campo=-G*array[i].m/(substep*pow(dist, 2)); // CAMPO=ACCELERACION=F(grav)/M(propia)
        cx+= campo*(this.x-array[i].x);
        cy+= campo*(this.y-array[i].y);
      }
    }
  }
}
