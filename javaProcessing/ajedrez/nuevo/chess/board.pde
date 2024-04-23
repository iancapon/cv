public class board {
  int[]tablero;
  int[][]validArray;
  int[]moved;
  int turno, movesLeft;
  public board() {
    this.tablero=new int[64];
    this.validArray=new int[64][64];
    this.moved = new int[64];
    this.turno = 1;
    for (int i = 0; i < 64; i++) {
      this.moved[i] = 0;
      int[] valid = new int[64];
      for (int j = 0; j < 64; j++) {
        valid[j] = 0;
      }
      this.validArray[i] = valid;
    }
    this.movesLeft = 100;
  }
  int getPieceFromXY(int x, int y) {
    return this.tablero[x+y*8];
  }
  int []getValidArrayFromXY(int x, int y) {
    return this.validArray[x+y*8];
  }
  void copiarBoard(board nuevo) {/////////////para copiar los elementos del objeto board
    nuevo.turno=this.turno;
    for (int i=0; i<64; i++) {
      nuevo.tablero[i]=this.tablero[i];
      nuevo.moved[i]=this.moved[i];
    }
    nuevo.movimientosTotales();
  }

  void movimientosTotales() {///////////calcula todos los movimientos totales y los pone en arreglos
    int vc = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        int[] v=this.validArray[i+j*8];
        for (int n=0; n<64; n++) {
          v[n]=0;
        }
        if (this.tablero[i + j * 8] % 2 == this.turno % 2 && this.tablero[i + j * 8] != 0) {
          int[] pos = new int[2];
          pos[0]=i;
          pos[1]=j;
          vc += this.movimientosPosibles(this.tablero, pos, this.validArray[i + j * 8]);
        }
      }
    }
    this.movesLeft = vc;
  }


  int moverPieza(int[]pos, int[]nextPos) {////////si el movimiento se encuentra en su arreglo valid, lo ejecuta
    int sucess = 0;
    int x = pos[0];
    int y = pos[1];
    int piece = this.tablero[x + y * 8];
    int[] valid = this.validArray[x + y * 8];
    int nx = nextPos[0];
    int ny = nextPos[1];
    if (piece!=0 && piece%2==this.turno && valid[nx + ny * 8] != 0 && valid[nx + ny * 8] != 3 && piece % 2 == this.turno) {
      this.tablero[x + y * 8] = 0;
      this.tablero[nx + ny * 8] = piece;
      this.moved[x + y * 8]++;
      this.moved[nx + ny * 8]++;
      if (valid[nx + ny * 8] == 4 || valid[nx + ny * 8] == 5) {/////enroque, en passant
        if (valid[nx + ny * 8] == 4) {
          this.tablero[nx + y * 8] = 0;
          this.moved[nx + y * 8]++;
        }
        if (valid[nx + ny * 8] == 5) {
          int torre = this.tablero[0 + 7 * 8 * this.turno];
          if (nx == 2) {//izquierdo
            this.tablero[0 + 7 * 8 * this.turno] = 0;
            this.tablero[3 + 7 * 8 * this.turno] = torre;
            this.moved[0 + 7 * 8 * this.turno]++;
            this.moved[3 + 7 * 8 * this.turno]++;
          }
          if (nx == 6) {//derecho
            this.tablero[7 + 7 * 8 * this.turno] = 0;
            this.tablero[5 + 7 * 8 * this.turno] = torre;
            this.moved[7 + 7 * 8 * this.turno]++;
            this.moved[5 + 7 * 8 * this.turno]++;
          }
        }
      }
      if (piece == 6 - this.turno % 2 && (ny == 0 || ny == 7)) {//peon llega al final
        this.tablero[nx + ny * 8] = 4 - this.turno % 2;
      }
      sucess = valid[nx + ny * 8];
      if (this.turno == 1) {
        this.turno = 2;
      }
      if (this.turno == 0) {
        this.turno = 1;
      }
      if (this.turno == 2) {
        this.turno = 0;
      }
      this.movimientosTotales();
    }
    return sucess;
  }

  int movimientosPosibles(int[]tablero, int[] pos, int[] valid) {///pos es un array de x,y
    int x = pos[0];
    int y = pos[1];
    int piece = tablero[x + y * 8];
    int turn = piece % 2;
    int ret = 0;
    if (piece != 0) {
      switch (piece) {
      case 1:
        ret += this.torre(tablero, pos, valid);
        break;
      case 2:
        ret += this.torre(tablero, pos, valid);
        break;
      case 3:
        ret += this.reina(tablero, pos, valid);
        break;
      case 4:
        ret += this.reina(tablero, pos, valid);
        break;
      case 5:
        ret += this.peon(tablero, pos, valid);
        break;
      case 6:
        ret += this.peon(tablero, pos, valid);
        break;
      case 7:
        ret += this.rey(tablero, pos, valid);
        break;
      case 8:
        ret += this.rey(tablero, pos, valid);
        break;
      case 9:
        ret += this.alfil(tablero, pos, valid);
        break;
      case 10:
        ret += this.alfil(tablero, pos, valid);
        break;
      case 11:
        ret += this.caballo(tablero, pos, valid);
        break;
      case 12:
        ret += this.caballo(tablero, pos, valid);
        break;
      }
    }

    for (int i = 0; i < 64; i++) {
      if (valid[i] != 0) {
        if (tablero[i] % 2 == turn % 2 && tablero[i] != 0) {
          valid[i] = 0;
          ret--;
        }
        if (tablero[i] != 0 && tablero[i] % 2 != piece % 2) {
          valid[i] = 2;
        }
        if (tablero[i] != 0 && tablero[i] == 7 + piece % 2) {
          valid[i] = 3;
          ret--;
        }
      }
      if (valid[i] == 1 || valid[i] == 2) {///// 4 y 5 lo hace en peon y rey (enpassant y enroque)
        int[] nextTablero = new int[64];
        int[] kingPos = new int[2];
        for (int j = 0; j < 8; j++) {
          for (int k = 0; k < 8; k++) {
            nextTablero[j + k * 8] = tablero[j + k * 8];
            if (tablero[j + k * 8] == 8 - turn) {
              //int[] kingPos = new int[2];
              kingPos[0]=j;
              kingPos[1]=k;
            }
          }
        }
        nextTablero[x + y * 8] = 0;
        nextTablero[i] = piece;
        if (piece == 8 - turn) {
          this.getPos(i, kingPos);
        }
        if (this.jaque(nextTablero, kingPos)) {/////si es verdadero: valid[i]=0
          valid[i] = 0;
          ret--;
        }
      }
    }
    return ret;////numero de movimientos posibles
  }

  void getPos(int i, int[] pos) {
    int y = 0;
    int x = i - y * 8;
    while (x < 0 || x > 7) {
      y++;
      x = i - y * 8;
    }
    pos[0] = x;
    pos[1] = y;
  }

  boolean jaque(int[]tablero, int[] pos) {
    boolean check = false;
    int team = tablero[pos[0] + 8 * pos[1]] % 2;
    int[] valid =new int[64];
    for (int i = 0; i < 64; i++) {
      valid[i] = 0;
    }
    this.lineaRecta(tablero, valid, pos[0], pos[1], team);
    for (int i = 0; i < 64; i++) {
      if (valid[i] != 0 && (tablero[i] == 1 + team || tablero[i] == 3 + team)) {//torre y reina
        check = true;
        break;
      }
    }
    if (!check) {
      for (int i = 0; i < 64; i++) {
        valid[i] = 0;
      }
      this.diagonal(tablero, valid, pos[0], pos[1], team);
      for (int i = 0; i < 64; i++) {
        if (valid[i] != 0 && (tablero[i] == 9 + team || tablero[i] == 3 + team)) {//alfil y reina
          check = true;
          break;
        }
      }
    }
    if (!check) {
      for (int i = 0; i < 64; i++) {
        valid[i] = 0;
      }
      this.movimientoPeon(tablero, valid, pos[0], pos[1], team);
      for (int i = 0; i < 64; i++) {
        if (valid[i] != 0 && (tablero[i] == 5 + team)) {//peon
          check = true;
          break;
        }
      }
    }
    if (!check) {
      for (int i = 0; i < 64; i++) {
        valid[i] = 0;
      }
      this.caballo(tablero, pos, valid);
      for (int i = 0; i < 64; i++) {
        if (valid[i] != 0 && (tablero[i] == 11 + team)) {//caballo
          check = true;
          break;
        }
      }
    }
    if (!check) {
      for (int i = 0; i < 64; i++) {
        valid[i] = 0;
      }
      this.movimientoRey(tablero, valid, pos[0], pos[1], team);
      for (int i = 0; i < 64; i++) {
        if (valid[i] != 0 && (tablero[i] == 7 + team)) {//caballo
          check = true;
          break;
        }
      }
    }

    return check;
  }

  int peon(int[]tablero, int[] pos, int[] valid) {
    int px = pos[0];
    int py = pos[1];
    int piece = tablero[px + py * 8];
    int turn = piece % 2;
    int dir = (1 - 2 * turn);
    int vc = 0;

    vc += this.movimientoPeon(tablero, valid, px, py, turn);
    /////////////////////// COMER AL PASO
    if (this.inboundsCheck(px - 1, py + dir) && tablero[px - 1 + (py) * 8] == 5 + turn && tablero[px - 1 + (py + dir) * 8] == 0) {
      vc += this.inbounds(valid, px - 1, py + dir);
      valid[(px - 1) + 8 * (py + dir)] = 4;
      //////
      int[] nextTablero =new int[64];
      int[] kingPos =new int [2];
      for (int j = 0; j < 8; j++) {
        for (int k = 0; k < 8; k++) {
          nextTablero[j + k * 8] = tablero[j + k * 8];
          if (tablero[j + k * 8] == 8 - turn) {
            kingPos[0]=j;
            kingPos[1]=k;
          }
        }
      }
      nextTablero[px + py * 8] = 0;
      nextTablero[px - 1 + (py) * 8] = 0;
      nextTablero[(px - 1) + 8 * (py + dir)] = piece;

      if (this.jaque(nextTablero, kingPos)) {/////si es verdadero: valid[i]=0
        valid[(px - 1) + 8 * (py + dir)] = 0;
        vc--;
        //console.log("situacion 1")
      }
      ///////
    }
    if (this.inboundsCheck(px + 1, py + dir) && tablero[px + 1 + (py) * 8] == 5 + turn && tablero[px + 1 + (py + dir) * 8] == 0) {
      vc += this.inbounds(valid, px + 1, py + dir);
      valid[(px + 1) + 8 * (py + dir)] = 4;
      //////
      int[] nextTablero =new int[64];
      int[] kingPos =new int [2];
      for (int j = 0; j < 8; j++) {
        for (int k = 0; k < 8; k++) {
          nextTablero[j + k * 8] = tablero[j + k * 8];
          if (tablero[j + k * 8] == 8 - turn) {
            kingPos[0]=j;
            kingPos[1]= k;
          }
        }
      }
      nextTablero[px + py * 8] = 0;
      nextTablero[px + 1 + (py) * 8] = 0;
      nextTablero[(px + 1) + 8 * (py + dir)] = piece;

      if (this.jaque(nextTablero, kingPos)) {/////si es verdadero: valid[i]=0
        valid[(px + 1) + 8 * (py + dir)] = 0;
        vc--;
      }
      ///////
    }
    return vc;
  }

  int torre(int[]tablero, int[] pos, int[] valid) {
    int px = pos[0];
    int py = pos[1];
    int turn = tablero[px + py * 8] % 2;
    int vc = 0;
    vc += this.lineaRecta(tablero, valid, px, py, turn);

    return vc;
  }

  int reina(int[] tablero, int[]pos, int[] valid) {
    int px = pos[0];
    int py = pos[1];
    int turn = tablero[px + py * 8] % 2;
    int vc = 0;
    vc += this.diagonal(tablero, valid, px, py, turn);
    vc += this.lineaRecta(tablero, valid, px, py, turn);

    return vc;
  }

  int rey(int[] tablero, int[]pos, int[] valid) {
    int px = pos[0];
    int py = pos[1];
    int piece = tablero[px + py * 8];
    int turn = piece % 2;
    int vc = 0;

    vc+=this.movimientoRey(tablero, valid, px, py, turn);

    ////////////////////enroque
    if (tablero[4 + 8 * 7 * turn] == 8 - turn && this.moved[4 + 8 * 7 * turn] == 0) {////rey
      if (tablero[0 + 8 * 7 * turn] == 2 - turn && this.moved[0 + 8 * 7 * turn] == 0) {//torre izquierda
        if (tablero[1 + 8 * 7 * turn] == 0 && tablero[2 + 8 * 7 * turn] == 0 && tablero[3 + 8 * 7 * turn] == 0) {// si está vacio
          /////////
          int ok = 0;
          for (int n = 0; n < 2; n++) {
            int[] nextTablero =new int[64];
            int[] kingPos =new int [2];
            for (int j = 0; j < 8; j++) {
              for (int k = 0; k < 8; k++) {
                nextTablero[j + k * 8] = tablero[j + k * 8];
                if (tablero[j + k * 8] == 8 - turn) {
                  kingPos[0]=j;
                  kingPos[1]= k;
                }
              }
            }
            nextTablero[4 + 8 * 7 * turn] = 0;
            int i = 4 + 8 * 7 * turn - (n + 1);
            nextTablero[i] = piece;
              if (piece == 8 - turn) {
              this.getPos(i, kingPos);
            }
            if (!this.jaque(nextTablero, kingPos)) {/////si es verdadero: valid[i]=0
              ok++;
            }
          }
          ///////////
          if (ok == 2) {
            vc += 1;
            valid[px - 2 + py * 8] = 5;
          }
        }
      }
      if (tablero[7 + 8 * 7 * turn] == 2 - turn && this.moved[7 + 8 * 7 * turn] == 0) {//torre derecha
        if (tablero[6 + 8 * 7 * turn] == 0 && tablero[5 + 8 * 7 * turn] == 0) {// si está vacio
          /////////
          int ok = 0;
          for (int n = 0; n < 2; n++) {
            int[] nextTablero =new int[64];
            int[] kingPos =new int [2];
            for (int j = 0; j < 8; j++) {
              for (int k = 0; k < 8; k++) {
                nextTablero[j + k * 8] = tablero[j + k * 8];
                if (tablero[j + k * 8] == 8 - turn) {
                  kingPos[0]=j;
                  kingPos[1]= k;
                }
              }
            }
            nextTablero[4 + 8 * 7 * turn] = 0;
            int i = 4 + 8 * 7 * turn + (n + 1);
            nextTablero[i] = piece;
            if (piece == 8 - turn) {
              this.getPos(i, kingPos);
            }
            if (!this.jaque(nextTablero, kingPos)) {/////si es verdadero: valid[i]=0
              ok++;
            }
          }
          ///////////
          if (ok == 2) {
            vc += 1;
            valid[px + 2 + py * 8] = 5;
          }
        }
      }
    }
    return vc;
  }

  int movimientoRey(int[]tablero,int[] valid, int px, int py,int turn) {
    int vc=0;
    vc += this.inbounds(valid, px, py - 1);
    vc += this.inbounds(valid, px - 1, py - 1);
    vc += this.inbounds(valid, px + 1, py - 1);
    vc += this.inbounds(valid, px - 1, py);
    vc += this.inbounds(valid, px + 1, py);
    vc += this.inbounds(valid, px, py + 1);
    vc += this.inbounds(valid, px - 1, py + 1);
    vc += this.inbounds(valid, px + 1, py + 1);
    return vc;
  }
  int alfil(int[] tablero, int[]pos, int[] valid) {
    int px = pos[0];
    int py = pos[1];
    int turn = tablero[px + py * 8] % 2;

    int vc = this.diagonal(tablero, valid, px, py, turn);

    return vc;
  }
  int caballo(int[] tablero, int[]pos, int[] valid) {
    int px = pos[0];
    int py = pos[1];
    int vc = 0;

    vc += this.inbounds(valid, px - 2, py - 1);
    vc += this.inbounds(valid, px - 1, py - 2);
    vc += this.inbounds(valid, px - 2, py + 1);
    vc += this.inbounds(valid, px - 1, py + 2);
    vc += this.inbounds(valid, px + 1, py - 2);
    vc += this.inbounds(valid, px + 2, py - 1);
    vc += this.inbounds(valid, px + 2, py + 1);
    vc += this.inbounds(valid, px + 1, py + 2);

    return vc;
  }

  int movimientoPeon(int[] tablero, int[] valid, int px, int py, int turn) {
    int dir = (1 - 2 * turn);
    int st = 6;
    if (dir > 0) {
      st = 1;
    }

    int vc=0;
    if (this.inboundsCheck(px, py + dir) && tablero[px + (py + dir) * 8] == 0) {//avanzar 1
      vc += this.inbounds(valid, px, py + dir);
      if (this.inboundsCheck(px, py + dir * 2) && tablero[px + (py + dir * 2) * 8] == 0 && py == st) {//avenzar 2
        vc += this.inbounds(valid, px, py + dir * 2);
      }
    }
    ////// COMER NORMAL
    if (this.inboundsCheck(px - 1, py + dir) && tablero[px - 1 + (py + dir) * 8] % 2 != turn % 2 && tablero[px - 1 + (py + dir) * 8] != 0) {
      vc += this.inbounds(valid, px - 1, py + dir);
    }
    if (this.inboundsCheck(px + 1, py + dir) && tablero[px + 1 + (py + dir) * 8] % 2 != turn % 2 && tablero[px + 1 + (py + dir) * 8] != 0) {
      vc += this.inbounds(valid, px + 1, py + dir);
    }
    return vc;
  }

  int diagonal(int[]tablero, int[] valid, int px, int py, int team) {
    ////////esquina 1
    int ii = px + 1;
    int jj = py + 1;
    int vc = 0;

    while (ii < 8 && jj < 8) {
      vc += this.inbounds(valid, ii, jj);
      if (tablero[ii + jj * 8] > 0) {
        if (tablero[ii + jj * 8] % 2 != team % 2) {
          break;
        }
        if (tablero[ii + jj * 8] % 2 == team % 2) {
          valid[ii + 8 * jj] = 0;
          vc--;
          break;
        }
      }
      ii++;
      jj++;
    }
    ////////esquina 2
    ii = px - 1;
    jj = py - 1;
    while (ii >= 0 && jj >= 0) {
      vc += this.inbounds(valid, ii, jj);
      if (tablero[ii + jj * 8] > 0) {
        if (tablero[ii + jj * 8] % 2 != team % 2) {
          break;
        }
        if (tablero[ii + jj * 8] % 2 == team % 2) {
          valid[ii + 8 * jj] = 0;
          vc--;
          break;
        }
      }
      ii--;
      jj--;
    }

    ////////esquina 3
    ii = px + 1;
    jj = py - 1;
    while (ii < 8 && jj >= 0) {
      vc += this.inbounds(valid, ii, jj);
      if (tablero[ii + jj * 8] > 0) {
        if (tablero[ii + jj * 8] % 2 != team % 2) {
          break;
        }
        if (tablero[ii + jj * 8] % 2 == team % 2) {
          valid[ii + 8 * jj] = 0;
          vc--;
          break;
        }
      }
      ii++;
      jj--;
    }
    ////////esquina 4
    ii = px - 1;
    jj = py + 1;
    while (ii >= 0 && jj < 8) {
      vc += this.inbounds(valid, ii, jj);
      if (tablero[ii + jj * 8] > 0) {
        if (tablero[ii + jj * 8] % 2 != team % 2) {
          break;
        }
        if (tablero[ii + jj * 8] % 2 == team % 2) {
          valid[ii + 8 * jj] = 0;
          vc--;
          break;
        }
      }
      ii--;
      jj++;
    }
    return vc;
  }

  int lineaRecta(int[]tablero, int[] valid, int px, int py, int team) {
    int vc = 0;
    ////////linea recta en x
    for (int i = px + 1; i < 8; i++) {
      vc += this.inbounds(valid, i, py);
      if (tablero[i + py * 8] > 0) {
        if (tablero[i + py * 8] % 2 != team % 2) {
          break;
        }
        if (tablero[i + py * 8] % 2 == team % 2) {
          valid[i + 8 * py] = 0;
          vc--;
          break;
        }
      }
    }
    for (int i = px - 1; i >= 0; i--) {
      vc += this.inbounds(valid, i, py);
      if (tablero[i + py * 8] > 0) {
        if (tablero[i + py * 8] % 2 != team % 2) {
          break;
        }
        if (tablero[i + py * 8] % 2 == team % 2) {
          valid[i + 8 * py] = 0;
          vc--;
          break;
        }
      }
    }

    ////////linea recta en y
    for (int j = py + 1; j < 8; j++) {
      vc += this.inbounds(valid, px, j);
      if (tablero[px + j * 8] > 0) {
        if (tablero[px + j * 8] % 2 != team % 2) {
          break;
        }
        if (tablero[px + j * 8] % 2 == team % 2) {
          valid[px + 8 * j] = 0;
          vc--;
          break;
        }
      }
    }
    for (int j = py - 1; j >= 0; j--) {
      vc += this.inbounds(valid, px, j);
      if (tablero[px + j * 8] > 0) {
        if (tablero[px + j * 8] % 2 != team % 2) {
          break;
        }
        if (tablero[px + j * 8] % 2 == team % 2) {
          valid[px + 8 * j] = 0;
          vc--;
          break;
        }
      }
    }
    return vc;
  }
  ////////////////////
  boolean inboundsCheck(int x, int y) {
    boolean ret = false;
    if (x >= 0 && x < 8 && y >= 0 && y < 8) {
      ret = true;
    }
    return ret;
  }

  int inbounds(int[]array, int x, int y) {
    int vc = 0;
    if (this.inboundsCheck(x, y)) {
      array[x + y * 8] = 1;
      vc = 1;
    }
    return vc;
  }
}
