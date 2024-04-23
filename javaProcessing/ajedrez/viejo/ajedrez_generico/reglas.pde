int flag=0;
boolean torreBlanca(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }
  ////////linea recta en x
  for (int i=px+1; i<8; i++) {
    inbounds(valid, i, py);
    if (board[i+py*8].piece%2==0 && board[i+py*8].piece!=0) {
      break;
    }
    if (board[i+py*8].piece%2==1) {
      valid[i][py]=0;
      break;
    }
  }
  for (int i=px-1; i>=0; i--) {
    inbounds(valid, i, py);
    if (board[i+py*8].piece%2==0 && board[i+py*8].piece!=0) {
      break;
    }
    if (board[i+py*8].piece%2==1) {
      valid[i][py]=0;
      break;
    }
  }

  ////////linea recta en y
  for (int j=py+1; j<8; j++) {
    inbounds(valid, px, j);
    if (board[px+j*8].piece%2==0 && board[px+j*8].piece!=0) {
      break;
    }
    if (board[px+j*8].piece%2==1) {
      valid[px][j]=0;
      break;
    }
  }
  for (int j=py-1; j>=0; j--) {
    inbounds(valid, px, j);
    if (board[px+j*8].piece%2==0 && board[px+j*8].piece!=0) {
      break;
    }
    if (board[px+j*8].piece%2==1) {
      valid[px][j]=0;
      break;
    }
  }



  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforWhiteSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforWhite(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
    }
  }

  return ret;
}

boolean torreNegra(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }
  ////////linea recta en x
  for (int i=px+1; i<8; i++) {
    inbounds(valid, i, py);
    if (board[i+py*8].piece%2==1) {
      break;
    }
    if (board[i+py*8].piece%2==0 && board[i+py*8].piece!=0) {
      valid[i][py]=0;
      break;
    }
  }
  for (int i=px-1; i>=0; i--) {
    inbounds(valid, i, py);
    if (board[i+py*8].piece%2==1) {
      break;
    }
    if (board[i+py*8].piece%2==0 && board[i+py*8].piece!=0) {
      valid[i][py]=0;
      break;
    }
  }

  ////////linea recta en y
  for (int j=py+1; j<8; j++) {
    inbounds(valid, px, j);
    if (board[px+j*8].piece%2==1) {
      break;
    }
    if (board[px+j*8].piece%2==0 && board[px+j*8].piece!=0) {
      valid[px][j]=0;
      break;
    }
  }
  for (int j=py-1; j>=0; j--) {
    inbounds(valid, px, j);
    if (board[px+j*8].piece%2==1) {
      break;
    }
    if (board[px+j*8].piece%2==0 && board[px+j*8].piece!=0) {
      valid[px][j]=0;
      break;
    }
  }



  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforBlackSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforBlack(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
    }
  }

  return ret;
}

boolean reinaBlanca(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }
  ////////linea recta en x
  for (int i=px+1; i<8; i++) {
    inbounds(valid, i, py);
    if (board[i+py*8].piece%2==0 && board[i+py*8].piece!=0) {
      break;
    }
    if (board[i+py*8].piece%2==1) {
      valid[i][py]=0;
      break;
    }
  }
  for (int i=px-1; i>=0; i--) {
    inbounds(valid, i, py);
    if (board[i+py*8].piece%2==0 && board[i+py*8].piece!=0) {
      break;
    }
    if (board[i+py*8].piece%2==1) {
      valid[i][py]=0;
      break;
    }
  }

  ////////linea recta en y
  for (int j=py+1; j<8; j++) {
    inbounds(valid, px, j);
    if (board[px+j*8].piece%2==0 && board[px+j*8].piece!=0) {
      break;
    }
    if (board[px+j*8].piece%2==1) {
      valid[px][j]=0;
      break;
    }
  }
  for (int j=py-1; j>=0; j--) {
    inbounds(valid, px, j);
    if (board[px+j*8].piece%2==0 && board[px+j*8].piece!=0) {
      break;
    }
    if (board[px+j*8].piece%2==1) {
      valid[px][j]=0;
      break;
    }
  }

  ////////esquina 1
  int ii=px+1;
  int jj=py+1;
  while (ii<8 && jj<8) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      break;
    }
    if (board[ii+jj*8].piece%2==1) {
      valid[ii][jj]=0;
      break;
    }
    ii++;
    jj++;
  }
  ////////esquina 2
  ii=px-1;
  jj=py-1;
  while (ii>=0 && jj>=0) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      break;
    }
    if (board[ii+jj*8].piece%2==1) {
      valid[ii][jj]=0;
      break;
    }
    ii--;
    jj--;
  }

  ////////esquina 3
  ii=px+1;
  jj=py-1;
  while (ii<8 && jj>=0) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      break;
    }
    if (board[ii+jj*8].piece%2==1) {
      valid[ii][jj]=0;
      break;
    }
    ii++;
    jj--;
  }
  ////////esquina 4
  ii=px-1;
  jj=py+1;
  while (ii>=0 && jj<8) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      break;
    }
    if (board[ii+jj*8].piece%2==1) {
      valid[ii][jj]=0;
      break;
    }
    ii--;
    jj++;
  }



  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforWhiteSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforWhite(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
    }
  }

  return ret;
}

