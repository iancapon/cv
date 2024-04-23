nodo[]array=new nodo[1000];
int max=1;
void setup() {
  size(800, 700);
  rectMode(CENTER);
  set_images();
  for (int i=0; i<1000; i++) {
    array[i]=new nodo(30+i*10, 30, 50, 0,i);
  }
  load_table();
}

void draw() {
  background(200);

  for (int i=0; i<max; i++) {
    nodeGrabCircuit(i);
    array[i].show();
    array[i].truth();
  }

  if (aux) {
    line(A.x, A.y, mouseX, mouseY);
  }
}



void keyPressed() {
  if (key==' ') {
    max++;    
  }
  if (key=='+') {
    if (array[max-1].type<6){
      array[max-1].type+=1;
    }
  }
  if (key=='-') {
    if (array[max-1].type>0){
      array[max-1].type-=1;
    }
  }
  if (key=='g'||key=='G') {
    save_table();
  }
}
