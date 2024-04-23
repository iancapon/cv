import processing.sound.*;
PImage[] piezas= new PImage[12];
boolean turnBord = false;
int turno = 1;//////// ->blancas
int sqrSize=50;
board juego = new board();
Cursor mano = new Cursor(0, 0);
SoundFile pieceOnBoard;
SoundFile Error;
SoundFile Capture;
SoundFile Notification;


void setup() {
  size(400, 400);

  setupPiezas(piezas);
  setupTablero(juego.tablero);
  juego.movimientosTotales();

  pieceOnBoard=new SoundFile(this, "http://images.chesscomfiles.com/chess-themes/sounds/_MP3_/default/move-self.mp3");
  Capture=new SoundFile(this, "http://images.chesscomfiles.com/chess-themes/sounds/_MP3_/default/capture.mp3");
  Error=new SoundFile(this, "./sfx/error.mp3");
  Notification=new SoundFile(this, "http://images.chesscomfiles.com/chess-themes/sounds/_MP3_/default/notify.mp3");
}


void draw() {
  drawBoard(color(255), color(0, 200, 0), flipArray(juego.tablero, turnBord), piezas);
  if (true) {
    onMouseMove();
  }
  //if (false) { bot() }

  if (mano.hand == 1) {
    drawPossible(flipArray(juego.validArray[mano.x + 8*mano.y], turnBord));
  }



  if (juego.movesLeft == 0) {
    if (turno == 1) {
      println("Gana: Negras");
    }
    if (turno == 0) {
      println("Gana: Blancas");
    }
    println("Jaquemate (o empate)");
    Notification.play();
    noLoop();
  }
}

int[] flipArray(int[]array, boolean turn) {
  int[] a=new int[64];
  if (turn) {
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++)
        a[i+j*8]=array[(7-i)+(7-j)*8];
    }
  } else {
    a=array;
  }
  return a;
}

int[]posArray(int x, int y) {
  int[]r=new int[2];
  r[0]=x;
  r[1]=y;
  return r;
}
//////////////////// INTERACCION ////////////////////////////////////////

void mouseReleased() {
  manejarClick();
}
void manejarClick() {
  boolean success = mano.click(juego.tablero, juego.turno);
  if (success) {
    int avanza = juego.moverPieza(posArray(mano.prevX, mano.prevY), posArray(mano.x, mano.y));
    if (avanza != 0 && avanza != 3) {
      turno = juego.turno;

      if (avanza==2 || avanza==4) {
        Capture.play();
      } else {
        pieceOnBoard.play();
      }
    } else {
      Error.play();
    }
  }
}
void onMouseMove() {
  if (!turnBord) {
    mano.truex = floor(mouseX / sqrSize);
    mano.truey = floor(mouseY / sqrSize);
  } else {
    mano.truex = 7 - floor(mouseX / sqrSize);
    mano.truey = 7 - floor(mouseX / sqrSize);
  }
}

///////////////// BOTS //////////////////////////


//void bot() {
//  int []piece = posArray(floor(Math.random() *8), floor(Math.random()*8 ));
//  int []move = posArray(floor(Math.random() *8), floor(Math.random() *8));
//  int avanza = juego.moverPieza(piece, move);
//  int count = 0;
//  while ((avanza == 0 || avanza == 3) && count < 10000) {
//    piece = posArray(floor(Math.random()*8 ), floor(Math.random() *8));
//    move = posArray(floor(Math.random() *8), floor(Math.random()*8 ));
//    avanza = juego.moverPieza(piece, move);
//    count++;
//  }
//  turno = juego.turno;
//  println("El bot probó " + count + " veces.");
//}