boolean reinaNegra(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }
  ////////linea recta en x
  for (int i=px+1; i<8; i++) {
    inbounds(valid, i, py);
    if (board[i+py*8].piece%2==1) {
      break;
    }
    if (board[i+py*8].piece%2==0 && board[i+py*8].piece!=0) {
      valid[i][py]=0;
      break;
    }
  }
  for (int i=px-1; i>=0; i--) {
    inbounds(valid, i, py);
    if (board[i+py*8].piece%2==1) {
      break;
    }
    if (board[i+py*8].piece%2==0 && board[i+py*8].piece!=0) {
      valid[i][py]=0;
      break;
    }
  }

  ////////linea recta en y
  for (int j=py+1; j<8; j++) {
    inbounds(valid, px, j);
    if (board[px+j*8].piece%2==1) {
      break;
    }
    if (board[px+j*8].piece%2==0 && board[px+j*8].piece!=0) {
      valid[px][j]=0;
      break;
    }
  }
  for (int j=py-1; j>=0; j--) {
    inbounds(valid, px, j);
    if (board[px+j*8].piece%2==1) {
      break;
    }
    if (board[px+j*8].piece%2==0 && board[px+j*8].piece!=0) {
      valid[px][j]=0;
      break;
    }
  }
  ////////esquina 1
  int ii=px+1;
  int jj=py+1;
  while (ii<8 && jj<8) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==1) {
      break;
    }
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      valid[ii][jj]=0;
      break;
    }
    ii++;
    jj++;
  }
  ////////esquina 2
  ii=px-1;
  jj=py-1;
  while (ii>=0 && jj>=0) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==1) {
      break;
    }
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      valid[ii][jj]=0;
      break;
    }
    ii--;
    jj--;
  }

  ////////esquina 3
  ii=px+1;
  jj=py-1;
  while (ii<8 && jj>=0) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==1) {
      break;
    }
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      valid[ii][jj]=0;
      break;
    }
    ii++;
    jj--;
  }
  ////////esquina 4
  ii=px-1;
  jj=py+1;
  while (ii>=0 && jj<8) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==1) {
      break;
    }
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      valid[ii][jj]=0;
      break;
    }
    ii--;
    jj++;
  }


  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforBlackSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforBlack(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
    }
  }

  return ret;
}

boolean peonBlanco(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }

  if (inboundsCheck(px, py-1) && board[px+(py-1)*8].piece==0) {
    inbounds(valid, px, py-1);
    if (inboundsCheck(px, py-2) && board[px+(py-2)*8].piece==0 && py==6) {
      inbounds(valid, px, py-2);
    }
  }

  if (inboundsCheck(px-1, py-1) && board[px-1+(py-1)*8].piece%2==0 && board[px-1+(py-1)*8].piece!=0) {
    inbounds(valid, px-1, py-1);
  }
  if (inboundsCheck(px+1, py-1) && board[px+1+(py-1)*8].piece%2==0 && board[px+1+(py-1)*8].piece!=0) {
    inbounds(valid, px+1, py-1);
  }
  //else {
  //  if (inboundsCheck(px-1, py-1) && board[px-1+(py-1)*8].piece==0 && board[px-1+(py)*8].piece%2==0 && board[px-1+(py)*8].piece!=0) {
  //    inbounds(valid, px-1, py);
  //    //                            PEON AL PASO
  //  }
  //  if (inboundsCheck(px+1, py-1) && board[px+1+(py-1)*8].piece==0 && board[px+1+(py)*8].piece%2==0 && board[px+1+(py)*8].piece!=0) {
  //    inbounds(valid, px+1, py);
  //    //                            PEON AL PASO
  //  }
  //}


  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforWhiteSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforWhite(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
      //if (tx==px-1 && ty==py) {
      //  board[tx+(ty)*8].piece=0;
      //  board[px+(px)*8].piece=0;
      //  board[tx+(ty-1)*8].piece=5;
      //  //ret=false;
      //}
      //if (tx==px+1 && ty==py) {
      //  board[tx+(ty)*8].piece=0;
      //  board[px+(px)*8].piece=0;
      //  board[tx+(ty-1)*8].piece=5;
      //  //ret=false;
      //}

      if (ty==0) {
        board[tx+ty*8].piece=3;
      }
    }
  }

  return ret;
}

