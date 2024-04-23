class Cursor {
  int x, y, piece, sqrSize;
  int hand;
  int prevX, prevY, prevPiece;
  public Cursor(int x, int y, int sqrSize) {
    this.x=x;
    this.y=y;
    this.piece=0;
    this.sqrSize=sqrSize;
    this.hand=0;
  }

  int keyState=0;
  void move(sqr[]array) {
    boolean keyReleased=false;
    if (mousePressed && keyState==0) {
      if (mouseButton==LEFT)
        keyState=1;
    }
    if (!mousePressed && keyState==1) {
      keyReleased=true;
    }
    /////////////////////////////////
    if (keyReleased) {
      if (!rotateOff) {
        x=7-(int)mouseX/sqrSize ;
        y=7-(int)mouseY/sqrSize ;
      } else {
        x=(int)mouseX/sqrSize ;
        y=(int)mouseY/sqrSize ;
      }
      piece=array[x+y*8].piece;
      ////////////////////////////////GRAB
      if (hand==0 && !multiplayer) {
        hand=2;
        prevPiece=piece;
        prevX=x;
        prevY=y;
      }
      if (hand==0 && multiplayer && turn==team) {
        hand=2;
        prevPiece=piece;
        prevX=x;
        prevY=y;
      }
      ////////////////////////////////MOVE
      if (hand==1 && validMove(prevX, prevY, x, y) && !multiplayer) {
        array[x+y*8].piece=prevPiece;
        array[prevX+prevY*8].piece=0;
        hand=0;
        if (turn==1)turn=2;
        if (turn==0)turn=1;
        if (turn==2)turn=0;
        if(flag!=0){
          calculateFlag();
          flag=0;
        }
        sonido.play();
      }
      if (hand==1 && validMove(prevX, prevY, x, y) && multiplayer && turn==team) {
        array[x+y*8].piece=prevPiece;
        array[prevX+prevY*8].piece=0;
        hand=0;
        if (turn==1)turn=2;
        if (turn==0)turn=1;
        if (turn==2)turn=0;
        if(flag!=0){
          calculateFlag();
        }
        dataOutBuffer[0]=byte(prevX+prevY*8);
        dataOutBuffer[1]=byte(x+y*8);
        dataOutBuffer[2]=(byte)flag;
        flag=0;
        writeOutData();
        dataOutBuffer[0]=-1;
        dataOutBuffer[1]=(byte)-1;
        dataOutBuffer[2]=(byte)0;
        sonido.play();
      }
      if (hand==1 && !validMove(prevX, prevY, x, y)) {
        hand=0;
      }
      //////////////////////RESET AUX
      if (hand==2)hand=1;
      keyState=0;
    }
  }

  void signal() {
    if (hand==1) {
      noFill();
      stroke(0, 0, 255);
      /*if (!rotateOff) {
        x=7-x;
        y=7-y;
        prevX=7-prevX;
        prevY=7-prevY;
      }*/
      ellipse(x*sqrSize+sqrSize/2, y*sqrSize+sqrSize/2, sqrSize, sqrSize);
      validMove(prevX, prevY, x, y);
    }
  }
}
