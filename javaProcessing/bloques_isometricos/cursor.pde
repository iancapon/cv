class cursor{
  int x,y,z;
  block b;
  public cursor(int x,int y,int z){
    this.x=x;
    this.y=y;
    this.z=z;
    b=new block(x*20,y*20,z*20,20,0,2);
  }
  void renderCursor(){
    b.update(x*20,y*20,z*20);
    b.renderBlock();
  }
  
  int keyState=0;
  int keycode=0;
  void move(block[][][]array){
    boolean keyReleased=false;
    if(keyPressed && keyState==0){
      if(key==CODED){
        if(keyCode==UP)keycode=0;
        if(keyCode==DOWN)keycode=1;
        if(keyCode==LEFT)keycode=2;
        if(keyCode==RIGHT)keycode=3;
      }
      else{
        if(key=='+')keycode=4;
        if(key=='-')keycode=5;
        if(key=='q')keycode=6;
        if(key=='e')keycode=7;
      }
      keyState=1;
    }
    if (!keyPressed && keyState==1){
      keyReleased=true;
    }
    /////////////////////////////////
    if (keyReleased){
      switch(keycode){
        case 0:
        y--;
        break;
        case 1:
        y++;
        break;
        case 2:
        x--;
        break;
        case 3:
        x++;
        break;
        case 4:
        z++;
        break;
        case 5:
        z--;
        break;
        case 6:
        array[x][y][z].type=1;
        break;
        case 7:
        array[x][y][z].type=0;
        break;
      }
      keyState=0;
    }
  }
}