boolean peonNegro(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }

  if (inboundsCheck(px, py+1) && board[px+(py+1)*8].piece==0) {
    inbounds(valid, px, py+1);
    if (inboundsCheck(px, py+2) && board[px+(py+2)*8].piece==0 && py==1) {
      inbounds(valid, px, py+2);
    }
  }

  if (inboundsCheck(px-1, py+1) && board[px-1+(py+1)*8].piece%2==1 && board[px-1+(py+1)*8].piece!=0) {
    inbounds(valid, px-1, py+1);
  }
  if (inboundsCheck(px+1, py+1) && board[px+1+(py+1)*8].piece%2==1 && board[px+1+(py+1)*8].piece!=0) {
    inbounds(valid, px+1, py+1);
  }

  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforBlackSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforBlack(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
      if (ty==7) {
        board[tx+ty*8].piece=4;
      }
    }
  }

  return ret;
}

boolean reyBlanco(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }


  inbounds(valid, px, py-1);
  inbounds(valid, px-1, py-1);
  inbounds(valid, px+1, py-1);
  inbounds(valid, px-1, py);
  inbounds(valid, px+1, py);
  inbounds(valid, px, py+1);
  inbounds(valid, px-1, py+1);
  inbounds(valid, px+1, py+1);
  if (px==4 && py==7) {
    if (board[7+7*8].piece==1) {
      if (board[5+7*8].piece==0 && board[6+7*8].piece==0) {
        inbounds(valid, px+2, py);
        if(tx==px+2 && ty==py)
        flag=1;//enroque corto blanca
      }
    }
    if (board[0+7*8].piece==1) {
      if (board[3+7*8].piece==0 && board[2+7*8].piece==0 && board[1+7*8].piece==0) {
        inbounds(valid, px-3, py);
        if(tx==px-3 && ty==py)
        flag=2;//enroque largo blanca
      }
    }
  }


  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforWhiteSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforWhite(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
    }
  }
  return ret;
}

boolean reyNegro(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }

  inbounds(valid, px, py-1);
  inbounds(valid, px-1, py-1);
  inbounds(valid, px+1, py-1);
  inbounds(valid, px-1, py);
  inbounds(valid, px+1, py);
  inbounds(valid, px, py+1);
  inbounds(valid, px-1, py+1);
  inbounds(valid, px+1, py+1);
  
  if (px==4 && py==0) {
    if (board[7+0*8].piece==2) {
      if (board[5+0*8].piece==0 && board[6+0*8].piece==0) {
        inbounds(valid, px+2, py);
        if(tx==px+2 && ty==py)
        flag=3;//enroque corto negra
      }
    }
    if (board[0+0*8].piece==2) {
      if (board[3+0*8].piece==0 && board[2+0*8].piece==0 && board[1+0*8].piece==0) {
        inbounds(valid, px-3, py);
        if(tx==px-3 && ty==py)
        flag=4;//enroque largo negra
      }
    }
  }

  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforBlackSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforBlack(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
    }
  }

  return ret;
}

