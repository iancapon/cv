int leftRight=0;
void mousePressed() {
  if (mouseButton==LEFT)leftRight=0;
  if (mouseButton==RIGHT)leftRight=1;
}

void mouseReleased() {
  for (int i=0; i<max; i++) {
    if (array[i].type<6) {
      outletGrabCircuit(i, 0);
    }
    if (array[i].type ==6 || array[i].type ==1 || array[i].type ==2) {
      outletGrabCircuit(i, 3);
    }
    if (array[i].type >2 && array[i].type <6) {
      outletGrabCircuit(i, 1);
      outletGrabCircuit(i, 2);
    }
  }

  if (leftRight==1) {
    for (int i=0; i<max; i++) {
      int targetX=array[i].x-array[i].size/2;
      int targetY=array[i].y-array[i].size/2;
      if (array[i].type==0 && mouseX>targetX && mouseX<targetX+array[i].size && mouseY>targetY && mouseY<targetY+array[i].size) {
        array[i].outlet[0].value=!array[i].outlet[0].value;
      }
    }
  }
}

int keep=0;
boolean moving=false;
void nodeGrabCircuit(int i) {
  if (array[i].grabbed() && !moving) {
    moving=true;
    keep=i;
  }
  if (moving && keep==i) {
    array[i].move();
  }
  if (moving && keep==i && !array[i].grabbed()) {
    moving=false;
  }
}


boolean aux=false;
outlet A;
void outletGrabCircuit(int i, int j) {
  if (array[i].outlet[j].grabbed() && !aux ) {
    A=array[i].outlet[j];
    aux=true;
  }

  if (array[i].outlet[j].grabbed() && aux && array[i].outlet[j]!=A) {
    //A.coneccion(array[i].outlet[j]);
    array[i].outlet[j].coneccion(A);
    aux=false;
    
  }

  if (mousePressed && !array[i].outlet[j].grabbed()) {
    aux=false;
  }
}
