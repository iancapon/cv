void calculateFlag() {
  if (flag==1) {//enroque corto blancas
    for (int i=4; i<8; i++) {
      board[i+7*8].piece=0;
    }
    board[6+7*8].piece=7;//rey
    board[5+7*8].piece=1;//torre
  }
  if (flag==2) {//enroque largo blancas
    for (int i=4; i>=0; i--) {
      board[i+7*8].piece=0;
    }
    board[2+7*8].piece=7;//rey
    board[3+7*8].piece=1;//torre
  }
  if (flag==3) {//enroque corto negras
    for (int i=4; i<8; i++) {
      board[i+0*8].piece=0;
    }
    board[6+0*8].piece=8;//rey
    board[5+0*8].piece=2;//torre
  }
  if (flag==4) {//enroque largo negras
    for (int i=4; i>=0; i--) {
      board[i+0*8].piece=0;
    }
    board[2+0*8].piece=8;//rey
    board[3+0*8].piece=2;//torre
  }
}
