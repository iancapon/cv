class block {
  float x, y, z, l;
  object[]array=new object[7];
  PShape up, left, right;
  color c;
  int type;
  public block(float x, float y, float z, float l, color c, int type) {
    this.x=x;
    this.y=y;
    this.z=z;
    this.l=l;
    array[0]=new object(x, y, z+l);
    array[1]=new object(x+l, y, z+l);
    array[2]=new object(x, y+l, z+l);
    array[3]=new object(x+l, y+l, z+l);
    array[4]=new object(x+l, y, z);
    array[5]=new object(x, y+l, z);
    array[6]=new object(x+l, y+l, z);
    this.c=c;
    this.type=type;
  }

  void renderBlock() {
    if (type!=0) {
      if (type==1) {
        //fill(c);
        fill(200);
        up=createShape();
        fill(255);
        left=createShape();
        fill(100);
        right=createShape();
      }
      if (type==2) {
        stroke(0, 0, 255);
        noFill();
        up=createShape();
        left=createShape();
        right=createShape();
      }

      up.beginShape();///// cara superior
      up.vertex(array[0].posx, array[0].posy);
      up.vertex(array[1].posx, array[1].posy);
      up.vertex(array[3].posx, array[3].posy);
      up.vertex(array[2].posx, array[2].posy);
      up.endShape(CLOSE);

      left.beginShape();///// cara inferior izquierda
      left.vertex(array[2].posx, array[2].posy);
      left.vertex(array[3].posx, array[3].posy);
      left.vertex(array[6].posx, array[6].posy);
      left.vertex(array[5].posx, array[5].posy);
      left.endShape(CLOSE);

      right.beginShape();///// cara inferior derecha
      right.vertex(array[1].posx, array[1].posy);
      right.vertex(array[3].posx, array[3].posy);
      right.vertex(array[6].posx, array[6].posy);
      right.vertex(array[4].posx, array[4].posy);
      right.endShape(CLOSE);

      shape(up, 0, 0);

      shape(left, 0, 0);

      shape(right, 0, 0);
    }
  }


  void update(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
    updatePointObjects();
  }

  void updatePointObjects() {
    array[0].update(x, y, z+l);
    array[1].update(x+l, y, z+l);
    array[2].update(x, y+l, z+l);
    array[3].update(x+l, y+l, z+l);
    array[4].update(x+l, y, z);
    array[5].update(x, y+l, z);
    array[6].update(x+l, y+l, z);
  }
}
