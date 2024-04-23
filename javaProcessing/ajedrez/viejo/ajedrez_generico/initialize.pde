void drawBoard(int sqrSize, color black) {
  noStroke();
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      fill(255);
      if ((i+j)%2==1) {
        //fill(135, 201, 90 );
        fill(black);
      }


      rect(i*sqrSize, j*sqrSize, sqrSize, sqrSize);
    }
  }
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (board[i+j*8].piece>0) {
        if (!rotateOff) {
          image(flipImage((i+j)%2,black, tab[board[i+j*8].piece-1], 60, 60), (i)*sqrSize, (j)*sqrSize, sqrSize, sqrSize);
        } else {
          image(tab[board[i+j*8].piece-1], i*sqrSize, j*sqrSize, sqrSize, sqrSize);
        }
      }
    }
  }
}

PImage flipImage(int fondo,color black, PImage sujeto, int w, int h) {
  PImage nueva=createImage(w, h, RGB);
  sujeto.loadPixels();
  nueva.loadPixels();
  for (int i=0; i<w; i++) {
    for (int j=0; j<h; j++) {
      int x=w-i-1;
      int y=h-j-1;
      nueva.pixels[i+j*h]=sujeto.pixels[x+y*h];//color(alpha(sujeto.pixels[x+y*h]));
      if (alpha(nueva.pixels[i+j*h])<10) {
        if (fondo==0)
          nueva.pixels[i+j*h]=color(255);
        else
          nueva.pixels[i+j*h]=color(black);
      }
    }
  }

  nueva.updatePixels();
  return nueva;
}

void initBoard() {
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      board[i+j*8]=new sqr(i, j);
    }
  }
  tab[0]=loadImage("piezas/torre_blanca.png");
  tab[1]=loadImage("piezas/torre_negra.png");
  tab[2]=loadImage("piezas/reina_blanca.png");
  tab[3]=loadImage("piezas/reina_negra.png");
  tab[4]=loadImage("piezas/peon_blanco.png");
  tab[5]=loadImage("piezas/peon_negro.png");
  tab[6]=loadImage("piezas/rey_blanco.png");
  tab[7]=loadImage("piezas/rey_negro.png");
  tab[8]=loadImage("piezas/alfil_blanco.png");
  tab[9]=loadImage("piezas/alfil_negro.png");
  tab[10]=loadImage("piezas/caballo_blanco.png");
  tab[11]=loadImage("piezas/caballo_negro.png");
}

void setBoard() {
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (j==1 )board[i+j*8].piece=5+1;
      if (j==6)board[i+j*8].piece=4+1;
    }
  }
  board[0].piece=1+1;
  board[7].piece=1+1;
  board[0+7*8].piece=0+1;
  board[7+7*8].piece=0+1;
  board[1].piece=11+1;
  board[6].piece=11+1;
  board[1+7*8].piece=10+1;
  board[6+7*8].piece=10+1;
  board[2].piece=9+1;
  board[5].piece=9+1;
  board[2+7*8].piece=8+1;
  board[5+7*8].piece=8+1;
  board[3].piece=3+1;
  board[4].piece=7+1;
  board[3+7*8].piece=2+1;
  board[4+7*8].piece=6+1;
  //if (!rotateOff) {
  //  board[3].piece=7+1;
  //  board[4].piece=3+1;
  //  board[3+7*8].piece=6+1;
  //  board[4+7*8].piece=2+1;
  //}
}
