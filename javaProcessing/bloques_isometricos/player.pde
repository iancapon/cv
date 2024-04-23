public class player {
  float x, y, z, u, v, w, g;
  object pos;
  public player(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
    this.u=0;
    this.v=0;
    this.w=0;
    this.g=-0.5;
    pos=new object(x, y, z);
  }
  void integrate(float delta) {
    this.w+=delta*this.g;
    this.x+=delta*this.u;
    this.y+=delta*this.v;
    this.z+=delta*this.w;
    this.pos.update(this.x, this.y, this.z);
  }
  boolean isBlock(int x, int y, int z, block[][][]array) {
    boolean ret=false;
    if (x>-1 && y>-1 && z>-1 && x<20 && y<20 && z<20) {
      if (array[x][y][z].type!=0) {
        ret=true;
      }
    }
    return ret;
  }
  void renderPlayer(block[][][]array) {
    int bx=(int)x/20;//rayo saliendo de la pos de la camara
    int by=(int)y/20;
    int bz=(int)z/20;
    boolean visible=true;
    while (bx<20 || by<20 || bz<20) {
      if (isBlock(bx, by, bz, array)) {
        visible=false;
        break;
      }
      bx++;
      by++;
      bz++;
    }
    stroke(0, 0, 255);
    fill(0, 0, 255);
    if (!visible) {
      //block[bx][by][bz].renderBlock();
      noFill();
    }
    ellipse(pos.posx, pos.posy+15, 10, 10);
  }
  int collide(float delta, block[][][]array) {
    int bx=(int)x/20;
    int by=(int)y/20;
    int bz=(int)z/20;
    int zdist=0;
    int zsign=int(w/abs(w));
    while (isBlock(bx, by, bz+zsign, array)) {
      zdist++;
      bz++;
    }
    bz=(int)z/20;
    if (true && zdist<2) {
      float prevz=z;
      zsign=-1;
      if (isBlock(bx, by, bz+zsign, array) && x>0 && y>0) {
        z+=(10)*delta;
        w=(prevz-z+0.2)/delta;
      }
    } else {
      w=0;
      if (abs(u)>0) {
        float prevx=x;
        int xsign=-1;
        if(u>0)xsign=1;
        if (isBlock(bx+xsign, by, bz, array)) {
          x+=-xsign*10*delta;
          u=(prevx-x)/delta;
        }
      }
      if (abs(v)>0) {
        float prevy=y;
        int ysign=-1;
        if(v>0)ysign=1;
        if (isBlock(bx, by+ysign, bz, array)) {
          y+=-ysign*10*delta;
          u=(prevy-x)/delta;
        }
      }
    }
    
    return zdist;
  }
}
