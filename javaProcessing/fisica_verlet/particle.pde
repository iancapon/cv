public class particle {
  float x, y, vx, vy, ax, ay;
  int r;
  int cyinf=1000;
  int cysup=-1000;
  int cizq=-1000;
  int cder=2000;

  float distance(particle other) {
    return sqrt(pow(this.x-other.x, 2)+pow(this.y-other.y, 2));
  }

  void specialLink(particle other, float L, float constant, int timestep) {//resistencia a estirarse
    float distance=distance(other);
    if (distance>1 && distance>L) {
      float ejeX=(this.x-other.x)/distance;
      float ejeY=(this.y-other.y)/distance;
      float delta=L-distance;
      delta*=constant;

      x+=ejeX*delta/timestep;
      y+=ejeY*delta/timestep;

      vx+=delta*ejeX/timestep;
      vy+=delta*ejeY/timestep;
    }
  }

  void softLink(particle other, float L, float constant, int timestep) { // resistencia a estirarse y contraerse
    float distance=distance(other);
    if (distance>1) {
      float ejeX=(this.x-other.x)/distance;
      float ejeY=(this.y-other.y)/distance;
      float delta=L-distance;
      delta*=constant;

      x+=ejeX*delta/timestep;
      y+=ejeY*delta/timestep;

      vx+=delta*ejeX/timestep;
      vy+=delta*ejeY/timestep;
    }
  }

  void rigidLink(particle other, float L, int timestep) { //dinamica de posicion asegurada (pero con resistencia a estirarse) 
    float distance=distance(other);
    if (distance>1 && distance>L) {
      float ejeX=(this.x-other.x)/distance;
      float ejeY=(this.y-other.y)/distance;
      float delta=L-distance;
      
      float prevx=x;
      float prevy=y;
      x+=ejeX*delta/timestep;
      y+=ejeY*delta/timestep;

      vx+=(x-prevx)*timestep;
      vy+=(y-prevy)*timestep;
    }
  }

  void interact(particle[]other, int max, float mult, float tolerance, int timestep) {
    for (int i=0; i<max; i++) {
      float distance=distance(other[i]);
      if (distance<r+other[i].r && distance>1) {
        float ejeColisionX=(this.x-other[i].x)/distance;
        float ejeColisionY=(this.y-other[i].y)/distance;
        float delta=r+other[i].r-distance;

        float prevx=x;
        float prevy=y;

        x+=ejeColisionX*delta*tolerance/timestep;
        y+=ejeColisionY*delta*tolerance/timestep;

        vx+=(x-prevx)*timestep*tolerance;
        vy+=(y-prevy)*timestep*tolerance;
      }
    }
  }

  void gravity(float g) {
    ay=g;
  }

  void update(float step) {//steps por segundo
    step=1/step;
    vx+=ax*step;
    vy+=ay*step;
    x+=vx*step;
    y+=vy*step;
    constraint();
  }
  void refresh() {
    colorMode(HSB, 255);
    float shade=130-(int)255*sqrt(vx*vx+vy*vy)/40;
    fill((int)shade, 255, 255, 200);
    ellipse((int)x, (int)y, r*2, r*2);
  }
  void refresh(color shade) {
    colorMode(RGB);
    fill(shade);
    ellipse((int)x, (int)y, r*2, r*2);
  }

  public particle(float x, float y, int r) {
    this.x=x;
    this.y=y;
    this.vx=0;
    this.vy=0;
    this.ax=0;
    this.ay=0;
    this.r=r;
  }

  void constraint() {
    if (x>cder-r) {
      float prevx=x;
      x=cder-r;
      vx+=(x-prevx)*timestep;
    }
    if (x<cizq+r) {
      float prevx=x;
      x=cizq+r;
      vx+=(x-prevx)*timestep;
    }
    if (y>cyinf-r) {
      float prevy=y;
      y=cyinf-r;
      vy+=(y-prevy)*timestep;
    }
    if (y<cysup+r) {
      float prevy=y;
      y=cysup+r;
      vy+=(y-prevy)*timestep;
    }
  }
}