boolean alfilBlanco(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }
  ////////esquina 1
  int ii=px+1;
  int jj=py+1;
  while (ii<8 && jj<8) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      break;
    }
    if (board[ii+jj*8].piece%2==1) {
      valid[ii][jj]=0;
      break;
    }
    ii++;
    jj++;
  }
  ////////esquina 2
  ii=px-1;
  jj=py-1;
  while (ii>=0 && jj>=0) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      break;
    }
    if (board[ii+jj*8].piece%2==1) {
      valid[ii][jj]=0;
      break;
    }
    ii--;
    jj--;
  }

  ////////esquina 3
  ii=px+1;
  jj=py-1;
  while (ii<8 && jj>=0) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      break;
    }
    if (board[ii+jj*8].piece%2==1) {
      valid[ii][jj]=0;
      break;
    }
    ii++;
    jj--;
  }
  ////////esquina 4
  ii=px-1;
  jj=py+1;
  while (ii>=0 && jj<8) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      break;
    }
    if (board[ii+jj*8].piece%2==1) {
      valid[ii][jj]=0;
      break;
    }
    ii--;
    jj++;
  }



  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforWhiteSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforWhite(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
    }
  }

  return ret;
}

boolean alfilNegro(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }
  ////////esquina 1
  int ii=px+1;
  int jj=py+1;
  while (ii<8 && jj<8) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==1) {
      break;
    }
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      valid[ii][jj]=0;
      break;
    }
    ii++;
    jj++;
  }
  ////////esquina 2
  ii=px-1;
  jj=py-1;
  while (ii>=0 && jj>=0) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==1) {
      break;
    }
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      valid[ii][jj]=0;
      break;
    }
    ii--;
    jj--;
  }

  ////////esquina 3
  ii=px+1;
  jj=py-1;
  while (ii<8 && jj>=0) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==1) {
      break;
    }
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      valid[ii][jj]=0;
      break;
    }
    ii++;
    jj--;
  }
  ////////esquina 4
  ii=px-1;
  jj=py+1;
  while (ii>=0 && jj<8) {
    inbounds(valid, ii, jj);
    if (board[ii+jj*8].piece%2==1) {
      break;
    }
    if (board[ii+jj*8].piece%2==0 && board[ii+jj*8].piece!=0) {
      valid[ii][jj]=0;
      break;
    }
    ii--;
    jj++;
  }



  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforBlackSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforBlack(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
    }
  }

  return ret;
}

boolean caballoBlanco(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }
  inbounds(valid, px-2, py-1);
  inbounds(valid, px-1, py-2);
  inbounds(valid, px-2, py+1);
  inbounds(valid, px-1, py+2);
  inbounds(valid, px+1, py-2);
  inbounds(valid, px+2, py-1);
  inbounds(valid, px+2, py+1);
  inbounds(valid, px+1, py+2);

  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforWhiteSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforWhite(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
    }
  }

  return ret;
}

boolean caballoNegro(int px, int py, int tx, int ty) {
  boolean ret= false;
  int [][]valid=new int[8][8];
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      valid[i][j]=0;
    }
  }
  inbounds(valid, px-2, py-1);
  inbounds(valid, px-1, py-2);
  inbounds(valid, px-2, py+1);
  inbounds(valid, px-1, py+2);
  inbounds(valid, px+1, py-2);
  inbounds(valid, px+2, py-1);
  inbounds(valid, px+2, py+1);
  inbounds(valid, px+1, py+2);

  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (valid[i][j]==1 && checkValidforBlackSimple(i, j)) {
        noFill();
        stroke(0, 0, 255);
        ellipse(i*sqrSize+sqrSize/2, j*sqrSize+sqrSize/2, sqrSize/2, sqrSize/2);
      }
    }
  }

  if (checkValidforBlack(tx, ty)) {
    if (valid[tx][ty]==1) {
      ret=true;
    }
  }

  return ret;
}


boolean checkValidforWhiteSimple(int i, int j) {
  return board[i+j*8].piece%2==0 && board[i+j*8].piece!=8;
}
boolean checkValidforWhite( int tx, int ty) {
  return inboundsCheck(tx, ty)  && board[tx+ty*8].piece%2==0 && board[tx+ty*8].piece!=8;
}

boolean checkValidforBlackSimple(int i, int j) {
  return (board[i+j*8].piece%2==1 || board[i+j*8].piece==0) && board[i+j*8].piece!=7;
}
boolean checkValidforBlack( int tx, int ty) {
  return inboundsCheck(tx, ty)  && (board[tx+ty*8].piece%2==1 || board[tx+ty*8].piece==0) && board[tx+ty*8].piece!=7;
}

boolean inboundsCheck(int x, int y) {
  boolean ret=false;
  if (x>=0 && x<8 && y>=0 && y<8) {
    ret=true;
  }
  return ret;
}

void inbounds(int[][]array, int x, int y) {
  if (inboundsCheck(x, y)) {
    array[x][y]=1;
  }
}
