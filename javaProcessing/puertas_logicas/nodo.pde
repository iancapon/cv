class nodo {
  int x, y;
  int size;
  int type;
  int shade=0;
  int index;
  outlet []outlet=new outlet[4];
  public nodo(int x, int y, int size, int type, int index) {
    this.x=x;
    this.y=y;
    this.size=size;
    this.type=type;
    outlet[0]=new outlet(x+size/2+5, y, 10, 0, index);
    outlet[1]=new outlet(x-size/2-5, y-size/3, 10, 1, index);
    outlet[2]=new outlet(x-size/2-5, y+size/3, 10, 2, index);
    outlet[3]=new outlet(x-size/2-5, y, 10, 3, index);
    this.index=index;
  }

  void truth() {
    if (type==0) {
      boolean v=outlet[0].value;
      if (v) {
        shade=8;
      } else {
        shade=0;
      }
    }//value
    if (type==1) {
      shade=1;
    }//buffer
    if (type==2) {
      shade=2;
      boolean v=outlet[3].value;
      outlet[0].value=!v;
    }//not
    if (type==3) {
      shade=3;
      boolean a=outlet[1].value;
      boolean b=outlet[2].value;
      outlet[0].value=a|b;
    }//or
    if (type==4) {
      shade=4;
      boolean a=outlet[1].value;
      boolean b=outlet[2].value;
      outlet[0].value=a&b;
    }//and
    if (type==5) {
      shade=5;
      boolean a=outlet[1].value;
      boolean b=outlet[2].value;
      outlet[0].value=a|b;
      if (a&b)
        outlet[0].value=false;
    }//xor
    if (type==6) {
      boolean v=outlet[3].value;
      if (v)shade=7;
      else shade=6;
    }//output
  }
  void show() {
    fill(255);
    rect(x, y, size, size);
    image(fotos[shade], x-size/2, y-size/2, size, size);

    //output
    outlet[0].x=x+size/2+5;
    outlet[0].y=y;

    //input A
    outlet[1].x=x-size/2-5;
    outlet[1].y=y-size/3;

    //input B
    outlet[2].x=x-size/2-5;
    outlet[2].y=y+size/3;

    //input lonely
    outlet[3].x=x-size/2-5;
    outlet[3].y=y;

    if (type<6)
      outlet[0].show();

    if (type==6 || type==1 || type==2)
      outlet[3].show();

    if (type>2 && type<6) {
      outlet[1].show();
      outlet[2].show();
    }
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
