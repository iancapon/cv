int num=2; ////                       LA MASA ES ENREALIDAD LA CARGA, MIENTRAS LA CTE G ES LA CTE K
particle[]arr=new particle[num];
particle[]flechas=new particle[40*30];
void setup() {
  size(780, 580);
  arr[0]=new particle(190, 290);
  arr[1]=new particle(590, 290);
  arr[0].m=2;
  arr[1].m=-2;
  arr[0].vy=1;
  arr[1].vy=-1;
  for (int i=0; i<40; i++) {
    for (int j=0; j<30; j++) {
      flechas[i+j*40]=new particle(i*20,j*20);
    }
  }
  //for(int i=2;i<num;i++){
  //  arr[i]=new particle(random(800),random(600));
  //  arr[i].m=random(-2,2);
  //}
}
void draw() {
  background(0);
  stroke(255);
  strokeWeight(2);
  for (int i=0; i<num; i++) {
    arr[i].superpose(arr, num);
  }
  
  for(int j=0; j<40*30; j++){
      flechas[j].superpose(arr,num);
      flechas[j].arrow();
  }
  for (int i=0; i<num; i++) {
    arr[i].refresh();
  }
}
