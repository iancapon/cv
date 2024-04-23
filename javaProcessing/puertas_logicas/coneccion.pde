class outlet {
  int x, y, size;
  outlet []conn=new outlet[10];
  int pointer=0;
  boolean value;
  boolean connected;
  int shade=255;
  int outIndex,nodeIndex;
  public outlet(int x, int y, int size, int oi, int ni) {
    this.x=x;
    this.y=y;
    this.size=size;
    this.connected=false;
    this.value=false;
    this.outIndex=oi;
    this.nodeIndex=ni;
  }
  void show() {
    if (value)shade=255;
    else shade=100;
    fill(shade, 100, 100);
    rect(x, y, size, size);
    stroke(0);
    if (connected) {
      stroke(255, 0, 0);
      this.value=false;
      for (int i=0; i<pointer; i++) {
        linea_ort(x, y, conn[i].x, conn[i].y);
        this.value=conn[i].value|this.value;
        //text("pnum:"+pointer+" out:"+outIndex,x-50,y-5);
      }
    }
    stroke(0);
  }
  
  void linea_ort(float x0,float y0,float x1,float y1){
    float distx=x1-x0;
    
    line(x0,y0,x0+distx/2,y0);
    line(x0+distx/2,y0, x0+distx/2,y1);
    line(x0+distx/2,y1,x1,y1);
  }

  void coneccion(outlet P) {
    conn[pointer]=P;
    connected=true;
    this.value=P.value|this.value;
    pointer++;
    
  }



  boolean grabbed() {
    boolean ret=false;
    if (mouseButton==LEFT) {
      int targetX=x-size/2;
      int targetY=y-size/2;
      if (mouseX>targetX && mouseX<targetX+size && mouseY>targetY && mouseY<targetY+size) {
        ret=true;
      }
    }

    return ret;
  }

  boolean move() {
    boolean ret=false;
    if (grabbed()) {
      x=mouseX;
      y=mouseY;
      ret=true;
    }
    return ret;
  }
}
