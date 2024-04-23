public class particle {
  float x, y, vx, vy, ax, ay;
  int r;
  int cyinf=750;
  int cysup=50;
  int cizq=50;
  int cder=750;
  float mass=15;

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

  float distance(particle other) {
    return sqrt(pow(this.x-other.x, 2)+pow(this.y-other.y, 2));
  }

  void allowExtensionLink(particle other, float L, float mult, float tolerance, int timestep) {
    float distance=distance(other);
    if (distance>1 && distance>L) {
      float ejeX=(this.x-other.x)/distance;
      float ejeY=(this.y-other.y)/distance;
      float delta=L-distance;

      x+=ejeX*delta*tolerance/timestep;
      y+=ejeY*delta*tolerance/timestep;

      float mag=delta*mult;
      vx+=mag*ejeX;
      vy+=mag*ejeY;

    }
  }

  void rigidLink(particle other, float L, float tolerance, int timestep) {
    float distance=abs(distance(other));
    if ( distance>L) {
      float ejeX=(this.x-other.x)/distance;
      float ejeY=(this.y-other.y)/distance;
      float delta=L-distance;

      float prevx=x;
      float prevy=y;
      x+=ejeX*delta*tolerance/timestep;
      y+=ejeY*delta*tolerance/timestep;

      vx+=(x-prevx)*timestep*tolerance; 
      vy+=(y-prevy)*timestep*tolerance; 
    }
  }


  void interact(particle[]other, int max, float tolerance, int timestep) {
    for (int i=1; i<max; i++) {
      float distance=distance(other[i]);
      if (distance<r+other[i].r && distance>1) {
        float ejeColisionX=(this.x-other[i].x)/distance;
        float ejeColisionY=(this.y-other[i].y)/distance;
        float delta=r+other[i].r-distance;

        float prevx=x;
        float prevy=y;

        x+=ejeColisionX*delta*tolerance/timestep;
        y+=ejeColisionY*delta*tolerance/timestep;

        vx+=(x-prevx)*timestep*tolerance/mass;
        vy+=(y-prevy)*timestep*tolerance/mass;
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
    //constraint();
  }
  void refresh() {
    colorMode(HSB, 255);
    float shade=130-(int)255*sqrt(vx*vx+vy*vy)/40;
    fill((int)shade, 255, 255, 200);
    //fill(255,200);
    ellipse((int)x, (int)y, r*2, r*2);
  }
  void refresh(color shade) {
    colorMode(RGB);
    fill(shade, 200);
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
    mass/=r;
  }
}
