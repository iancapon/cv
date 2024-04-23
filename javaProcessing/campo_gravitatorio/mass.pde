class pointMass {
  float x, y, u, v, m, G, gx, gy;
  int radio;
  public pointMass(float x, float y, float m, int radio, float G) {
    this.x=x;
    this.y=y;
    this.m=m;
    u=0;
    v=0;
    this.G=G;
    gx=0;
    gy=0;
    this.radio=radio;
  }
  void field(pointMass[]array, int max, float delta) {
    gx=0;
    gy=0;
    for (int i=0; i<max; i++) {
      float dx=this.x-array[i].x;
      float dy=this.y-array[i].y;
      float distance=sqrt(dx*dx+dy*dy);
      if (distance>1) {
        gx+=-delta*(dx/distance)*G*array[i].m/(this.m*distance*distance);
        gy+=-delta*(dy/distance)*G*array[i].m/(this.m*distance*distance);
      }
    }
  }

  void euclid(float delta) {
    u+=gx*delta;
    v+=gy*delta;
    x+=u*delta;
    y+=v*delta;
  }

  void show() {
    float shade=130-(int)255*sqrt(u*u+v*v)/5;
    fill(shade, 255, 255);
    int px=(int)x+1920/2;
    int py=(int)y+1080/2;

    ellipse(px, py, radio*2, radio*2);
  }
  void show(color shade) {

    int px=(int)x+1920/2;
    int py=(int)y+1080/2;
    fill(shade);
    ellipse(px, py, radio*2, radio*2);
  }

  void interact(pointMass[]other, int max, float restitucion, float delta) {
    for (int i=1; i<max; i++) {
      float dx=this.x-other[i].x;
      float dy=this.y-other[i].y;
      float distance=sqrt(dx*dx+dy*dy);
      if (distance<radio+other[i].radio && distance>1) {
        float ejeColisionX=(dx)/distance;
        float ejeColisionY=(dy)/distance;

        float prevx=x;
        float prevy=y;

        x+=ejeColisionX*delta*restitucion/delta;
        y+=ejeColisionY*delta*restitucion/delta;

        u+=(x-prevx)*delta*restitucion/this.m;
        v+=(y-prevy)*delta*restitucion/this.m;
      }
    }
  }

  void consMomento(pointMass[]other, int max, float e, float delta) {
    for (int i=1; i<max; i++) {
      float dx=this.x-other[i].x;
      float dy=this.y-other[i].y;
      float distance=sqrt(dx*dx+dy*dy);
      if (distance<radio+other[i].radio && distance>1) {
        float ejeX=(dx)/distance;
        float ejeY=(dy)/distance;
        float v1=sqrt(this.u*this.u+this.v+this.v);
        float v2=sqrt(other[i].u*other[i].u+other[i].v+other[i].v);
        
        x+=ejeX*delta*e/delta;
        y+=ejeY*delta*e/delta;
        
        float du = delta*(this.m*v1*ejeX + other[i].m*v2*ejeX - other[i].m*e*(v1*ejeX-v2*ejeX))/((this.m+other[i].m));
        float dv= delta*(this.m*v1*ejeY + other[i].m*v2*ejeY - other[i].m*e*(v1*ejeY-v2*ejeY))/((this.m+other[i].m));
        
        u+=du/m;
        v+=dv/m;
        
        other[i].u-=du/other[i].m;
        other[i].v-=dv/other[i].m;
        
      }
    }
  }
}
