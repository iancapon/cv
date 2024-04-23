void drawBoard(color white, color black, int[]tablero, PImage[]piezas) {
  noStroke();
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      fill(white);
      if ((i+j)%2==1) {
        fill(black);
      }
      rect(i*sqrSize, j*sqrSize, sqrSize, sqrSize);
      if (tablero[i+j*8]>0) {
        image(piezas[tablero[i+j*8]-1], i*sqrSize, j*sqrSize, sqrSize, sqrSize);
      }
    }
  }
}

void drawPossible(int[] valid) {////le paso el valid<arr> de la pieza que quiero ver
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (valid[i + j * 8] > 0) {
        if(valid[i+j*8]==1)
          stroke(0,0,255);
         if(valid[i+j*8]==2 || valid[i+j*8]==4 || valid[i+j*8]==5)
           stroke(200,200,0);
         if(valid[i+j*8]==3)
           stroke(255,0,0);
        noFill();
        ellipse((i+0.5)*sqrSize,(j+0.5)*sqrSize,sqrSize/2,sqrSize/2);
      }
    }
  }
}

void setupPiezas(PImage[] tab) {
  
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
void setupTablero(int[]board) {
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (j==1 )board[i+j*8]=5+1;
      if (j==6)board[i+j*8]=4+1;
    }
  }
  board[0]=1+1;
  board[7]=1+1;
  board[0+7*8]=0+1;
  board[7+7*8]=0+1;
  board[1]=11+1;
  board[6]=11+1;
  board[1+7*8]=10+1;
  board[6+7*8]=10+1;
  board[2]=9+1;
  board[5]=9+1;
  board[2+7*8]=8+1;
  board[5+7*8]=8+1;
  board[3]=3+1;
  board[4]=7+1;
  board[3+7*8]=2+1;
  board[4+7*8]=6+1;
}
