import processing.net.*;
import processing.sound.*;
SoundFile sonido;
sqr[] board=new sqr[64];
Cursor mano;//=new cursor
PImage[] tab=new PImage[12];
int sqrSize=60;
int turn=1;//impar->blanco; par->negro
boolean multiplayer=true;
int team=1;
boolean rotateOff=true;

void setup() {
  size(480, 480);
  println("maquina1");
  sonido=new SoundFile(this, "http://images.chesscomfiles.com/chess-themes/sounds/_MP3_/default/move-self.mp3");
  if (multiplayer) {
    team=0;
    boolean trye=initClient();
    if (!trye) {
      initServer();
      team=1;
    }
    if (team==0) {
      rotateOff=false;
    }
  }
  initBoard();
  setBoard();
  mano=new Cursor(0, 0, sqrSize);
}

void draw() {
  if (!rotateOff) {
    translate(sqrSize*8, sqrSize*8);
    rotate(PI);
  }
  stroke(0);
  drawBoard(sqrSize);
  mano.move(board);
  mano.signal();
  for (int i=0; i<8; i++) {
    if (board[i].piece==5)board[i].piece=3;
    if (board[i+7*8].piece==6)board[i+7*8].piece=4;
  }
  if (multiplayer)
    readIncomingData();
  if (multiplayer && team!=turn && dataInpBuffer[0]!=byte(-1) && dataInpBuffer[1]!=byte(-1)) {
    board[(int)dataInpBuffer[1]].piece=board[(int)dataInpBuffer[0]].piece;
    board[(int)dataInpBuffer[0]].piece=0;
    flag=(int)dataInpBuffer[2];
    if(flag!=0){
          calculateFlag();
          flag=0;
        }
    dataInpBuffer[0]=byte(-1);
    dataInpBuffer[1]=byte(-1);
    dataInpBuffer[1]=byte(0);
    if (turn==1)turn=2;
    if (turn==0)turn=1;
    if (turn==2)turn=0;
    sonido.play();
  }
}

boolean validMove(int px, int py, int x, int y) {
  boolean ret=false;
  int piece=mano.prevPiece;
  if (turn%2==piece%2 /*|| (multiplayer && turn%2==team%2 && turn%2==piece%2)*/) {
    //(SINGLE-PLAYER) ---- (MULTI-PLAYER)
    switch(piece) {
    case 1://torre blanca
      ret=torreBlanca(px, py, x, y);
      break;
    case 2://torre negra
      ret=torreNegra(px, py, x, y);
      break;
    case 3://reina blanca
      ret=reinaBlanca(px, py, x, y);
      break;
    case 4://reina negra
      ret=reinaNegra(px, py, x, y);
      break;
    case 5://peon blanco
      ret=peonBlanco(px, py, x, y);
      break;
    case 6://peon negro
      ret=peonNegro(px, py, x, y);
      break;
    case 7://rey blanco
      ret=reyBlanco(px, py, x, y);
      break;
    case 8://rey negro
      ret=reyNegro(px, py, x, y);
      break;
    case 9://alfil blanco
      ret=alfilBlanco(px, py, x, y);
      break;
    case 10://alfil negro
      ret=alfilNegro(px, py, x, y);
      break;
    case 11://caballo blanco
      ret=caballoBlanco(px, py, x, y);
      break;
    case 12://caballo negro
      ret=caballoNegro(px, py, x, y);
      break;
    }
  }
  return ret;
}
